package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import popup.*;
   
   public class ItemUnlockedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      public function ItemUnlockedPop(param1:Function, param2:String, param3:String)
      {
         super(param1,new ItemUnlockedContent());
         popId = "ItemUnlockedPop";
         var _loc_4:* = I18n.getString("booster_name_" + param2);
         var _loc_5:* = I18n.getString("item_category_" + param3);
         _popGfx.tTitle.text = I18n.getString("popup_item_unlocked_title",_loc_5);
         _popGfx.iItemPic.gotoAndStop(param2);
         _popGfx.tItemName.text = I18n.getString("booster_name_" + param2);
         _popGfx.tMessage.text = I18n.getString("popup_item_unlocked_message",_loc_5);
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tItemName);
         TextUtil.scaleToFit(_popGfx.tMessage);
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_item_unlocked_button_continue"),this.continueButtonDown);
         this._continueButton.setClickSound(SoundInterface.CLICK_WRAPPED);
      }
      
      override public function triggerCommand() : void
      {
         SoundInterface.playSound(SoundInterface.BOOSTER_UNLOCKED);
         super.triggerCommand();
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

