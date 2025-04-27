package com.midasplayer.console
{
   import flash.display.Sprite;
   
   public class Console extends Sprite
   {
      public function Console()
      {
         super();
      }
      
      public static function println(param1:String, ... rest) : void
      {
         trace(param1);
      }
      
      public static function registerProcessor(... rest) : void
      {
      }
      
      public static function unRegisterProcessor(param1:String, ... rest) : void
      {
         trace(param1 + rest.toString());
      }
      
      public static function disablePrintCategory(... rest) : void
      {
      }
      
      public static function activate() : void
      {
      }
      
      public static function deactivate() : void
      {
      }
      
      public static function isActivated() : Boolean
      {
         return false;
      }
   }
}

