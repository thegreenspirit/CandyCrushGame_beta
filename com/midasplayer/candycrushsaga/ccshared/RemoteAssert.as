package com.midasplayer.candycrushsaga.ccshared
{
   import com.king.platform.client.ClientHealthTracking;
   import com.midasplayer.candycrushsaga.game.Constants;
   import com.midasplayer.debug.Debug;
   import com.midasplayer.debug.IAssertHandler;
   import flash.system.Capabilities;
   
   public class RemoteAssert implements IAssertHandler
   {
      private const MAX_AMOUNT_OF_REPORTS:int = 5;
      
      private var _reportedAsserts:int = 0;
      
      private var _clientHealthTracking:ClientHealthTracking;
      
      private var _alreadySentMessages:Vector.<String> = new Vector.<String>();
      
      public function RemoteAssert(param1:ClientHealthTracking)
      {
         super();
         this._clientHealthTracking = param1;
      }
      
      public function assert(param1:String) : void
      {
         var devMsg:String = null;
         var message:String = param1;
         try
         {
            devMsg = this._createMessage(message);
            if(this._isSandBoxViolationError(devMsg) || this._isTimeoutError(devMsg))
            {
               this._reportedAsserts = Math.max(this._reportedAsserts,this.MAX_AMOUNT_OF_REPORTS - 1);
            }
            Console.println(devMsg,"assert",16742263);
            this._sendAssertToServer(devMsg);
         }
         catch(e:Error)
         {
            Console.println("Could not report assert to server: " + e.message);
         }
      }
      
      private function _createMessage(param1:String) : String
      {
         var _loc2_:String = Debug.formatStackTrace(new Error("Assert").getStackTrace());
         var _loc3_:String = _loc2_ != "" ? _loc2_ : " [not debug player] ";
         var _loc4_:String = "OS:" + Capabilities.os + " FP:" + Capabilities.version;
         return "(" + Constants.VERSION + ") " + _loc4_ + "\n" + (param1 != null ? param1 : "") + "\n" + _loc3_;
      }
      
      private function _isSandBoxViolationError(param1:String) : Boolean
      {
         return param1.indexOf("#2060") != -1;
      }
      
      private function _isTimeoutError(param1:String) : Boolean
      {
         return param1.indexOf("#1502") != -1;
      }
      
      private function _sendAssertToServer(param1:String) : void
      {
         var devMsg:String = param1;
         if(this._clientHealthTracking == null)
         {
            return;
         }
         if(this.haveAlreadySentMessage(devMsg))
         {
            return;
         }
         if(this._reportedAsserts++ >= this.MAX_AMOUNT_OF_REPORTS)
         {
            return;
         }
         this._clientHealthTracking.clientException2(1,devMsg,function():void
         {
         },function():void
         {
         });
         this.rememberAlreadySentMessage(devMsg);
      }
      
      private function haveAlreadySentMessage(param1:String) : Boolean
      {
         return this._alreadySentMessages.indexOf(param1) != -1;
      }
      
      private function rememberAlreadySentMessage(param1:String) : void
      {
         this._alreadySentMessages.push(param1);
      }
   }
}

