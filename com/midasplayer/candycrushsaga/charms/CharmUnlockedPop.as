package com.midasplayer.candycrushsaga.charms
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.king.saga.api.listener.IBuyAnyProductListener;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class CharmUnlockedPop extends Popup implements IBuyAnyProductListener
   {
      public static const INFO:String = "info";
      
      public static const UNLOCKED:String = "unlocked";
      
      public static const TWEEN_SPEED:Number = 0.5;
      
      public static const EASE_PARAM_VALUE:int = 0;
      
      private var _ccCharm:CCCharm;
      
      private var _trialpayButton:ButtonResizable;
      
      private var _openShopFunc:Function;
      
      private var _inventory:Inventory;
      
      private var _popMode:String;
      
      private var _payButton:ButtonBuy;
      
      private var _shopButton:ButtonRegular;
      
      protected var _clip:MovieClip;
      
      protected var _skipButton:BasicButton;
      
      protected var _buttons:Array;
      
      public function CharmUnlockedPop(param1:Function, param2:Function, param3:MovieClip, param4:Inventory)
      {
         this._buttons = [];
         super(param1,param3);
         this._inventory = param4;
         this._openShopFunc = param2;
         this._clip = param3;
      }
      
      public function init(param1:CCCharm, param2:CurrentUser, param3:String) : void
      {
         var _loc_4:String = null;
         this._popMode = param3;
         this._ccCharm = param1;
         this._clip.booster.gotoAndStop(this._ccCharm.getType());
         if(param3 == CharmUnlockedPop.INFO)
         {
            _loc_4 = I18n.getString("popup_charms_single_info_header_" + this._ccCharm.getType());
         }
         else if(param3 == CharmUnlockedPop.UNLOCKED)
         {
            _loc_4 = I18n.getString("popup_charms_single_unlocked_header_" + this._ccCharm.getType());
            SoundInterface.playSound(SoundInterface.BOOSTER_UNLOCKED);
         }
         this.setText(this._clip.pre_header_txt, _loc_4, "center", false);
         this.setText(this._clip.body_txt,I18n.getString("popup_charms_single_message_" + this._ccCharm.getType()));
         this._payButton = new ButtonBuy(this._clip.iButtonPay,I18n.getString("popup_charms_single_buy_button"),this._ccCharm.getCost().toString(),this._buyCharm);
         this._payButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._shopButton = new ButtonRegular(this._clip.iButtonShop,I18n.getString("popup_charms_single_open_shop_button"),this._openCharmShop);
         this._shopButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._clip.movie_icon.visible = false;
         var _loc_5:* = new SocialChannelConfig(SocialChannelConfig.FACEBOOK);
      }
      
      private function _openCharmShop() : void
      {
         this._openShopFunc(this._ccCharm);
         if(this._popMode == CharmUnlockedPop.UNLOCKED)
         {
            CharmsPanelInterface.notifyCharmUnlocked();
         }
         quitButtonDown();
      }
      
      override protected function closeHook() : void
      {
         if(this._popMode == CharmUnlockedPop.UNLOCKED)
         {
            CharmsPanelInterface.notifyCharmUnlocked();
         }
      }
      
      private function _openVideo(param1:IconButton, param2:String) : void
      {
      }
      
      private function _buyCharm() : void
      {
         var _loc_1:* = this._ccCharm.needPollAfterPurchase();
         this._inventory.buyPowerUp(this._ccCharm,this,_loc_1);
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         if(this._popMode == CharmUnlockedPop.UNLOCKED)
         {
            CharmsPanelInterface.notifyCharmUnlocked();
         }
         CharmsPanelInterface.notifyCharmBought(this._ccCharm);
         quitButtonDown();
      }
      
      private function _callEarnCredits() : void
      {
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 50;
         _popGfx.y = -_popGfx.height - 50;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         TweenLite.to(_popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1 + -25,
            "ease":Back.easeOut,
            "easeParams":[EASE_PARAM_VALUE]
         });
      }
      
      public function setText(param1:TextField, param2:String, param3:String = "center", param4:Boolean = true) : void
      {
         var fontName = "American Typewriter";
         if (param4 == false) {
            fontName = "CCS_bananaSplit";
         }
         param1.text = param2;
         param1.setTextFormat(LocalConstants.FORMAT(fontName));
         param1.embedFonts = false;
         TextUtil.scaleToFit(param1);
      }
      
      public function addButton(param1:BasicButton) : void
      {
         this._buttons.push(param1);
         if(!this.contains(param1))
         {
            this._clip.addChild(param1);
         }
      }
      
      override public function destruct() : void
      {
         Console.println("DESTRUCT CHARM POPUP");
         super.destruct();
         dispatchEvent(new Event("resumeGame"));
         if(Boolean(this._payButton))
         {
            this._payButton.destruct();
         }
         if(Boolean(this._shopButton))
         {
            this._shopButton.destruct();
         }
         if(Boolean(this._trialpayButton))
         {
            this._trialpayButton.destroy();
         }
         this._payButton = null;
         this._shopButton = null;
         this._trialpayButton = null;
      }
   }
}

import com.midasplayer.candycrushsaga.popup.Popup;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

