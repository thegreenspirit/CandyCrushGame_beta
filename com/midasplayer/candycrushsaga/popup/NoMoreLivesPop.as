package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import flash.utils.*;
   import popup.*;
   
   public class NoMoreLivesPop extends Popup
   {
      private var _friendButton:ButtonRegular;
      
      private var onBuyLives:Function;
      
      private var onAskForLives:Function;
      
      private var _payButton:ButtonBuy;
      
      private var setupAdTimer:Function;
      
      private var updateTimer:Timer;
      
      private var _whenToPollForLife:int;
      
      private var ttnl:int;
      
      public function NoMoreLivesPop(param1:int, param2:Function, param3:Function, param4:Function, param5:int, param6:Function, param7:int)
      {
         super(param4,new NoMoreLivesContent());
         popId = "NoMoreLivesPop";
         this.ttnl = param7;
         this.setupAdTimer = param6;
         this.onAskForLives = param3;
         this.onBuyLives = param2;
         _popGfx.tTimeMessage.text = I18n.getString("popup_no_more_lives_time");
         _popGfx.tTitle.text = I18n.getString("popup_no_more_lives_title");
         _popGfx.tMessage.text = I18n.getString("popup_no_more_lives_message",param1);
         this._payButton = new ButtonBuy(_popGfx.iButtonPay,I18n.getString("popup_buy_lives_button_buy"),String(param5),this.payButtonDown);
         this._payButton.getClip().visible = false;
         this._payButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._friendButton = new ButtonRegular(_popGfx.iButtonFriends,I18n.getString("popup_buy_lives_button_ask_friends",6),this.friendButtonDown);
         this._friendButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         TextUtil.scaleToFit(_popGfx.tTimeMessage);
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         this.setupCountdownTimer();
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      private function setupCountdownTimer() : void
      {
         this._whenToPollForLife = getTimer() + this.ttnl * 1000 + 1 * 1000;
         this.updateTimer = new Timer(1000,this.ttnl);
         this.updateTimer.addEventListener(TimerEvent.TIMER,this.updateLifeText);
         this.updateTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.newLifeReceived);
         this.updateTimer.start();
         this.updateLifeText();
      }
      
      private function newLifeReceived(event:TimerEvent) : void
      {
         removeListeners();
         this.closeHook();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function updateLifeText(event:TimerEvent = null) : void
      {
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         var _loc_5:String = null;
         var _loc_6:String = null;
         var _loc_7:String = null;
         var _loc_2:* = (this._whenToPollForLife - getTimer()) / 1000 - 2;
         if(_loc_2 < 0)
         {
            _popGfx.lifeCounter.text = "";
         }
         else if(_loc_2 >= 0.2)
         {
            _loc_3 = _loc_2 / 60;
            _loc_4 = Math.max(_loc_2 - _loc_3 * 60,0);
            _loc_5 = _loc_3 < 10 ? "0" + _loc_3.toString() : _loc_3.toString();
            _loc_6 = _loc_4 < 10 ? "0" + _loc_4.toString() : _loc_4.toString();
            _loc_7 = _loc_5 + ":" + _loc_6;
            if(_popGfx != null && _popGfx.lifeCounter != null)
            {
               _popGfx.lifeCounter.text = _loc_7;
            }
            else
            {
               this.updateTimer.removeEventListener(TimerEvent.TIMER,this.updateLifeText);
               this.updateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.newLifeReceived);
            }
            if(_popGfx != null)
            {
               TextUtil.scaleToFit(_popGfx.lifeCounter);
            }
         }
      }
      
      private function payButtonDown() : void
      {
         this.onBuyLives();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function friendButtonDown() : void
      {
         this.onAskForLives();
         this.setupAdTimer(3000);
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override protected function closeHook() : void
      {
         Console.println("Enter closeHook");
         this.setupAdTimer(1000);
         this.updateTimer.removeEventListener(TimerEvent.TIMER,this.updateLifeText);
         this.updateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.newLifeReceived);
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._friendButton.destruct();
         this._friendButton = null;
         this.setupAdTimer = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

