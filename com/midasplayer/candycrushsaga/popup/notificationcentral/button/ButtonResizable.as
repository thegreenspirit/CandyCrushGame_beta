package com.midasplayer.candycrushsaga.popup.notificationcentral.button
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   
   public class ButtonResizable extends BasicButton
   {
      private var _autoSize:String;
      
      protected var _text:String;
      
      private var _margin:int = 30;
      
      private var _clbPressed:Function;
      
      public function ButtonResizable(param1:String, param2:Function, param3:MovieClip, param4:String = "center")
      {
         super(param3,param2);
         this._autoSize = param4;
         this._text = param1;
         if(Boolean(_buttonClip.txt))
         {
            _buttonClip.txt.mouseEnabled = false;
         }
         if(Boolean(_buttonClip.mcLeft.txt))
         {
            _buttonClip.mcLeft.txt.mouseEnabled = false;
         }
         this.setText(param1);
      }
      
      public function setCallbackFunction(param1:Function) : void
      {
         this._clbPressed = param1;
      }
      
      public function setSymbol(param1:String) : void
      {
         if(Boolean(_buttonClip.symb))
         {
            _buttonClip.symb.gotoAndStop(param1);
         }
      }
      
      public function setText(param1:String) : void
      {
         if(Boolean(_buttonClip.txt))
         {
            _buttonClip.txt.text = param1;
            _buttonClip.txt.autoSize = this._autoSize;
            this._text = param1;
            TextUtil.scaleToFit(_buttonClip.txt);
         }
         if(Boolean(_buttonClip.mcLeft.txt))
         {
            _buttonClip.mcLeft.txt.text = param1;
            _buttonClip.mcLeft.txt.autoSize = this._autoSize;
            this._text = param1;
            TextUtil.scaleToFit(_buttonClip.mcLeft.txt);
         }
         this._reSizeButton();
      }
      
      public function setMargin(param1:int) : void
      {
         this._margin = param1;
      }
      
      private function _reSizeButton() : void
      {
         var _loc_1:int = 0;
         if(Boolean(_buttonClip.txt))
         {
            _loc_1 = _buttonClip.txt.textWidth + this._margin;
         }
         if(Boolean(_buttonClip.mcLeft.txt))
         {
            _loc_1 = _buttonClip.mcLeft.txt.textWidth + this._margin;
         }
         if(Boolean(_buttonClip.mcLeft))
         {
            _buttonClip.mcLeft.x = 0;
         }
         if(Boolean(_buttonClip.mcMiddle))
         {
            _buttonClip.mcMiddle.width = Math.max(_loc_1,_buttonClip.mcMiddle.width);
         }
         if(Boolean(_buttonClip.mcMiddle))
         {
            _buttonClip.mcMiddle.x = _buttonClip.mcLeft.x + _buttonClip.mcLeft.width;
         }
         if(Boolean(_buttonClip.mcRight))
         {
            _buttonClip.mcRight.x = _buttonClip.mcMiddle.x + _buttonClip.mcMiddle.width;
         }
      }
      
      override protected function _setButtonState(param1:int) : void
      {
         if(Boolean(_buttonClip.mcLeft))
         {
            _buttonClip.mcLeft.gotoAndStop(param1);
         }
         if(Boolean(_buttonClip.mcMiddle))
         {
            _buttonClip.mcMiddle.gotoAndStop(param1);
         }
         if(Boolean(_buttonClip.mcRight))
         {
            _buttonClip.mcRight.gotoAndStop(param1);
         }
         if(param1 == 3)
         {
            this._setButtonSymbolPos(7);
         }
         else
         {
            this._setButtonSymbolPos(5);
         }
         this.setText(this._text);
      }
      
      private function _setButtonSymbolPos(param1:int) : void
      {
         if(!_buttonClip.symb)
         {
            return;
         }
         _buttonClip.symb.y = param1;
         if(Boolean(_buttonClip.txt))
         {
            _buttonClip.txt.y = param1;
         }
         if(Boolean(_buttonClip.mcLeft.txt))
         {
            _buttonClip.mcLeft.txt.y = param1;
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

