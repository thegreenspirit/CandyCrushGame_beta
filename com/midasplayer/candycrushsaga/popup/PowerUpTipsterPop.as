package com.midasplayer.candycrushsaga.popup
{
   import com.king.saga.api.listener.IBuyAnyProductListener;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import popup.*;
   
   public class PowerUpTipsterPop extends Popup implements IBuyAnyProductListener
   {
      private var _purchaseButton:ButtonRegular;
      
      private var _clbPurchaseFunc:Function;
      
      private var _ccPowerUp:CCPowerUp;
      
      public function PowerUpTipsterPop(param1:Function, param2:Function, param3:CCPowerUp)
      {
         super(param1,new PowerUpTipsterContent());
         Console.println("@ constructor PowerUpTipsterPop()");
         this._clbPurchaseFunc = param2;
         this._ccPowerUp = param3;
         popId = "PowerUpTipster";
         var _loc_4:* = param3.isABooster();
         var _loc_5:* = param3.getType();
         _popGfx.tTitle.text = I18n.getString("powerup_tipster_title");
         _popGfx.tTitle.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tTitle.embedFonts = false;
         if(_loc_4)
         {
            _popGfx.tMessage.text = I18n.getString("powerup_tipster_booster_description");
            _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tMessage.embedFonts = false;
            _popGfx.tItemName.text = I18n.getString("booster_name_" + _loc_5);
            _popGfx.tItemName.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tItemName.embedFonts = false;
            _popGfx.tDesc.text = I18n.getString("booster_description_" + _loc_5);
            _popGfx.tDesc.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tDesc.embedFonts = false;
            _popGfx.iAmount.gotoAndStop(1);
            _popGfx.iAmount.tAmount.text = "x" + I18n.getString("popup_item_unlocked_purchase_amount_" + _loc_5);
            _popGfx.iAmount.tAmount.setTextFormat(LocalConstants.FORMAT());
            _popGfx.iAmount.tAmount.embedFonts = false;
            TextUtil.scaleToFit(_popGfx.iAmount.tAmount);
         }
         else
         {
            _popGfx.tMessage.text = I18n.getString("powerup_tipster_charm_description");
            _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tMessage.embedFonts = false;
            _popGfx.tItemName.text = I18n.getString("popup_charms_shop_box_header_" + _loc_5);
            _popGfx.tItemName.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tItemName.embedFonts = false;
            _popGfx.tDesc.text = I18n.getString("popup_charms_shop_box_message_" + _loc_5);
            _popGfx.tDesc.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tDesc.embedFonts = false;
            _popGfx.iAmount.gotoAndStop(2);
         }
         _popGfx.iCost.tValue.text = param3.getCost();
         _popGfx.iCost.tValue.setTextFormat(LocalConstants.FORMAT());
         _popGfx.iCost.tValue.embedFonts = false;
         _popGfx.iItemPic.gotoAndStop(_loc_5);
         TextUtil.scaleToFit(_popGfx.tMessage);
         TextUtil.scaleToFit(_popGfx.tItemName);
         TextUtil.scaleToFit(_popGfx.tDesc);
         TextUtil.scaleToFit(_popGfx.iCost.tValue);
         this._purchaseButton = new ButtonRegular(_popGfx.iButtonBuy,I18n.getString("powerup_tipster_buy_button"),this.purchaseButtonDown);
         this._purchaseButton.setClickSound(SoundInterface.CLICK_WRAPPED);
      }
      
      override public function triggerCommand() : void
      {
         SoundInterface.playSound(SoundInterface.BOOSTER_UNLOCKED);
         super.triggerCommand();
      }
      
      private function purchaseButtonDown() : void
      {
         var _loc_1:* = this._ccPowerUp.needPollAfterPurchase();
         this._clbPurchaseFunc(this._ccPowerUp,this,_loc_1);
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         Console.println("@ onBuyAnyProduct() - PowerUpTipsterPop.as | purchase:",this._ccPowerUp.getType());
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override protected function closeHook() : void
      {
         super.closeHook();
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._purchaseButton.destruct();
         this._purchaseButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

