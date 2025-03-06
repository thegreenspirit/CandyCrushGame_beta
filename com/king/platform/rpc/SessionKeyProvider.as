package com.king.platform.rpc
{
   public class SessionKeyProvider
   {
      private var _sessionKey:String;
      
      private var _callbacks:Vector.<Function> = new Vector.<Function>();
      
      public function SessionKeyProvider(param1:String)
      {
         super();
         this._sessionKey = param1;
      }
      
      public function get sessionKey() : String
      {
         return this._sessionKey;
      }
      
      public function set sessionKey(param1:String) : void
      {
         var _loc2_:Function = null;
         this._sessionKey = param1;
         for each(_loc2_ in this._callbacks)
         {
            _loc2_(param1);
         }
      }
      
      public function watch(param1:Function) : void
      {
         this._callbacks.push(param1);
      }
   }
}

