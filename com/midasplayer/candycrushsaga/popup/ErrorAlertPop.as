package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import flash.system.*;
   import popup.*;
   
   public class ErrorAlertPop extends Popup
   {
      private static var _currentPop:ErrorAlertPop;
      
      private static var _numErrorsCounter:int = 0;
      
      private var _okButton:ButtonRegular;
      
      private var errorAlertId:int;
      
      public function ErrorAlertPop(event:IOErrorEvent = null, param2:String = "", param3:Error = null)
      {
         popId = "ErrorAlertPop";
         super(null,new ErrorAlertContent());
         numErrorsCounter + 1;
         this.errorAlertId = numErrorsCounter;
         _popGfx.tTitleHeader.text = I18n.getString("popup_error_alert_title");
         _popGfx.tMessageHeader.text = I18n.getString("popup_error_alert_message_header");
         var _loc_4:String = "";
         if(event != null)
         {
            _loc_4 += " [IO-Error= " + event.toString() + "]";
         }
         if(param3 != null)
         {
            _loc_4 += " [E-Error= " + param3.message + "]";
            if(Capabilities.isDebugger)
            {
               _loc_4 += " [Stacktrace= " + param3.getStackTrace() + "]";
            }
         }
         _popGfx.tMessageBody.text = _loc_4;
         TextUtil.scaleToFit(_popGfx.tTitleHeader);
         TextUtil.scaleToFit(_popGfx.tMessageHeader);
         this._okButton = new ButtonRegular(_popGfx.iButtonOk,I18n.getString("popup_error_alert_button_ok"),this.okButtonDown);
         this._okButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this.setCharacterMode("sad");
      }
      
      public static function get numErrorsCounter() : int
      {
         return _numErrorsCounter;
      }
      
      public static function set numErrorsCounter(param1:int) : void
      {
         _numErrorsCounter = param1;
         if(Boolean(_currentPop))
         {
            _currentPop.updateNumErrors();
         }
      }
      
      override public function triggerCommand() : void
      {
         _currentPop = this;
         super.triggerCommand();
         SoundInterface.playSound(SoundInterface.ERROR_ALERT);
         this.updateNumErrors();
      }
      
      private function updateNumErrors() : void
      {
         _popGfx.tNumMessages.text = "(" + this.errorAlertId + "/ " + numErrorsCounter + ")";
         TextUtil.scaleToFit(_popGfx.tNumMessages);
      }
      
      private function setCharacterMode(param1:String) : void
      {
         _popGfx.character.gotoAndStop(param1);
      }
      
      private function okButtonDown() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override protected function closeHook() : void
      {
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 120;
         _popGfx.y = -_popGfx.height;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         param1 = 40;
         TweenLite.to(_popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1,
            "ease":Back.easeOut,
            "easeParams":[Popup.EASE_PARAM_VALUE]
         });
      }
      
      override public function destruct() : void
      {
         if(_currentPop != null && _currentPop == this)
         {
            _currentPop = null;
         }
         super.destruct();
         this._okButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

