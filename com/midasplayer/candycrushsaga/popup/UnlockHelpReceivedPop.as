package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class UnlockHelpReceivedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      private var getPicFn:Function;
      
      public function UnlockHelpReceivedPop(param1:Number, param2:int, param3:String, param4:Function)
      {
         super(null,new CollabHelpReceivedContent());
         popId = "UnlockHelpReceivedPop";
         this.getPicFn = param4;
         var _loc_5:* = param4(param1);
         _popGfx.iGiftContainer.iPicContainer.addChild(_loc_5);
         _popGfx.tTitle.text = I18n.getString("popup_collaboration_received_header");
         _popGfx.tTitle.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         _popGfx.tTitle.embedFonts = false;
         _popGfx.tMessage.text = I18n.getString("popup_collaboration_received_message",param3);
         _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tMessage.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_collaboration_received_button_ok"),this.continueButtonDown);
         this.setEpisodeGfx(param2);
      }
      
      private function setEpisodeGfx(param1:int) : void
      {
         _popGfx.iEpisodeGfx.gotoAndStop(param1);
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

