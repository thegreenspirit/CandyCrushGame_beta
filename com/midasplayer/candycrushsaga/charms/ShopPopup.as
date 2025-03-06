package com.midasplayer.candycrushsaga.charms
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.king.saga.api.listener.IBuyAnyProductListener;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.charms.api.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.*;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class ShopPopup extends Popup implements IBuyAnyProductListener
   {
      public static const Type:String = "SHOP_POPUP";
      
      private static const _HOURS:int = 0;
      
      private static const _MINUTES:int = 1;
      
      private static const _SECONDS:int = 2;
      
      private static const _START_X:int = 74;
      
      private static const _CHARM_STEP:int = 150;
      
      private static const _LOCKED:int = 1;
      
      private static const _UNLOCKED:int = 2;
      
      private static const _BOUGHT:int = 3;
      
      public static const TWEEN_SPEED:Number = 0.5;
      
      public static const EASE_PARAM_VALUE:int = 0;
      
      private static var _END_X:int = -376;
      
      protected var _clip:MovieClip;
      
      protected var _skipButton:BasicButton;
      
      protected var _isDisplaying:Boolean;
      
      protected var _buttons:Vector.<BasicButton>;
      
      protected var _isClosed:Boolean;
      
      protected var _exitState:String;
      
      protected var _clipWidth:int;
      
      private var _container:MovieClip;
      
      private var _arrowEnabled:Boolean;
      
      private var _charms:Vector.<CCCharm>;
      
      private var _leftArrow:BasicButton;
      
      private var _rightArrow:BasicButton;
      
      private var _dailyOffer:DailyOfferCharmInventory;
      
      private var _dailyOfferButton:ButtonResizable;
      
      private var _dailyOfferCountdownTimer:Timer;
      
      private var _minLeftUntilDailyOfferIsOver:int;
      
      private var _secLeftUntilMinuteIsOver:int = 59;
      
      private var _trialpayButton:ButtonResizable;
      
      private var _popupWidth:int;
      
      private var _giftCharmButton:ButtonResizable;
      
      private var _dailyOfferToGiftCharmSwitchTimer:Timer;
      
      private var _stopSwitching:Boolean = false;
      
      private var _buttonSuffix:String;
      
      private var _removeButtonSuffix:String;
      
      private var _charm:CCCharm;
      
      private var _inventory:Inventory;
      
      private var leftSwitchArrow:BasicButton;
      
      private var rightSwitchArrow:BasicButton;
      
      private var currentlyPurchasingProduct:CCCharm;
      
      public function ShopPopup(param1:Function, param2:MovieClip, param3:CCCharm, param4:Inventory)
      {
         this._buttons = new Vector.<BasicButton>();
         this._inventory = param4;
         this._charm = param3;
         this._clip = param2;
         super(param1,param2);
         if(Boolean(this._clip))
         {
            addChild(this._clip);
            this._clipWidth = this._clip.width;
         }
      }
      
      public static function alignBelow(param1:DisplayObject, param2:DisplayObject, param3:int = 0) : void
      {
         if(!param1.parent || !param2.parent)
         {
            return;
         }
         var _loc_4:* = param1.localToGlobal(new Point(param1.x,param1.getBounds(param1).bottom + param3));
         var _loc_5:* = param2.getBounds(param2);
         if(param2.scaleX != 1 || param2.scaleY != 1)
         {
            _loc_5 = param2.parent.getBounds(param2);
         }
         _loc_4.y -= _loc_5.top;
         var _loc_6:* = param2.parent.globalToLocal(_loc_4);
         param2.y = _loc_6.y;
      }
      
      public static function alignRight(param1:DisplayObject, param2:DisplayObject, param3:int = 0) : void
      {
         if(!param1.parent || !param2.parent)
         {
            return;
         }
         var _loc_4:* = param1.localToGlobal(new Point(param1.getBounds(param1).right + param3,param1.y));
         var _loc_5:* = param2.parent.globalToLocal(_loc_4);
         param2.x = _loc_5.x;
      }
      
      public static function alignLeft(param1:DisplayObject, param2:DisplayObject, param3:int = 0) : void
      {
         if(!param1.parent || !param2.parent)
         {
            return;
         }
         var _loc_4:* = param1.localToGlobal(new Point(param1.getBounds(param1).left - param3,param1.y));
         var _loc_5:* = param2.parent.globalToLocal(_loc_4);
         param2.x = _loc_5.x;
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
      
      private function _openGiftCharm() : void
      {
      }
      
      public function getClip() : MovieClip
      {
         return this._clip;
      }
      
      public function close() : void
      {
      }
      
      public function display() : void
      {
      }
      
      private function _setupDailyOfferButton(param1:int) : void
      {
         var _loc_2:* = this._clip.dailyOffer["buy_offer_button" + this._buttonSuffix];
         var _loc_3:* = this._clip.dailyOffer["buy_offer_button" + this._removeButtonSuffix];
         this._dailyOfferButton = new ButtonResizable("",this._buyDailyOffer,_loc_2,TextFieldAutoSize.LEFT);
         this._dailyOfferButton.setMargin(param1);
         this._clip.dailyOffer.removeChild(_loc_3);
      }
      
      private function _createCharms() : void
      {
         var _loc_3:CCCharm = null;
         var _loc_4:gCharmClip = null;
         var _loc_5:String = null;
         var _loc_6:String = null;
         var _loc_7:ButtonBuyCharm = null;
         var _loc_2:int = 0;
         var _loc_1:int = 1;
         for each(_loc_3 in this._charms)
         {
            _loc_4 = new gCharmClip();
            this._container.addChild(_loc_4);
            _loc_4.x = _loc_2;
            _loc_2 += _CHARM_STEP;
            _loc_4.name = _loc_3.getType();
            this._setCharmtext(_loc_4,_loc_3.getType());
            _loc_4.charm_frame.video_icon.visible = false;
            _loc_4.charm_frame.help.visible = false;
            _loc_5 = "btn_small" + this._buttonSuffix;
            _loc_6 = "btn_small" + this._removeButtonSuffix;
            _loc_7 = new ButtonBuyCharm(_loc_3.getCost().toString(),this._buyCharm,_loc_4.charm_frame[_loc_5]);
            _loc_4.charm_frame.removeChild(_loc_4.charm_frame[_loc_6]);
            _loc_7.setId(_loc_3.getType());
            _loc_7.setProductId(_loc_3.getProductId());
            this.addButtonToContainer(_loc_7,_loc_4.charm_frame);
            this._displayCharms(_loc_4,_loc_3);
            if(_loc_3.getUnlocked() == false)
            {
               _loc_7.displayLocked();
            }
            _loc_1++;
         }
         _END_X = this._charms.length > 4 ? _START_X - (this._charms.length - 4) * 150 : _START_X;
         this._addArrows();
         this._enableArrows();
      }
      
      private function _updateCharms() : void
      {
         var _loc_2:CCCharm = null;
         var _loc_3:MovieClip = null;
         var _loc_1:* = this._inventory.getCCCharmList();
         for each(_loc_2 in _loc_1)
         {
            if(_loc_2.isBought() != false)
            {
               _loc_3 = this._container.getChildByName(_loc_2.getType()) as MovieClip;
               if(Boolean(_loc_3) && _loc_3.currentFrame != 2)
               {
                  _loc_3.gotoAndStop(2);
                  _loc_3.charm.gotoAndStop(_loc_2.getType());
                  _loc_3.charm_glow.gotoAndStop(_loc_2.getType());
                  this._animateCharm(_loc_3,_loc_2.getType());
               }
            }
         }
         this._enableArrows();
      }
      
      private function _compareCharms(param1:CCCharm, param2:CCCharm) : int
      {
         if(param1.getUnlocked() == true && param2.getUnlocked() == false)
         {
            return -1;
         }
         if(param1.getUnlocked() == false && param2.getUnlocked() == true)
         {
            return 1;
         }
         if(param1.isBought() == false && param2.isBought())
         {
            return -1;
         }
         if(param1.isBought() && param2.isBought() == false)
         {
            return 1;
         }
         return 0;
      }
      
      private function _compareCharmsLevels(param1:CCCharm, param2:CCCharm) : int
      {
         var _loc_3:* = param1.getUnlockStars() == 0 ? param1.getUnlockEpisodeId() : 7;
         var _loc_4:* = param2.getUnlockStars() == 0 ? param2.getUnlockEpisodeId() : 7;
         var _loc_5:* = param1.getUnlockStars() == 0 ? param1.getUnlockLevelId() : 2;
         var _loc_6:* = param2.getUnlockStars() == 0 ? param2.getUnlockLevelId() : 2;
         if(param1.getUnlocked() && param2.getUnlocked() == false && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.getUnlocked() == false && param2.getUnlocked() == false && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.getUnlocked == false && param2.getUnlocked() == true && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.getUnlocked() == true && param2.getUnlocked() == true && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.getUnlocked() == true && param2.getUnlocked() == false && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.getUnlocked() == false && param2.getUnlocked() == false && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.getUnlocked() == false && param2.getUnlocked() == true && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.getUnlocked() == true && param2.getUnlocked() == true && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.isBought() == false && param2.isBought() && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.isBought() && param2.isBought() == false && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.isBought() == false && param2.isBought() == false && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.isBought() && param2.isBought() && (_loc_3 == _loc_4 && _loc_5 < _loc_6 || _loc_3 < _loc_4))
         {
            return -1;
         }
         if(param1.isBought() && param2.isBought() && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.isBought() == false && param2.isBought() && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.isBought() && param2.isBought() == false && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         if(param1.isBought() == false && param2.isBought() == false && (_loc_3 == _loc_4 && _loc_5 > _loc_6 || _loc_3 > _loc_4))
         {
            return 1;
         }
         return 0;
      }
      
      private function _setCharmtext(param1:MovieClip, param2:String) : void
      {
         this.setText(param1.header_txt,I18n.getString("popup_charms_shop_box_header_" + param2), "center", false);
         this.setText(param1.message_txt,I18n.getString("popup_charms_shop_box_message_" + param2));
         param1.header_txt.y = param1.charm_frame.y - param1.header_txt.height - 2;
      }
      
      private function _displayCharms(param1:MovieClip, param2:CCCharm) : void
      {
         var _loc_3:* = "btn_small" + this._buttonSuffix;
         if(param2.getUnlocked() == false)
         {
            param1.gotoAndStop(1);
            param1.charm.gotoAndStop(param2.getType());
            param1.charm.charm.gotoAndStop(_LOCKED);
            if(param2.getType() == CharmName.Magic)
            {
            }
         }
         else if(param2.isBought())
         {
            if(param1.currentFrame != 2)
            {
               param1.gotoAndStop(2);
               param1.charm.gotoAndStop(param2.getType());
               this._setCharmStateToBought(param1);
               param1.charm_glow.gotoAndStop(param2.getType());
               this._change_btn(param1,param2.getType());
            }
         }
         else
         {
            param1.gotoAndStop(1);
            param1.charm.gotoAndStop(param2.getType());
            param1.charm.charm.gotoAndStop(_UNLOCKED);
            this._createRandomBling(param1);
         }
      }
      
      private function _animateBling(param1:MovieClip) : void
      {
         param1.gotoAndPlay(3);
      }
      
      private function _addArrows() : void
      {
         this._leftArrow = new BasicButton(this._clip.left_button,this._pressRight);
         this._rightArrow = new BasicButton(this._clip.right_button,this._pressLeft);
         this.addButton(this._leftArrow);
         this.addButton(this._rightArrow);
         this._leftArrow.visible = false;
         this._leftArrow.disableInput();
         this.leftSwitchArrow = new BasicButton(this._clip.left_switch_button,this._switchOffer);
         this.rightSwitchArrow = new BasicButton(this._clip.right_switch_button,this._switchOffer);
         this.addButton(this.leftSwitchArrow);
         this.addButton(this.rightSwitchArrow);
      }
      
      public function addButtonToContainer(param1:BasicButton, param2:MovieClip) : void
      {
         this._buttons.push(param1);
         if(!param2.contains(param1))
         {
            param2.addChild(param1);
         }
      }
      
      private function _pressRight() : void
      {
         if(this._arrowEnabled && this._container.x < _START_X)
         {
            this._tweenContent(this._container.x + _CHARM_STEP);
         }
      }
      
      private function _pressLeft() : void
      {
         if(this._arrowEnabled && this._container.x > _END_X)
         {
            this._tweenContent(this._container.x - _CHARM_STEP);
         }
      }
      
      private function _enableArrows() : void
      {
         this._arrowEnabled = true;
      }
      
      private function _tweenContent(param1:Number) : void
      {
         this._arrowEnabled = false;
         if(param1 == _START_X)
         {
            this._leftArrow.visible = false;
            this._leftArrow.disableInput();
         }
         else if(param1 == _END_X)
         {
            this._rightArrow.visible = false;
            this._rightArrow.disableInput();
         }
         else
         {
            this._leftArrow.visible = true;
            this._leftArrow.enableInput();
            this._rightArrow.visible = true;
            this._rightArrow.enableInput();
         }
         TweenLite.to(this._container,0.3,{
            "x":param1,
            "ease":Linear.easeOut,
            "useFrames":false
         });
         setTimeout(this._enableArrows,300);
      }
      
      public function updateCharms(param1:CharmInventory) : void
      {
         this._updateCharms();
      }
      
      public function updateDailyOffer(param1:DailyOfferCharmInventory) : void
      {
      }
      
      private function _buyCharm(param1:ButtonBuyCharm = null, param2:int = 0) : void
      {
         this.currentlyPurchasingProduct = this._inventory.getCCCharmByProductId(param2);
         var _loc_3:* = this.currentlyPurchasingProduct.needPollAfterPurchase();
         this._inventory.buyPowerUp(this.currentlyPurchasingProduct,this,_loc_3);
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         if(param1 == "ok")
         {
            CharmsPanelInterface.notifyCharmBought(this.currentlyPurchasingProduct);
            this.currentlyPurchasingProduct = null;
            quitButtonDown();
         }
      }
      
      private function _buyDailyOffer() : void
      {
      }
      
      public function cleanUp() : void
      {
         var _loc_1:MovieClip = null;
         if(this._clip != null)
         {
            TweenLite.killTweensOf(this._container);
            while(this._container.numChildren > 0)
            {
               _loc_1 = this._container.getChildAt(0) as MovieClip;
               this._container.removeChildAt(0);
            }
         }
      }
      
      private function _animateCharm(param1:MovieClip, param2:String) : void
      {
         param1.star_animation.gotoAndPlay(2);
         TweenLite.from(param1.charm_glow,0.7,{
            "delay":0,
            "alpha":0,
            "overwrite":false,
            "onComplete":this._setCharmStateToBought,
            "onCompleteParams":[param1]
         });
         TweenLite.to(param1.charm_glow,0.6,{
            "delay":0.7,
            "alpha":0,
            "overwrite":false,
            "onComplete":this._change_btn,
            "onCompleteParams":[param1,param2]
         });
      }
      
      private function _setCharmStateToBought(param1:MovieClip) : void
      {
         param1.charm.charm.gotoAndStop(_BOUGHT);
         param1.charm.charm.bling.bling.gotoAndStop(2);
      }
      
      private function _createRandomBling(param1:MovieClip) : void
      {
         var _loc_2:* = int(Math.random() * 2000);
         param1.charm.charm.bling.bling.gotoAndStop(2);
         setTimeout(this._animateBling,_loc_2,param1.charm.charm.bling.bling);
      }
      
      private function _change_btn(param1:MovieClip, param2:String) : void
      {
         var _loc_3:BasicButton = null;
         var _loc_4:String = null;
         param1.charm_glow.visible = false;
         this._createRandomBling(param1);
         for each(_loc_3 in this._buttons)
         {
            if(_loc_3 is ButtonBuyCharm && ButtonBuyCharm(_loc_3).getId() == param2)
            {
               _loc_4 = "btn_small" + this._buttonSuffix;
               TweenLite.from(param1.charm_frame[_loc_4],0.3,{
                  "delay":0,
                  "scaleY":0,
                  "overwrite":false
               });
               TweenLite.to(param1.charm_frame[_loc_4],0.5,{
                  "delay":0.3,
                  "scaleY":1,
                  "overwrite":false,
                  "ease":Back.easeOut
               });
               ButtonBuyCharm(_loc_3).displayBought();
            }
         }
      }
      
      private function _switchOffer(event:TimerEvent = null) : void
      {
         var _loc_2:int = 0;
         var _loc_3:int = 0;
         if(this._clip.giftCharm.alpha == 0 || this._clip.dailyOffer.alpha == 0)
         {
            if(this._clip.dailyOffer.alpha == 0)
            {
               _loc_2 = 1;
               _loc_3 = 0;
               this._dailyOfferButton.enableInput();
               this._giftCharmButton.disableInput();
            }
            else
            {
               _loc_2 = 0;
               _loc_3 = 1;
               this._dailyOfferButton.disableInput();
               this._giftCharmButton.enableInput();
            }
            TweenLite.to(this._clip.dailyOffer,0.5,{"alpha":_loc_2});
            TweenLite.to(this._dailyOfferButton,0.5,{"alpha":_loc_2});
            TweenLite.to(this._clip.giftCharm,0.5,{"alpha":_loc_3});
            TweenLite.to(this._giftCharmButton,0.5,{"alpha":_loc_3});
         }
      }
      
      private function _loadCharmFilm(param1:IconButton, param2:String) : void
      {
      }
      
      private function _callEarnCredits() : void
      {
      }
      
      private function _setupTrialPayButton() : void
      {
         var _loc_2:* = new SocialChannelConfig(SocialChannelConfig.FACEBOOK);
         this._clip.removeChild(this._clip.trialpay_button);
      }
      
      private function _addGiftButton() : void
      {
         this.addButton(new BasicButton(this._clip.gift_button,this._openGiftCharm));
      }
      
      private function _setTexts() : void
      {
         this.setText(this._clip.header_txt,"", "center", false);
         this.setText(this._clip.giftCharm.gift_charm_title,I18n.getString("popup_charms_shop_gift_header"),TextFieldAutoSize.LEFT, false);
         this.setText(this._clip.giftCharm.gift_charm_body,I18n.getString("popup_charms_shop_gift_message"),TextFieldAutoSize.LEFT);
         this.setText(this._clip.securePayment,I18n.getString("popup_charms_shop_secure_payment_message"),TextFieldAutoSize.LEFT);
         this.setText(this._clip.explainCharm.explain_charm_title,I18n.getString("popup_charms_shop_info_header"),TextFieldAutoSize.LEFT, false);
         this.setText(this._clip.explainCharm.explain_charm_body,I18n.getString("popup_charms_shop_info_message"),TextFieldAutoSize.LEFT);
      }
      
      private function _sortCharmsOnStatus() : void
      {
         this._charms = this._inventory.getCCCharmList();
         this._charms = this._charms.sort(this._compareCharmsLevels);
      }
      
      private function _addGiftCharmButton() : void
      {
         this._giftCharmButton = new ButtonResizable(I18n.getString("popup_charms_shop_gift_button"),this._openGiftCharm,this._clip.giftCharm.gift_button,TextFieldAutoSize.LEFT);
         var _loc_1:* = this._popupWidth / 2 - this._giftCharmButton.width / 2;
         this._giftCharmButton.x = _loc_1;
         this.addButton(this._giftCharmButton);
         this._clip.giftCharm.alpha = 0;
         this._giftCharmButton.alpha = 0;
         this._giftCharmButton.disableInput();
      }
      
      private function _setupSplashClip() : void
      {
         var _loc_1:Boolean = false;
         _loc_1 = this._dailyOffer.getTotalCost().getCurrency() == "FBC";
         var _loc_2:* = _loc_1 ? 1 : 2;
         this._clip.payment_logos.gotoAndStop(_loc_2);
         this._clip.dailyOffer.splash.fb_icon1.visible = _loc_1;
         this._clip.dailyOffer.splash.fb_icon2.visible = _loc_1;
         this._clip.dailyOffer.splash.total_value_txt.x = _loc_1 ? 53 : 37;
         this._clip.dailyOffer.splash.your_value_txt.x = _loc_1 ? 58 : 41;
      }
      
      public function updateBoosters(param1:CurrentUser) : void
      {
      }
      
      public function addSkipButton(param1:Function) : void
      {
         this._skipButton = new ButtonClose(param1,this._clip.exit_button);
         this.addButton(this._skipButton);
      }
      
      public function setIsDisplaying(param1:Boolean) : void
      {
         this._isDisplaying = param1;
      }
      
      public function playSound() : void
      {
      }
      
      public function isDisplaying() : Boolean
      {
         return this._isDisplaying;
      }
      
      public function isClosed() : Boolean
      {
         return this._isClosed;
      }
      
      public function getExitState() : String
      {
         return this._exitState;
      }
      
      public function getFriendsPanel() : MovieClip
      {
         return null;
      }
      
      public function disableMouse() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function addButton(param1:BasicButton) : void
      {
         this._buttons.push(param1);
         if(!this.contains(param1))
         {
            this._clip.addChild(param1);
         }
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
      
      private function _replaceCharacter() : void
      {
      }
      
      private function _removeCharacter() : void
      {
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 100;
         _popGfx.y = -_popGfx.height - 50;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         TweenLite.to(_popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1 + 35,
            "ease":Back.easeOut,
            "easeParams":[EASE_PARAM_VALUE]
         });
      }
      
      public function init(param1:CharmInventory, param2:DailyOfferCharmInventory) : void
      {
         this._popupWidth = this._clip.width;
         this._dailyOffer = param2;
         this._container = this._clip.charmContainer;
         this._container.x = _START_X;
         var _loc_3:* = new SocialChannelConfig(SocialChannelConfig.FACEBOOK);
         var _loc_4:* = this._inventory.getCCCharmList()[0].getCurrency() == "USD";
         this._buttonSuffix = _loc_4 ? _loc_3.getButtonSuffixWithDollar() : _loc_3.getButtonSuffix();
         this._removeButtonSuffix = _loc_4 ? _loc_3.getRemoveButtonSuffixWithDollar() : _loc_3.getRemoveButtonSuffix();
         var _loc_5:* = _loc_4 ? _loc_3.getDailyOfferButtonMarginWithDollar() : _loc_3.getDailyOfferButtonMargin();
         this._setTexts();
         this._sortCharmsOnStatus();
         this._addGiftButton();
         this._setupDailyOfferButton(_loc_5);
         this._setupTrialPayButton();
         this._createCharms();
         this._addGiftCharmButton();
         this.hideDailyAndGifting();
      }
      
      private function hideDailyAndGifting() : void
      {
         this._clip.dailyOffer.visible = false;
         this._clip.giftCharm.visible = false;
         this._clip.gift_button.visible = false;
         this._giftCharmButton.visible = false;
         this._leftArrow.visible = false;
         this._rightArrow.visible = false;
         this.leftSwitchArrow.visible = false;
         this.rightSwitchArrow.visible = false;
      }
      
      public function tick(param1:int) : void
      {
      }
      
      public function update() : void
      {
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
   }
}

import com.midasplayer.candycrushsaga.popup.Popup;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

