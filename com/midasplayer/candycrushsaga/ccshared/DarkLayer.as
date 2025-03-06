package com.midasplayer.candycrushsaga.ccshared
{
   import flash.display.*;
   import main.*;
   
   public class DarkLayer extends MovieClip
   {
      private static var _clips:Array;
      
      public function DarkLayer()
      {
         super();
      }
      
      public static function addDarkLayer(param1:MovieClip) : MovieClip
      {
         if(_clips == null)
         {
            _clips = new Array();
         }
         var _loc_2:* = new DarkLayerClip();
         _loc_2.mouseEnabled = true;
         var _loc_3:* = param1.parent.getChildIndex(param1);
         param1.parent.addChildAt(_loc_2,_loc_3);
         _clips.push(_loc_2);
         return _loc_2;
      }
      
      public static function removeDarkLayer(param1:MovieClip) : void
      {
         var _loc_3:MovieClip = null;
         var _loc_2:uint = 0;
         while(_loc_2 < _clips.length)
         {
            _loc_3 = _clips[_loc_2];
            if(_loc_3.parent != null)
            {
               if(_loc_3.parent == param1.parent)
               {
                  _loc_3.parent.removeChild(_loc_3);
                  _loc_3 = null;
                  _clips.splice(_loc_2,1);
               }
            }
            _loc_2 += 1;
         }
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

