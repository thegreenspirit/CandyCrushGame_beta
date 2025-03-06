package com.king.saga.api.tracking
{
   import com.king.saga.api.net.IApplicationErrorHandler;
   import com.midasplayer.net.ApiCall;
   import flash.events.IOErrorEvent;
   import flash.net.URLVariables;
   
   public class GuiTracker
   {
      private var _apiUrl:String;
      
      private var _session:String;
      
      private var _errorHandler:IApplicationErrorHandler;
      
      public function GuiTracker(param1:String, param2:String, param3:IApplicationErrorHandler)
      {
         super();
         this._apiUrl = param1;
         this._session = param2;
         this._errorHandler = param3;
         if(this._apiUrl.length > 0 && this._apiUrl.substring(this._apiUrl.length - 1,1) != "/")
         {
            this._apiUrl += "/";
         }
      }
      
      public function trackShow_Popup(param1:String) : void
      {
         this._call("GuiShown",[param1],this._onCallSuccess);
      }
      
      public function trackClose_PopupWithButton(param1:String, param2:String) : void
      {
         this._call("GuiLeft",[param1,param2],this._onCallSuccess);
      }
      
      public function trackInteract_PopupWithButton(param1:String, param2:String) : void
      {
         this._call("GuiInteraction",[param1,param2],this._onCallSuccess);
      }
      
      public function CustomFunnel(param1:String, param2:String, param3:Number) : void
      {
         this._call("CustomFunnel",[param1,param2,param3],this._onCallSuccess);
      }
      
      private function _onCallSuccess(param1:String, param2:Object) : void
      {
      }
      
      private function _onIOError(param1:IOErrorEvent, param2:Object) : void
      {
         this._errorHandler.onNetError(param1,"Something went wrong in GuiTracking api.");
      }
      
      private function _call(param1:String, param2:Array, param3:Function) : void
      {
         var _loc4_:URLVariables = new URLVariables();
         _loc4_._session = this._session;
         var _loc5_:int = 0;
         while(_loc5_ < param2.length)
         {
            _loc4_["arg" + _loc5_] = param2[_loc5_];
            _loc5_++;
         }
         var _loc6_:ApiCall = new ApiCall(this._apiUrl + param1,_loc4_,param3,this._onIOError,3,null);
         _loc6_.call();
      }
   }
}

