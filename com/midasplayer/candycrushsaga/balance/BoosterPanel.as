package com.midasplayer.candycrushsaga.balance
{
   import balance.*;
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.api.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.topnav.*;
   import flash.display.*;
   import flash.events.*;
   
   public class BoosterPanel extends MovieClip
   {
      private static const NORMAL:String = "normal";
      
      private static const HOVERED:String = "hovered";
      
      private static const INACTIVE:String = "inactive";
      
      private static const TWEEN_DUR:Number = 0.15;
      
      private static const VISIBLE_NUM:int = 7;
      
      private static const BUTTON_DIST:int = 55;
      
      private var _inventory:Inventory;
      
      private var _topNavMed:TopNavMediator;
      
      private var _mainRef:CCMain;
      
      private var _buttonContainer:MovieClip;
      
      private var _boosterButtons:Array;
      
      private var HIDDEN_Y:int = -50;
      
      private var _arrowL:MovieClip;
      
      private var _arrowR:MovieClip;
      
      private var _tweenStep:int = 0;
      
      private var _isTweening:Boolean;
      
      public function BoosterPanel(param1:Inventory, param2:String, param3:CCMain, param4:TopNavMediator)
      {
         var _loc_11:CCPowerUp = null;
         var _loc_12:MovieClip = null;
         var _loc_5:int = 0;
         var _loc_9:int = 0;
         var _loc_10:uint = 0;
         super();
         this._inventory = param1;
         this._mainRef = param3;
         this._topNavMed = param4;
         this._isTweening = false;
         this._buttonContainer = new MovieClip();
         this.addChild(this._buttonContainer);
         this._boosterButtons = new Array();
         var _loc_7:* = BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME;
         var _loc_8:* = this._inventory.getCCPowerUps(Inventory.FIND_POWERUP_CONTEXT,_loc_7,true);
         while(_loc_10 < _loc_8.length)
         {
            _loc_11 = _loc_8[_loc_10];
            if(_loc_11.acceptedInGameMode(param2))
            {
               _loc_12 = new TopNavBoosterButton(_loc_7,param1,_loc_11,param2,this);
               _loc_12.setUpButton();
               this._boosterButtons.push(_loc_12);
               _loc_12.x = _loc_5;
               _loc_12.y = 0;
               this._buttonContainer.addChild(_loc_12);
               _loc_9++;
               _loc_5 += BUTTON_DIST;
               if(_loc_9 > VISIBLE_NUM)
               {
                  _loc_12.alpha = 0;
               }
               else
               {
                  this._buttonContainer.x = CCConstants.STAGE_WIDTH - 40 - BUTTON_DIST * _loc_9;
               }
            }
            _loc_10 += 1;
         }
         if(_loc_9 > VISIBLE_NUM)
         {
            this.setUpArrows();
         }
         this.y = this.HIDDEN_Y;
         TweenLite.to(this,1,{"y":0});
      }
      
      public function show() : void
      {
         var _loc_1:TopNavBoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.show();
         }
      }
      
      public function hide() : void
      {
         var _loc_1:TopNavBoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.hide();
         }
      }
      
      private function setUpArrows() : void
      {
         this._arrowL = new ArrowLeftClip();
         this._arrowL.x = this._buttonContainer.x - 25;
         this._arrowL.y = 22;
         this._arrowL.addEventListener(MouseEvent.MOUSE_OUT,this.oMouseOut);
         this._arrowL.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._arrowL.addEventListener(MouseEvent.CLICK,this.tweenLeft);
         this._arrowL.buttonMode = true;
         this._arrowL.mouseChildren = false;
         this.addChild(this._arrowL);
         this._arrowR = new ArrowRightClip();
         this._arrowR.x = CCConstants.STAGE_WIDTH - 25;
         this._arrowR.y = this._arrowL.y;
         this._arrowR.addEventListener(MouseEvent.MOUSE_OUT,this.oMouseOut);
         this._arrowR.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._arrowR.addEventListener(MouseEvent.CLICK,this.tweenRight);
         this._arrowR.buttonMode = true;
         this._arrowR.mouseChildren = false;
         this.addChild(this._arrowR);
         this.inActivateArrow(this._arrowL);
      }
      
      private function inActivateArrow(param1:MovieClip) : void
      {
         this.gotoFrame(param1,BoosterPanel.INACTIVE);
         param1.visible = false;
      }
      
      private function activateArrow(param1:MovieClip) : void
      {
         this.gotoFrame(param1,BoosterPanel.NORMAL);
         param1.visible = true;
      }
      
      private function oMouseOut(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(_loc_2.currentFrameLabel == BoosterPanel.INACTIVE)
         {
            return;
         }
         this.gotoFrame(_loc_2,BoosterPanel.NORMAL);
      }
      
      private function onMouseOver(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(_loc_2.currentFrameLabel == BoosterPanel.INACTIVE)
         {
            return;
         }
         this.gotoFrame(_loc_2,BoosterPanel.HOVERED);
      }
      
      private function gotoFrame(param1:MovieClip, param2:String) : void
      {
         if(param1.currentFrameLabel != param2)
         {
            param1.gotoAndStop(param2);
         }
      }
      
      private function tweenLeft(event:MouseEvent) : void
      {
         if(this._isTweening)
         {
            return;
         }
         this._tweenStep - 1;
         var _loc_2:* = this._buttonContainer.x + BUTTON_DIST;
         TweenLite.to(this._buttonContainer,TWEEN_DUR,{
            "x":_loc_2,
            "onComplete":this.onTweenDone
         });
         TweenLite.to(this._boosterButtons[this._tweenStep],TWEEN_DUR,{"alpha":1});
         TweenLite.to(this._boosterButtons[this._tweenStep + VISIBLE_NUM],TWEEN_DUR,{"alpha":0});
         this.activateArrow(this._arrowR);
         if(this._tweenStep == 0)
         {
            this.inActivateArrow(this._arrowL);
         }
         this._isTweening = true;
      }
      
      private function tweenRight(event:MouseEvent) : void
      {
         if(this._isTweening)
         {
            return;
         }
         this._tweenStep + 1;
         var _loc_2:* = this._buttonContainer.x - BUTTON_DIST;
         TweenLite.to(this._buttonContainer,TWEEN_DUR,{
            "x":_loc_2,
            "onComplete":this.onTweenDone
         });
         TweenLite.to(this._boosterButtons[this._tweenStep - 1],TWEEN_DUR,{"alpha":0});
         TweenLite.to(this._boosterButtons[this._tweenStep + VISIBLE_NUM - 1],TWEEN_DUR,{"alpha":1});
         this.activateArrow(this._arrowL);
         if(this._tweenStep == this._boosterButtons.length - VISIBLE_NUM)
         {
            this.inActivateArrow(this._arrowR);
         }
         this._isTweening = true;
      }
      
      private function onTweenDone() : void
      {
         this._isTweening = false;
      }
      
      public function lockPanel() : void
      {
         var _loc_1:TopNavBoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.lock();
         }
      }
      
      public function unLockPanel() : void
      {
         var _loc_1:TopNavBoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.unlock();
         }
      }
      
      public function extraMovesReminderClicked() : void
      {
         var _loc_1:BoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            if(_loc_1.getCCPowerUp().getType() == BalanceConstants.BOOSTER_EXTRA_MOVES)
            {
               this._inventory.buyPowerUp(_loc_1.getCCPowerUp(),TopNavBoosterButton(_loc_1));
            }
         }
      }
      
      public function capExtraMovesReminder() : void
      {
         this._mainRef.capExtraMovesRemainder();
      }
      
      public function getExtraMovesCost() : int
      {
         var _loc_1:BoosterButton = null;
         for each(_loc_1 in this._boosterButtons)
         {
            if(_loc_1.getCCPowerUp().getType() == BalanceConstants.BOOSTER_EXTRA_MOVES)
            {
               return _loc_1.getCCPowerUp().getCost();
            }
         }
         return 0;
      }
      
      public function activatePowerUp(param1:CCPowerUp) : void
      {
         this._topNavMed.activatePowerUp(param1);
      }
      
      public function queueSingleCharmPop(param1:CCCharm) : void
      {
         this._topNavMed.queueSingleCharmPop(param1);
      }
      
      public function stopGame() : void
      {
         this._topNavMed.stopGame();
      }
      
      public function resumeGame() : void
      {
         this._topNavMed.resumeGame();
      }
      
      public function remove() : void
      {
         var _loc_1:BoosterButton = null;
         Console.println(" --- clean up boosterpanel");
         for each(_loc_1 in this._boosterButtons)
         {
            _loc_1.removeBoosterInfoBubble();
         }
         TweenLite.to(this,1,{
            "y":this.HIDDEN_Y,
            "onComplete":this.destroy
         });
      }
      
      public function destroy() : void
      {
         var _loc_1:BoosterButton = null;
         var _loc_2:IGameComm = null;
         if(Boolean(this._arrowL))
         {
            this._arrowL.parent.removeChild(this._arrowL);
            this._arrowL.removeEventListener(MouseEvent.MOUSE_OUT,this.oMouseOut);
            this._arrowL.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            this._arrowL.removeEventListener(MouseEvent.CLICK,this.tweenLeft);
            this._arrowL = null;
            this._arrowR.parent.removeChild(this._arrowR);
            this._arrowR.removeEventListener(MouseEvent.MOUSE_OUT,this.oMouseOut);
            this._arrowR.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            this._arrowR.removeEventListener(MouseEvent.CLICK,this.tweenRight);
            this._arrowR = null;
         }
         while(this._boosterButtons.length > 0)
         {
            _loc_1 = this._boosterButtons[0];
            _loc_1.destroy();
            this._boosterButtons.splice(0,1);
            _loc_1 = null;
         }
         if(this._mainRef.getGame() != null)
         {
            _loc_2 = this._mainRef.getGame();
            _loc_2.removeEventListener(GameCommEvent.EXTRA_MOVES_REMINDER_CLICKED,this.extraMovesReminderClicked);
         }
         this._boosterButtons = null;
         this._buttonContainer.parent.removeChild(this._buttonContainer);
         this._buttonContainer = null;
         this.parent.removeChild(this);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

