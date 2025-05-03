package com.midasplayer.debug
{
   public class Debug
   {
      private static var s_assertHandler:IAssertHandler = null;
      
      public function Debug()
      {
         super();
      }
      
      public static function assert(param1:Boolean, param2:String = null) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            return;
         }
         if(s_assertHandler != null)
         {
            s_assertHandler.assert(param2);
         }
         else
         {
            _loc3_ = formatStackTrace(new Error().getStackTrace());
            trace("Assertion failed" + (!!param2 ? ": " + param2 : "") + (_loc3_.length > 0 ? "\n" + _loc3_ : ""));
         }
      }
      
      public static function setAssertHandler(param1:IAssertHandler) : void
      {
         s_assertHandler = param1;
      }
      
      public static function formatStackTrace(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:int = int(param1.indexOf("\n"));
         if(_loc2_ == -1)
         {
            return param1;
         }
         if(_loc2_ + 1 >= param1.length)
         {
            return param1;
         }
         _loc2_ = int(param1.indexOf("\n",_loc2_ + 1));
         if(_loc2_ == -1)
         {
            return param1;
         }
         if(_loc2_ + 1 >= param1.length)
         {
            return param1;
         }
         return param1.substring(_loc2_ + 1);
      }
   }
}

