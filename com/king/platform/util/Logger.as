package com.king.platform.util
{
   import flash.utils.Dictionary;
   
   public class Logger
   {
      public static const DEBUG:int = 0;
      
      public static const INFO:int = 1;
      
      public static const WARN:int = 2;
      
      public static const ERROR:int = 3;
      
      private static var outputs:Dictionary = new Dictionary();
      
      public function Logger()
      {
         super();
      }
      
      public static function error(param1:Object) : void
      {
         output("[ERROR] " + param1,ERROR);
      }
      
      public static function warn(param1:Object) : void
      {
         output("[WARNING] " + param1,WARN);
      }
      
      public static function info(param1:Object) : void
      {
         output("[INFO] " + param1,INFO);
      }
      
      public static function debug(param1:Object) : void
      {
         output("[DEBUG] " + param1,DEBUG);
      }
      
      public static function addLoggerOutput(param1:ILoggerOutput, param2:int = 1) : void
      {
         outputs[param1] = param2;
      }
      
      private static function output(param1:String, param2:int) : void
      {
         var _loc3_:Object = null;
         trace(param1);
         for(_loc3_ in outputs)
         {
            if(param2 >= outputs[_loc3_])
            {
               (_loc3_ as ILoggerOutput).output(param1);
            }
         }
      }
   }
}

