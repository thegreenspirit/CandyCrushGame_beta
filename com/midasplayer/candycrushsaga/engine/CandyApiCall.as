package com.midasplayer.candycrushsaga.engine
{
   import com.midasplayer.debug.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class CandyApiCall
   {
      private var _url:String;
      
      private var _variables:URLVariables;
      
      private var _tries:int;
      
      private var _onCompleteCallback:Function;
      
      private var _onIOErrorCallback:Function;
      
      private var _callbackObject:Object;
      
      public function CandyApiCall(param1:String, param2:URLVariables, param3:Function, param4:Function, param5:int, param6:Object = null)
      {
         super();
         Debug.assert(param1 != null,"Creating a candy api call with no url.");
         Debug.assert(param5 > 0,"Trying to create a candy api call with no tries.");
         this._url = param1;
         this._variables = param2;
         this._onCompleteCallback = param3;
         this._onIOErrorCallback = param4;
         this._tries = param5;
         this._callbackObject = param6;
      }
      
      public function call() : void
      {
         var _loc_1:* = new URLRequest(this._url);
         _loc_1.data = this._variables;
         _loc_1.method = URLRequestMethod.GET;
         var _loc_2:* = new URLLoader();
         _loc_2.addEventListener(Event.COMPLETE,this._onComplete);
         _loc_2.addEventListener(IOErrorEvent.IO_ERROR,this._onIOError);
         _loc_2.load(_loc_1);
      }
      
      private function _onComplete(event:Event) : void
      {
         var _loc_2:URLLoader = null;
         this._cleanup(event.target as URLLoader);
         if(this._onCompleteCallback != null)
         {
            _loc_2 = event.target as URLLoader;
            this._onCompleteCallback(_loc_2.data,this._callbackObject);
         }
      }
      
      private function _onIOError(event:IOErrorEvent) : void
      {
         this._cleanup(event.target as URLLoader);
         var _loc_2:* = this;
         _loc_2._tries = this._tries - 1;
         if(--this._tries > 0)
         {
            setTimeout(this.call,1000);
         }
         else if(this._onIOErrorCallback != null)
         {
            this._onIOErrorCallback(event,this._callbackObject);
         }
      }
      
      private function _cleanup(param1:URLLoader) : void
      {
         param1.removeEventListener(Event.COMPLETE,this._onComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this._onIOError);
      }
   }
}

