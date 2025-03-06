package com.midasplayer.candycrushsaga.popup.notificationcentral.button
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class BasicButton extends MovieClip
   {
      protected var clbPressed:Function;
      
      protected var _buttonClip:MovieClip;
      
      protected var _isPressed:Boolean;
      
      protected var _isActivated:Boolean;
      
      protected var _inputEnabled:Boolean;
      
      public function BasicButton(param1:MovieClip, param2:Function)
      {
         super();
         this.clbPressed = param2;
         this._buttonClip = param1;
         this.addChild(this._buttonClip);
         this.addListeners();
      }
      
      private function addListeners() : void
      {
         this._buttonClip.buttonMode = true;
         this._buttonClip.mouseEnabled = true;
         this._buttonClip.mouseChildren = false;
         this._buttonClip.addEventListener(MouseEvent.CLICK,this.onMouseClick);
         this._buttonClip.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._buttonClip.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      
      private function removeListeners() : void
      {
         this._buttonClip.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      }
      
      public function destroy() : void
      {
         this.removeListeners();
      }
      
      public function onMouseClick(event:MouseEvent) : void
      {
         this.clbPressed();
      }
      
      public function onMouseOut(event:MouseEvent) : void
      {
         this._setButtonState(1);
      }
      
      public function onMouseOver(event:MouseEvent) : void
      {
         this._setButtonState(2);
      }
      
      public function deactivate() : void
      {
         this.removeListeners();
         this._buttonClip.buttonMode = false;
         this._buttonClip.mouseEnabled = false;
      }
      
      public function disableInput() : void
      {
      }
      
      public function enableInput() : void
      {
      }
      
      protected function _setButtonState(param1:int) : void
      {
         this._buttonClip.gotoAndStop(param1);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

