package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import popup.*;
   
   public class SagaCompletedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      public function SagaCompletedPop()
      {
         super(null,new GameCompleteContent());
         popId = "SagaCompletedPop";
         _popGfx.tTitle.text = I18n.getString("popup_saga_complete_header");
         _popGfx.tMessage.text = I18n.getString("popup_saga_complete_message");
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         var _loc_1:* = I18n.getString("popup_saga_complete_button_ok");
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,_loc_1,this.continueButtonDown);
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
      }
      
      private function continueButtonDown() : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._continueButton.destruct();
         this._continueButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

