package com.midasplayer.candycrushsaga.sound
{
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.sound.*;
   import flash.events.*;
   import flash.utils.*;
   import sagaSound.*;
   
   public class CCSoundManager extends SoundManager implements IEventDispatcher
   {
      private static var _instance:CCSoundManager;
      
      public static const SOUND_VOLUME:int = 1;
      
      public static const SOUND_STATE_CHANGED:String = "soundStateChanged";
      
      private var _isOn:Boolean;
      
      private var tickTimer:Timer;
      
      private var _dispatcher:EventDispatcher;
      
      public function CCSoundManager(param1:Number = 1)
      {
         super();
         this.setVolume(param1);
         this.createTickTimer();
      }
      
      public static function getInstance() : CCSoundManager
      {
         if(!_instance)
         {
            _instance = new CCSoundManager(SOUND_VOLUME);
         }
         return _instance;
      }
      
      private function createTickTimer() : void
      {
         var _loc_2:* = 1000 / 60;
         if(this.tickTimer != null)
         {
            throw new Error("Must not create more than one CCSoundManager!");
         }
         this.tickTimer = new Timer(_loc_2);
         this.tickTimer.addEventListener(TimerEvent.TIMER,this.onTick);
         this.tickTimer.start();
      }
      
      public function playSound(param1:String, param2:Boolean = true) : void
      {
         switch(param1)
         {
            case SoundInterface.CLICK:
               this._play(ClickDefault,0.25);
               break;
            case SoundInterface.CLICK_WRAPPED:
               this._play(wrappedButton,1);
               break;
            case SoundInterface.ZOOMING:
               this._play(zooming,0.35);
               break;
            case SoundInterface.SEND_LIFE:
               this._play(rewardSound);
               break;
            case SoundInterface.THREE_STARS:
               this._play(starScore3,0.6);
               break;
            case SoundInterface.TWO_STARS:
               this._play(starScore2,0.6);
               break;
            case SoundInterface.ONE_STARS:
               this._play(starScore1,0.6);
               break;
            case SoundInterface.ZERO_STARS:
               break;
            case SoundInterface.STAR_SOUND:
               this._play(rewardSound,0.5);
               break;
            case SoundInterface.LEVEL_UNLOCK:
               this._play(levelUnlocked,0.7);
               break;
            case SoundInterface.EPISODE_TRANSPORT:
               this._play(allAboard,0.6);
               break;
            case SoundInterface.MAP_WALK:
               this._play(footsteps);
               break;
            case SoundInterface.ERROR_ALERT:
               this._play(errorAlert);
               break;
            case SoundInterface.SWIPE_IN:
               this._play(swipeIn,0.5);
               break;
            case SoundInterface.SWIPE_OUT:
               this._play(swipeOut,0.5);
               break;
            case SoundInterface.PLASTIC_DROP:
               this._play(plasticHit,0.3);
               break;
            case SoundInterface.FRIEND_BEATEN:
               this._play(friendBeaten,0.8);
               break;
            case SoundInterface.FRIEND_PASSED:
               this._play(friendPassed,0.8);
               break;
            case SoundInterface.BOOSTER_UNLOCKED:
               this._play(boosterUnlocked,0.8);
               break;
            case SoundInterface.BOOSTER_CREATED:
               this._play(boosterCreated,0.8);
               break;
            case SoundInterface.SHOW_SIGN:
               this._play(SignSwoosh,0.3);
               break;
            case SoundInterface.BOSS_OBJECTED_COMPLETED:
               this._play(levelUnlocked,0.7);
               break;
            case SoundInterface.COLLABORATION_BUTTON_UNLOCK:
               this._play(ticketsPlease,0.7);
         }
      }
      
      override public function setVolume(param1:Number) : void
      {
         super.setVolume(param1);
         this.dispatchEvent(new Event(CCSoundManager.SOUND_STATE_CHANGED));
      }
      
      protected function _play(param1:*, param2:Number = 1, param3:Number = 0) : ManagedSound
      {
         var _loc_4:* = getFromClass(param1);
         if(param3 == 0)
         {
            _loc_4.play(param2);
         }
         else
         {
            _loc_4.play(0);
            _loc_4.fadeTo(param2,param3);
         }
         return _loc_4;
      }
      
      protected function _loop(param1:*, param2:Number = 1, param3:Number = 0) : ManagedSound
      {
         var _loc_4:* = getFromClass(param1);
         if(param3 == 0)
         {
            _loc_4.loop(param2,0,99);
         }
         else
         {
            _loc_4.loop(0,0,99);
            _loc_4.fadeTo(param2,param3);
         }
         return _loc_4;
      }
      
      protected function _stop(param1:*, param2:Number = 0) : void
      {
         var _loc_3:* = getFromClass(param1);
         if(param2 == 0)
         {
            _loc_3.stop();
         }
         else
         {
            _loc_3.loop(0);
            _loc_3.fadeToAndStop(0,param2);
         }
      }
      
      public function onTick(event:TimerEvent) : void
      {
         super.update();
      }
      
      public function setVolumeNormal() : void
      {
         this._isOn = true;
         this.setVolume(SOUND_VOLUME);
      }
      
      public function setVolumeOff() : void
      {
         this._isOn = false;
         this.setVolume(0);
      }
      
      public function getMusicState() : void
      {
      }
      
      public function get isOn() : Boolean
      {
         return this._isOn;
      }
      
      protected function initDispatcher() : void
      {
         if(this._dispatcher == null)
         {
            this._dispatcher = new EventDispatcher(this);
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this._dispatcher == null)
         {
            this.initDispatcher();
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(Boolean(this._dispatcher))
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this._dispatcher == null ? false : this._dispatcher.dispatchEvent(event);
      }
   }
}

import com.midasplayer.sound.SoundManager;

