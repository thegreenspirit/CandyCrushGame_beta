package com.midasplayer.candycrushsaga.popup.notificationcentral
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import mx.utils.*;
   
   public class SagaPopupBase extends MovieClip implements ICCQueueElement
   {
      private const _MARGIN:int = 60;
      
      protected var _friendsPanel:Object;
      
      protected var _clbExitFunc:Function;
      
      protected var _clip:MovieClip;
      
      protected var _skipButton:BasicButton;
      
      protected var _isDisplaying:Boolean;
      
      protected var _buttons:Vector.<BasicButton>;
      
      protected var _isClosed:Boolean;
      
      protected var _exitState:String;
      
      protected var _clipWidth:int;
      
      public function SagaPopupBase(param1:MovieClip)
      {
         super();
         this._buttons = new Vector.<BasicButton>();
         Console.println("Popup created of type: " + getQualifiedClassName(param1),"popup");
         this._clip = param1;
         if(Boolean(this._clip))
         {
            addChild(this._clip);
            this._clipWidth = this._clip.width;
         }
      }
      
      public static function formatNumber(param1:int) : String
      {
         var _loc_2:* = String(param1);
         var _loc_3:String = "";
         var _loc_4:* = _loc_2.length - 1;
         while(_loc_4 >= 0)
         {
            _loc_3 = ((_loc_2.length - _loc_4) % 3 == 0 && _loc_4 > 0 && _loc_4 < _loc_2.length - 1 ? " " : "") + _loc_2.charAt(_loc_4) + _loc_3;
            _loc_4 -= 1;
         }
         return _loc_3;
      }
      
      public function addSkipButton(param1:Function) : void
      {
         this._skipButton = new ButtonClose(param1,this._clip.pop.exit_button);
         this.addButton(this._skipButton);
      }
      
      public function close() : void
      {
         this.quitButtonDown();
         this.closeHook();
      }
      
      protected function closeHook() : void
      {
      }
      
      public function addButton(param1:BasicButton) : void
      {
         this._buttons.push(param1);
         if(!this.contains(param1))
         {
            this._clip.addChild(param1);
         }
         param1.x += this._clip.pop.x;
         param1.y += this._clip.pop.y;
      }
      
      public function removeButton(param1:BasicButton) : void
      {
         var _loc_2:int = 0;
         if(this.contains(param1))
         {
            this._clip.removeChild(param1);
         }
         while(_loc_2 < this._buttons.length)
         {
            if(this._buttons[_loc_2] == param1)
            {
               param1.destroy();
               this._buttons.splice(_loc_2,1);
               return;
            }
            _loc_2++;
         }
      }
      
      public function centerOnScreen(param1:Boolean = false) : void
      {
         var _loc_2:* = this.getBounds(this);
         var _loc_3:* = this.globalToLocal(new Point(755 * 0.5,650 * 0.5));
         var _loc_4:* = _loc_3.x;
         var _loc_5:* = _loc_3.y;
         var _loc_6:* = this.x - (_loc_2.left + _loc_2.width * 0.5);
         var _loc_7:* = this.y - (_loc_2.y + _loc_2.height * 0.5);
         this.x = _loc_4 + _loc_6;
         this.y = _loc_5 + _loc_7;
         _loc_2 = this.getBounds(this);
         var _loc_8:* = this.localToGlobal(new Point(_loc_2.left,0)).x;
      }
      
      public function cleanUp() : void
      {
         var _loc_1:BasicButton = null;
         this._clbExitFunc = null;
         for each(_loc_1 in this._buttons)
         {
            _loc_1.destroy();
         }
         if(Boolean(this._friendsPanel) && Boolean(this._friendsPanel.parent))
         {
            this._friendsPanel.parent.removeChild(this._friendsPanel);
         }
         this._friendsPanel = null;
         parent.removeChild(this);
      }
      
      public function setText(param1:TextField, param2:String, param3:String = "center", param4:Boolean = true) : void
      {
         var _loc_6:TextFormat = null;
         var _loc_7:int = 0;
         var _loc_8:Number = NaN;
         var _loc_5:* = param1.textHeight;
         param1.text = StringUtil.trim(param2);
         if(param4)
         {
            if(_loc_5 < param1.textHeight)
            {
               _loc_6 = param1.getTextFormat();
               while(_loc_5 <= param1.textHeight)
               {
                  _loc_6.size = int(_loc_6.size) - 1;
                  param1.setTextFormat(_loc_6);
               }
            }
            else if(param1.width >= this._clipWidth - this._MARGIN)
            {
               _loc_7 = param1.x + param1.width / 2;
               _loc_8 = (this._clipWidth - this._MARGIN) / param1.width;
               param1.scaleX *= _loc_8;
               param1.scaleY *= _loc_8;
               param1.x = _loc_7 - param1.width / 2;
            }
         }
         param1.autoSize = param3;
         TextUtil.scaleToFit(param1);
      }
      
      protected function quitButtonDown(event:MouseEvent = null) : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      public function deactivate() : void
      {
      }
      
      public function destruct() : void
      {
         DarkLayer.removeDarkLayer(CCMain.mcDisplayPopup);
         if(Boolean(this.parent))
         {
            this.parent.removeChild(this);
         }
      }
      
      public function triggerCommand() : void
      {
         dispatchEvent(new Event(CCConstants.ADD_POPUP));
         this._clip.stage.frameRate = 25;
         this._clip.alpha = 0;
         var _loc_1:* = CCConstants.STAGE_HEIGHT / 2 - this._clip.height / 2;
         DarkLayer.addDarkLayer(CCMain.mcDisplayPopup);
         TweenLite.to(this._clip,1,{
            "alpha":1,
            "y":_loc_1,
            "ease":Back.easeOut
         });
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

