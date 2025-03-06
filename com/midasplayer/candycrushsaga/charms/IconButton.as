package com.midasplayer.candycrushsaga.charms
{
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.BasicButton;
   import flash.display.MovieClip;
   
   public class IconButton extends BasicButton
   {
      protected var _text:String;
      
      private var _id:String;
      
      public function IconButton(param1:Function, param2:MovieClip)
      {
         super(param2,param1);
      }
      
      public function setId(param1:String) : void
      {
         this._id = param1;
      }
      
      public function getId() : String
      {
         return this._id;
      }
   }
}

import com.midasplayer.candycrushsaga.popup.notificationcentral.button.BasicButton;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

