package com.midasplayer.candycrushsaga.charms
{
   import com.adobe.utils.StringUtil;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class ButtonBuyCharm extends BasicButton
   {
      protected var _text:String;
      
      private var _id:String;
      
      private var productId:int;
      
      public function ButtonBuyCharm(param1:String, param2:Function, param3:MovieClip)
      {
         super(param3,param2);
         this._text = param1;
         this.setText(this._text);
         this._resizeBackground();
      }
      
      override public function deactivate() : void
      {
         super.deactivate();
         this.setText(this._text);
         this._resizeBackground();
      }
      
      public function displayBought() : void
      {
         this.deactivate();
         _buttonClip.gotoAndStop(4);
      }
      
      public function displayLocked() : void
      {
         this.deactivate();
         _buttonClip.gotoAndStop(5);
      }
      
      override public function onMouseClick(event:MouseEvent) : void
      {
         clbPressed(this,this.productId);
      }
      
      public function setText(param1:String) : void
      {
         var _loc_4:TextFormat = null;
         var _loc_5:int = 0;
         var _loc_2:* = _buttonClip.button_txt;
         if(_loc_2)
         {
            _loc_2.text = StringUtil.trim(param1);
            _loc_2.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
            _loc_2.embedFonts = false;
            _loc_2.autoSize = TextFieldAutoSize.CENTER;
            if(_loc_2.textWidth > 50)
            {
               _loc_4 = _loc_2.getTextFormat();
               _loc_5 = _loc_2.x + _loc_2.width / 2;
               _loc_4 = _loc_2.getTextFormat();
               while(_loc_2.textWidth > 50)
               {
                  _loc_4.size = int(_loc_4.size) - 1;
                  _loc_2.setTextFormat(_loc_4);
                  if(_loc_4.size <= 8)
                  {
                     break;
                  }
               }
               _loc_2.x = _loc_5 - _loc_2.width / 2;
               _loc_2.y = _buttonClip.y - _loc_2.height / 2;
            }
         }
      }
      
      private function _resizeBackground() : void
      {
         if(Boolean(_buttonClip.background) && Boolean(_buttonClip.button_txt))
         {
            _buttonClip.background.width = Math.max(_buttonClip.background.width,_buttonClip.text.textWidth + 10);
         }
      }
      
      public function setId(param1:String) : void
      {
         this._id = param1;
      }
      
      public function getId() : String
      {
         return this._id;
      }
      
      public function setProductId(param1:int) : void
      {
         this.productId = param1;
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

