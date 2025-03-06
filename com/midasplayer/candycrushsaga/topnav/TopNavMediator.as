package com.midasplayer.candycrushsaga.topnav
{
   import com.king.saga.api.listener.IPollListener;
   import com.king.saga.api.response.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.api.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import main.*;
   
   public class TopNavMediator extends EventDispatcher implements IPollListener
   {
      private static const EXTRA_POLL_INTERVALS:int = 2;
      
      public static const WORLD:String = "world";
      
      public static const GAME:String = "game";
      
      private var displayBase:MovieClip;
      
      private var viewComponent:TopNavContent;
      
      private var _mcInviteButton:MovieClip;
      
      private var _mcRateLikeButton:MovieClip;
      
      private var _mcLifeButton:MovieClip;
      
      private var _mcCoinButton:MovieClip;
      
      private var _mcSoundPanel:MovieClip;
      
      private var _boosterPanel:BoosterPanel;
      
      private var _extraMovesReminder:ExtraMovesReminderContainer;
      
      private var isFan:Boolean = false;
      
      private var _lastRegenerationTime:Number;
      
      private var _TTNLTimer:Timer;
      
      private var inviteMediator:TopNavBtnMediator;
      
      private var rateMediator:TopNavBtnMediator;
      
      private var lifeMediator:TopNavBtnMediator;
      
      private var coinMediator:TopNavBtnMediator;
      
      private var soundPanelMediator:SoundPanel;
      
      private var ccModel:CCModel;
      
      private var musicManager:CCMusicManager;
      
      private var soundManager:CCSoundManager;
      
      private var ccQueueHandler:CCQueueHandler;
      
      private var updateTimer:Timer;
      
      private var _whenToPollForLife:int;
      
      private var mainRef:CCMain;
      
      private var _mcShopBtn:MovieClip;
      
      private var _mcFeedbackBtn:MovieClip;
      
      private var _mcCraftBtn:MovieClip;
      
      private var craftMediator:TopNavBtnMediator;
      
      private var shopMediator:TopNavBtnMediator;
      
      private var feedbackMediator:TopNavBtnMediator;
      
      public var _countUpLife:Number;
      
      private var _timerObject:Timer;
      
      private var _maxLives:int;
      
      public function TopNavMediator(param1:TopNavContent, param2:Boolean, param3:CCModel, param4:CCSoundManager, param5:CCMusicManager, param6:CCMain)
      {
         super();
         this.mainRef = param6;
         this.ccQueueHandler = this.ccQueueHandler;
         this.soundManager = param4;
         this.musicManager = param5;
         this.ccModel = param3;
         this.viewComponent = param1;
         this.isFan = param2;
         this._maxLives = this.ccModel.getCurrentUser().getMaxLives();
         if(Boolean(param1.heart))
         {
            param1.heart.gotoAndStop(23);
         }
         this.mediateButtons();
         this.setButtonText();
         this.setLife();
         this.setNextRegenerationTime();
         this.setGameMode(WORLD);
      }
      
      private function animateHeartRain(event:TimerEvent) : void
      {
         var _loc_2:* = this;
         var _loc_3:* = this._countUpLife + 1;
         _loc_2._countUpLife = _loc_3;
         this.viewComponent.life.text = this._countUpLife.toString();
         this.viewComponent.heart.gotoAndPlay(1);
      }
      
      public function animateHeartRainAndCountUpLife(param1:int, param2:int) : void
      {
         this._countUpLife = param1;
         this._timerObject = new Timer(500,param2);
         this._timerObject.addEventListener(TimerEvent.TIMER,this.animateHeartRain);
         this._timerObject.start();
      }
      
      public function setGameMode(param1:String) : void
      {
         if(param1 == WORLD)
         {
            this.viewComponent.timeBg.visible = true;
            this.shopMediator.show();
            this.craftMediator.show();
            this.rateMediator.show();
            this.inviteMediator.show();
            this.removeBoosterPanel();
            this.removeExtraMovesReminder();
         }
         else if(param1 == GAME)
         {
            this.viewComponent.timeBg.visible = false;
            this.shopMediator.hide();
            this.craftMediator.hide();
            this.rateMediator.hide();
            this.inviteMediator.hide();
            this.createBoosterPanel();
            this.createExtraMovesReminder();
         }
      }
      
      public function listenToSuccesfulSwitches(param1:Function) : void
      {
         var _loc_2:* = this.mainRef.getGame();
         _loc_2.addEventListener(GameCommEvent.SUCCESSFUL_SWITCH,param1);
      }
      
      public function removeListenToSuccesfulSwitches(param1:Function) : void
      {
         var _loc_2:* = this.mainRef.getGame();
         _loc_2.removeEventListener(GameCommEvent.SUCCESSFUL_SWITCH,param1);
      }
      
      public function listenToFailedSwitches(param1:Function) : void
      {
         var _loc_2:* = this.mainRef.getGame();
         _loc_2.addEventListener(GameCommEvent.FAILED_SWITCH,param1);
      }
      
      public function removeListenToFailedSwitches(param1:Function) : void
      {
         var _loc_2:* = this.mainRef.getGame();
         _loc_2.removeEventListener(GameCommEvent.FAILED_SWITCH,param1);
      }
      
      public function activatePowerUp(param1:CCPowerUp) : void
      {
         var _loc_2:* = this.mainRef.getGame();
         if(_loc_2)
         {
            _loc_2.activateBooster(param1.getType());
         }
      }
      
      public function lockBoosterPanel() : void
      {
         if(Boolean(this._boosterPanel))
         {
            this._boosterPanel.lockPanel();
         }
      }
      
      public function unlockBoosterPanel() : void
      {
         if(Boolean(this._boosterPanel))
         {
            this._boosterPanel.unLockPanel();
         }
      }
      
      public function stopGame() : void
      {
         var _loc_1:* = this.mainRef.getGame();
         if(_loc_1)
         {
            _loc_1.pauseGame();
         }
      }
      
      public function resumeGame() : void
      {
         var _loc_1:* = this.mainRef.getGame();
         if(_loc_1)
         {
            _loc_1.resumeGame();
         }
      }
      
      public function enableBoosterUsage() : void
      {
         this._boosterPanel.show();
      }
      
      public function disableBoosterUsage() : void
      {
         this._boosterPanel.hide();
      }
      
      private function createBoosterPanel() : void
      {
         if(!this._boosterPanel)
         {
            this._boosterPanel = new BoosterPanel(this.mainRef.getInventory(),this.mainRef.getCurrentGameModeName(),this.mainRef,this);
            this._boosterPanel.hide();
            this.viewComponent.boosterNav.addChild(this._boosterPanel);
         }
      }
      
      public function removeBoosterPanel() : void
      {
         if(Boolean(this._boosterPanel))
         {
            this._boosterPanel.remove();
            this._boosterPanel = null;
         }
      }
      
      private function createExtraMovesReminder() : void
      {
         var _loc_1:int = 0;
         if(!this._extraMovesReminder)
         {
            if(Boolean(this._boosterPanel))
            {
               _loc_1 = this._boosterPanel.getExtraMovesCost();
            }
            else
            {
               _loc_1 = 14;
            }
            if(_loc_1 == 0)
            {
               _loc_1 = 14;
            }
            this._extraMovesReminder = new ExtraMovesReminderContainer(I18n.getString("booster_reminder_description_CandyExtraMoves"),_loc_1.toString(),this.mainRef.getCurrentGameModeName());
            this._extraMovesReminder.hide();
            this._extraMovesReminder.addEventListener(MouseEvent.CLICK,this.onClickExtraMovesReminder);
            this.viewComponent.addChild(this._extraMovesReminder);
         }
      }
      
      public function removeExtraMovesReminder() : void
      {
         if(Boolean(this._extraMovesReminder))
         {
            this._extraMovesReminder.hide();
            this._extraMovesReminder.removeEventListener(MouseEvent.CLICK,this.onClickExtraMovesReminder);
            this._extraMovesReminder = null;
         }
      }
      
      public function onClickExtraMovesReminder(event:Event) : void
      {
         this._boosterPanel.extraMovesReminderClicked();
      }
      
      public function showExtraMovesReminder() : void
      {
         if(Boolean(this._extraMovesReminder))
         {
            if(Boolean(this.ccModel.getInventory().getCCBooster(BalanceConstants.BOOSTER_EXTRA_MOVES)) && this.ccModel.getInventory().getCCBooster(BalanceConstants.BOOSTER_EXTRA_MOVES).getUnlocked())
            {
               this._extraMovesReminder.show();
               return;
            }
         }
      }
      
      public function hideExtraMovesReminder() : void
      {
         if(Boolean(this._extraMovesReminder))
         {
            this._extraMovesReminder.hide();
         }
      }
      
      public function capExtraMovesReminder() : void
      {
         if(Boolean(this._extraMovesReminder))
         {
            this._extraMovesReminder.setCap(true);
            this._extraMovesReminder.hide();
         }
      }
      
      private function mediateButtons() : void
      {
         this._mcInviteButton = this.viewComponent.inviteButton;
         this._mcRateLikeButton = this.viewComponent.rateButton;
         this._mcLifeButton = this.viewComponent.timeBg.lifeCounterButton;
         this._mcCoinButton = this.viewComponent.coinButton;
         this._mcSoundPanel = this.viewComponent.soundPanel;
         this._mcCraftBtn = this.viewComponent.craftBtn;
         this._mcShopBtn = this.viewComponent.shopBtn;
         this._mcFeedbackBtn = this.viewComponent.feedbackBtn;
         this.inviteMediator = new TopNavBtnMediator(this._mcInviteButton,I18n.getString("topnav_invite_button"));
         this.rateMediator = new TopNavBtnMediator(this._mcRateLikeButton,I18n.getString("topnav_like_button"));
         this.lifeMediator = new TopNavBtnMediator(this._mcLifeButton);
         this.coinMediator = new TopNavBtnMediator(this._mcCoinButton);
         this.shopMediator = new TopNavBtnMediator(this._mcShopBtn,I18n.getString("topnav_shop_button"));
         this.setupFeedback();
         this.craftMediator = new TopNavBtnMediator(this._mcCraftBtn,I18n.getString("topnav_craft_button"));
         this._mcShopBtn.visible = false;
         this._mcCraftBtn.visible = false;
         this.soundPanelMediator = new SoundPanel(this._mcSoundPanel,this.ccModel,this.soundManager,this.musicManager);
         this.addButtonListeners();
      }
      
      private function addButtonListeners() : void
      {
         this.inviteMediator.addEventListener(MouseEvent.CLICK,this.onInviteClick);
         this.rateMediator.addEventListener(MouseEvent.CLICK,this.onRateLikeClick);
         this.lifeMediator.addEventListener(MouseEvent.CLICK,this.onLifeClick);
         this.coinMediator.addEventListener(MouseEvent.CLICK,this.onCoinClick);
      }
      
      private function onFeedbackClick(event:MouseEvent) : void
      {
         this.mainRef.onBugReportFormActivated_2();
      }
      
      public function setLife(param1:int = -1) : void
      {
         this.viewComponent.life.text = param1 >= 0 ? String(param1) : String(this.ccModel.getCurrentUser().getLives());
      }
      
      private function setButtonText() : void
      {
         if(this.isFan)
         {
            this.rateMediator.hideForever();
         }
         else
         {
            this.rateMediator.setText(I18n.getString("topnav_like_button"));
         }
      }
      
      private function onInviteClick(event:Event) : void
      {
         var _loc_2:* = I18n.getString("social_share_invite_title");
         var _loc_3:* = I18n.getString("social_share_invite_message");
         this._mcInviteButton.gotoAndStop(2);
         this.ccModel.openInviteDialog(_loc_2,_loc_3);
      }
      
      private function onRateLikeClick(event:Event) : void
      {
         if(this.isFan)
         {
            this.ccModel.openRateDialog();
         }
         else
         {
            this.mainRef.setIsFan();
            this.ccModel.openLikeDialog(this._onCloseLikeDialog);
            this.isFan = true;
            this.rateMediator.hideForever();
         }
      }
      
      private function _onCloseLikeDialog(param1:Boolean) : void
      {
      }
      
      private function onLifeClick(event:Event) : void
      {
         this.mainRef.queueBuyLivesPop();
      }
      
      private function onCoinClick(event:Event) : void
      {
      }
      
      private function addSeparators(param1:int) : String
      {
         var _loc_2:* = param1.toString();
         var _loc_3:* = _loc_2.length - 3;
         if(_loc_3 > 0)
         {
            _loc_2 = _loc_2.substring(0,_loc_3) + "," + _loc_2.substring(_loc_3);
            _loc_3 = _loc_2.length - 7;
            if(_loc_3 > 0)
            {
               _loc_2 = _loc_2.substring(0,_loc_3) + "," + _loc_2.substring(_loc_3);
            }
         }
         return _loc_2;
      }
      
      private function setNextRegenerationTime(param1:Number = -2) : void
      {
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         var _loc_2:* = param1 != -2 ? param1 : this.ccModel.getCurrentUser().getTimeToNextRegeneration();
         this.deleteTimer();
         if(_loc_2 == -1)
         {
            this.updateLifeText(null,true);
         }
         else
         {
            _loc_3 = 1000;
            _loc_4 = 1;
            this._whenToPollForLife = getTimer() + _loc_2 * _loc_3 + _loc_4 * _loc_3;
            this.updateTimer = new Timer(_loc_3,_loc_2 + _loc_4);
            this.updateTimer.addEventListener(TimerEvent.TIMER,this.updateLifeText);
            this.updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.pollForNewLife);
            this.updateTimer.start();
            this.updateLifeText();
         }
      }
      
      private function pollForNewLife(event:TimerEvent) : void
      {
         Console.println("pollForNewLife");
         this.ccModel.poll(this);
         this.deleteTimer();
      }
      
      public function onPoll(param1:PollResponse) : void
      {
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         Console.println("@ onPoll() - TopNavMediator.as | currentUser lives: " + param1.getCurrentUser().getLives());
         this.ccModel.getCurrentUser().copy(param1.getCurrentUser());
         var _loc_2:* = param1.getCurrentUser().getTimeToNextRegeneration();
         var _loc_3:* = param1.getCurrentUser().getLives();
         var _loc_4:* = param1.getCurrentUser().getMaxLives();
         Console.println("| maxLives before: " + this._maxLives + " | maxLives now: " + _loc_4);
         if(_loc_4 > this._maxLives)
         {
            _loc_5 = int(this.viewComponent.life.text);
            _loc_6 = _loc_4 - _loc_5;
            this.animateHeartRainAndCountUpLife(_loc_5,_loc_6);
            this._maxLives = _loc_4;
         }
         else
         {
            this.setLife(_loc_3);
         }
         this.setNextRegenerationTime(_loc_2);
      }
      
      private function updateLifeText(event:TimerEvent = null, param2:Boolean = false) : void
      {
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         var _loc_6:String = null;
         var _loc_7:String = null;
         var _loc_8:String = null;
         var _loc_3:* = (this._whenToPollForLife - getTimer()) / 1000;
         this.ccModel.setCustomTimeToNextRegeneration(_loc_3);
         this.ccModel.getCurrentUser()._timeToNextRegeneration = _loc_3;
         if(_loc_3 < 0 || param2)
         {
            this.viewComponent.timeBg.lifeCounter.text = "";
            this.viewComponent.timeBg.tLifeFull.text = I18n.getString("topnav_full_life");
            TextUtil.scaleToFit(this.viewComponent.timeBg.lifeCounter);
         }
         else if(_loc_3 >= 0.2)
         {
            _loc_4 = _loc_3 / 60;
            _loc_5 = Math.max(_loc_3 - _loc_4 * 60,0);
            _loc_6 = _loc_4 < 10 ? "0" + _loc_4.toString() : _loc_4.toString();
            _loc_7 = _loc_5 < 10 ? "0" + _loc_5.toString() : _loc_5.toString();
            _loc_8 = _loc_6 + ":" + _loc_7;
            this.viewComponent.timeBg.lifeCounter.text = _loc_8;
            this.viewComponent.timeBg.tLifeFull.text = "";
            if(this.ccModel.getCurrentUser()._lives == 0 && _loc_8 == "00:01")
            {
               this.ccModel.getCurrentUser()._lives = 1;
               this.setLife(this.ccModel.getCurrentUser()._lives);
               this.setNextRegenerationTime(1800);
               this.ccModel.getCurrentUser()._timeToNextRegeneration = 1800;
               TextUtil.scaleToFit(this.viewComponent.timeBg.lifeCounter);
            }
         }
      }
      
      private function extraPoll() : void
      {
         this.ccModel.poll(this);
      }
      
      private function deleteTimer() : void
      {
         if(this.updateTimer == null)
         {
            return;
         }
         this.updateTimer.stop();
         this.updateTimer.removeEventListener(TimerEvent.TIMER,this.updateLifeText);
         this.updateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.pollForNewLife);
         this.updateTimer = null;
      }
      
      private function setupFeedback() : void
      {
         this._mcFeedbackBtn.visible = false;
      }
      
      public function onPollError(param1:String) : void
      {
      }
      
      public function possibleLifeUpdate() : void
      {
         this.extraPoll();
      }
      
      public function doPoll() : void
      {
         this.ccModel.poll(this);
      }
      
      public function queueSingleCharmPop(param1:CCCharm) : void
      {
         Console.println("Topnavmediator | queueSingleCharmPop() | " + param1.getType());
         this.mainRef.queueSingleCharmPop(param1);
      }
   }
}

import flash.events.EventDispatcher;

