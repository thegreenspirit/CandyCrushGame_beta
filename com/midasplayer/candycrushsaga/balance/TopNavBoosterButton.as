package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TopNavBoosterButton extends BoosterButton
   {
      private var _timesActivated:int = 0;
      
      private var _mcCap:MovieClip;
      
      private var _cooldownCounting:int = 0;
      
      private var _mcCooldown:MovieClip;
      
      private var _shCoolDownCircle:Shape;
      
      private var _mcCoolDownHolder:MovieClip;
      
      private var _circleR:Number;
      
      public function TopNavBoosterButton(param1:String, param2:Inventory, param3:CCPowerUp, param4:String, param5:BoosterPanel)
      {
         super(param1,param2,param3,param4,param5);
         _mcButton = new PanelBoosterButtonClip();
         _mcButton.iSymbolContainer.gotoAndStop(_ccPowerUp.getType());
         _mcSymbol = _mcButton.iSymbolContainer.iSymbol;
         _mcBG = _mcButton.iBG;
         if(param3 is CCBooster)
         {
            _mcButton.iAmount.gotoAndStop(BalanceConstants.CATEGORY_BOOSTER);
         }
         else
         {
            _mcButton.iAmount.gotoAndStop(BalanceConstants.CATEGORY_CHARM);
         }
         _mcAmount = _mcButton.iAmount.iState;
         this._mcCap = _mcButton.iCap;
         this._mcCooldown = _mcButton.iCooldown;
         this._mcCap.visible = false;
         this._mcCooldown.visible = false;
         this._cooldownCounting = 0;
      }
      
      override protected function onMouseDown(event:MouseEvent) : void
      {
         if(this.isReadyToUse())
         {
            Console.println("TopnavBoosterButton.as | onMouseDown() & isReadyToUse()");
            this.activatePowerUp();
         }
         super.onMouseDown(event);
      }
      
      override public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         Console.println("TopnavBoosterButton.as | onBuyAnyProduct");
         this.activatePowerUp();
         super.onBuyAnyProduct(param1,param2,param3,param4);
      }
      
      public function activatePowerUp() : void
      {
         Console.println("TopnavBoosterButton.as | activateBooster()");
         var _loc_1:* = this;
         var _loc_2:* = this._timesActivated + 1;
         _loc_1._timesActivated = _loc_2;
         this.activateCooldown();
         if(_ccPowerUp is CCBooster)
         {
            _inventory.addToSelectedBoosters(_ccPowerUp);
            _inventory.useBoostersInGame();
         }
         _containerOb.activatePowerUp(_ccPowerUp);
      }
      
      private function activateCooldown() : void
      {
         var _loc_1:Number = NaN;
         var _loc_2:Number = NaN;
         if(_ccPowerUp.hasCooldown() && this._cooldownCounting == 0)
         {
            this._mcCooldown.visible = true;
            _mcAmount.visible = false;
            this._circleR = _mcBG.width / 2 + 4;
            _loc_1 = _mcBG.width / 2;
            _loc_2 = 0 + _mcBG.height / 2 + 1;
            this._mcCoolDownHolder = new MovieClip();
            this._mcCoolDownHolder.x = _loc_1;
            this._mcCoolDownHolder.y = _loc_2;
            this._mcCooldown.addChild(this._mcCoolDownHolder);
            this._mcCoolDownHolder.rotation = -90;
            this._shCoolDownCircle = new Shape();
            this._shCoolDownCircle.x = 0;
            this._shCoolDownCircle.y = 0;
            this._mcCoolDownHolder.addChild(this._shCoolDownCircle);
            _containerOb.litenToSuccesfulSwitches(this.countDownCooldown);
            _mcButton.mouseEnabled = false;
            this.countDownCooldown();
         }
      }
      
      private function countDownCooldown(event:GameCommEvent = null) : void
      {
         var _loc_6:int = 0;
         var _loc_2:* = _ccPowerUp.getCooldown();
         var _loc_3:* = this._cooldownCounting / _loc_2;
         var _loc_4:* = 360 - 360 * _loc_3;
         var _loc_5:* = (360 - 360 * _loc_3) * Math.PI / 180;
         this._shCoolDownCircle.graphics.clear();
         this._shCoolDownCircle.graphics.moveTo(0,0);
         this._shCoolDownCircle.graphics.beginFill(16777215,1);
         while(_loc_6 <= _loc_4)
         {
            this._shCoolDownCircle.graphics.lineTo(this._circleR * Math.cos(_loc_6 * Math.PI / 180),-this._circleR * Math.sin(_loc_6 * Math.PI / 180));
            _loc_6++;
         }
         this._shCoolDownCircle.graphics.lineTo(0,0);
         this._shCoolDownCircle.graphics.endFill();
         this._mcCooldown.mask = this._shCoolDownCircle;
         var _loc_7:* = this;
         var _loc_8:* = this._cooldownCounting + 1;
         _loc_7._cooldownCounting = _loc_8;
         if(this._cooldownCounting > _ccPowerUp.getCooldown())
         {
            this._mcCoolDownHolder.parent.removeChild(this._mcCoolDownHolder);
            this._mcCoolDownHolder = null;
            this._shCoolDownCircle.parent.removeChild(this._shCoolDownCircle);
            this._shCoolDownCircle = null;
            _containerOb.removeListenToSwitches(this.countDownCooldown);
            this._mcCooldown.visible = false;
            _mcAmount.visible = true;
            this._cooldownCounting = 0;
            this.setButtonState();
            _mcButton.mouseEnabled = true;
         }
      }
      
      private function isReadyToUse() : Boolean
      {
         if(this.alpha != 1)
         {
            return false;
         }
         if(_mcAmount.currentFrameLabel == BoosterButton.FL_AMOUNT_TOTAL)
         {
            return true;
         }
         return false;
      }
      
      override public function selectBoosterButton() : void
      {
         var _loc_1:int = 0;
         var _loc_2:Timer = null;
         _loc_1 = _ccPowerUp.getDuration();
         if(_loc_1 <= 0)
         {
            this.setButtonState();
         }
         else
         {
            _isActivated = true;
            setToActivated();
            _mcButton.buttonMode = false;
            _loc_2 = new Timer(_loc_1,1);
            _loc_2.start();
            _loc_2.addEventListener(TimerEvent.TIMER_COMPLETE,this.timerDurEnd);
         }
      }
      
      override public function setButtonState() : void
      {
         if(_ccPowerUp.hasCap() && this._timesActivated >= _ccPowerUp.getCap())
         {
            this._mcCap.visible = true;
            _containerOb.capExtraMovesReminder();
            this.disableButton();
         }
         super.setButtonState();
      }
      
      protected function disableButton() : void
      {
         removeBoosterInfoBubble();
         removeButtonListeners();
      }
      
      private function timerDurEnd(event:Event) : void
      {
         var _loc_2:* = event.currentTarget as Timer;
         _loc_2.stop();
         _loc_2.removeEventListener(TimerEvent.TIMER_COMPLETE,this.setButtonState);
         _loc_2 = null;
         _isActivated = false;
         _mcButton.buttonMode = true;
         this.setButtonState();
      }
      
      public function lock() : void
      {
         _mcAmount.visible = false;
         _mcButton.alpha = 0.5;
         _mcSymbol.filters = [];
         removeButtonListeners();
      }
      
      public function unlock() : void
      {
         _mcAmount.visible = true;
         _mcButton.alpha = 1;
         setUpButtonListeners();
         this.setButtonState();
      }
      
      override public function destroy() : void
      {
         if(this._mcCoolDownHolder != null)
         {
            if(this._mcCoolDownHolder.parent != null)
            {
               this._mcCoolDownHolder.parent.removeChild(this._mcCoolDownHolder);
            }
            this._mcCoolDownHolder = null;
         }
         if(this._shCoolDownCircle != null)
         {
            if(this._shCoolDownCircle.parent != null)
            {
               this._shCoolDownCircle.parent.removeChild(this._shCoolDownCircle);
            }
            this._shCoolDownCircle = null;
         }
         super.destroy();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

