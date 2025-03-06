package com.midasplayer.candycrushsaga.ccshared
{
   import flash.display.Sprite;
   
   public class Console extends Sprite
   {
      public function Console()
      {
         super();
      }
      
      public static function println(value:String, ... args) : void
      {
         trace(value);
      }
      
      public static function registerProcessor(... args) : void
      {
      }
      
      public static function unRegisterProcessor(value:String, ... args) : void
      {
         trace(value + args.toString());
      }
      
      public static function disablePrintCategory(... args) : void
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

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;

