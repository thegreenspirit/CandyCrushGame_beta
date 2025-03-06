package com.midasplayer.candycrushsaga.ccshared
{
   import flash.events.*;
   import flash.net.*;
   
   public class LocalStorage
   {
      private static var so:SharedObject;
      
      private static var callback:Function;
      
      public function LocalStorage()
      {
         super();
      }
      
      public static function setCookie(param1:String, param2:*, param3:int, param4:Function) : void
      {
         callback = param4;
         so = SharedObject.getLocal(param1);
         if(!so.data.cookieArr)
         {
            so.data.cookieArr = [];
         }
         var _loc_5:* = getCookie(param1,param2);
         if(getCookie(param1,param2) == null)
         {
            _loc_5 = new CookieObjectVO();
            so.data.cookieArr.push(_loc_5);
         }
         _loc_5.value = param2;
         var _loc_6:* = new Date().getTime();
         if(Boolean(param3))
         {
            _loc_5.ttl = param3 + _loc_6;
            _loc_5.expired = false;
         }
         saveToDisk();
      }
      
      public static function getCookie(param1:String, param2:*) : Object
      {
         var _loc_4:Object = null;
         var _loc_6:int = 0;
         so = SharedObject.getLocal(param1);
         var _loc_3:* = so.data.cookieArr;
         if(!_loc_3)
         {
            _loc_3 = [];
         }
         var _loc_5:* = new Date().getTime();
         while(_loc_6 < _loc_3.length)
         {
            _loc_4 = _loc_3[_loc_6];
            if(_loc_4.ttl < _loc_5)
            {
               _loc_4.expired = true;
            }
            if(param2 == _loc_4.value)
            {
               return _loc_4;
            }
            _loc_6++;
         }
         return null;
      }
      
      private static function saveToDisk() : void
      {
         var flushStatus:String = null;
         try
         {
            flushStatus = so.flush();
         }
         catch(error:Error)
         {
            Console.println("@ saveToDisk() - Localstorage.as | Error...Could not write SharedObject to disk");
         }
         if(flushStatus != null)
         {
            Console.println("@ saveToDisk() - Localstorage.as | flushStatus: " + flushStatus);
            switch(flushStatus)
            {
               case SharedObjectFlushStatus.PENDING:
                  Console.println("Requesting permission to save object...");
                  so.addEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
                  break;
               case SharedObjectFlushStatus.FLUSHED:
                  Console.println("Value flushed to disk.");
                  callback(true);
            }
         }
      }
      
      private static function onFlushStatus(event:NetStatusEvent) : void
      {
         Console.println("User closed permission dialog...");
         switch(event.info.code)
         {
            case "SharedObject.Flush.Success":
               Console.println("User granted permission -- value saved.");
               callback(true);
               break;
            case "SharedObject.Flush.Failed":
               Console.println("User denied permission -- value not saved.");
               callback(false);
         }
         event.currentTarget.removeEventListener(NetStatusEvent.NET_STATUS,onFlushStatus);
      }
   }
}

