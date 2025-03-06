package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import popup.*;
   
   public class BuyLifePop extends Popup
   {
      private var _friendButton:ButtonRegular;
      
      private var onBuyLives:Function;
      
      private var onAskForLives:Function;
      
      private var _payButton:ButtonBuy;
      
      public function BuyLifePop(param1:int, param2:Function, param3:Function, param4:int)
      {
         super(null,new BuyLivesContent());
         popId = "BuyLifePop";
         this.onAskForLives = param3;
         this.onBuyLives = param2;
         _popGfx.tTitle.text = I18n.getString("popup_buy_lives_title");
         _popGfx.tMessage.text = I18n.getString("popup_buy_lives_message",param1);
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         this._payButton = new ButtonBuy(_popGfx.iButtonPay,I18n.getString("popup_buy_lives_button_buy"),String(param4),this.payButtonDown);
         this._payButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._friendButton = new ButtonRegular(_popGfx.iButtonFriends,I18n.getString("popup_buy_lives_button_ask_friends",6),this.friendButtonDown);
         this._friendButton.setClickSound(SoundInterface.CLICK_WRAPPED);
      }
      
      override protected function closeHook() : void
      {
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      private function payButtonDown() : void
      {
         this.onBuyLives();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function friendButtonDown() : void
      {
         this.onAskForLives();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._friendButton.destruct();
         this._friendButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

