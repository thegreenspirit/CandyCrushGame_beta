package com.king.platform.events
{
   import flash.events.Event;
   
   public class ErrorEvent extends Event
   {
      public static const FATAL:String = "ErrorEvent.FATAL";
      
      public static const RECOVERABLE:String = "ErrorEvent.RECOVERABLE";
      
      public static const RECOVERY:String = "ErrorEvent.RECOVERY";
      
      private var _msg:String;
      
      public function ErrorEvent(param1:String, param2:String)
      {
         super(param1);
         this._msg = param2;
      }
      
      public function get message() : String
      {
         return this._msg;
      }
   }
}

