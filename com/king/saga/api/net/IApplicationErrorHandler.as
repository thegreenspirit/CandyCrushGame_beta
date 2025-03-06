package com.king.saga.api.net
{
   import flash.events.IOErrorEvent;
   
   public interface IApplicationErrorHandler
   {
      function onNetError(param1:IOErrorEvent, param2:String) : void;
      
      function onError(param1:Error, param2:String) : void;
   }
}

