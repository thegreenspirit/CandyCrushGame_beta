package com.midasplayer.candycrushsaga.topnav
{
   import com.demonsters.debugger.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import flash.display.*;
   import flash.events.*;
   
   public class SoundPanel
   {
      private var _soundPanel:MovieClip;
      
      private var _mcSoundButtonMediator:TopNavBtnMediator;
      
      private var _mcMusicButtonMediator:TopNavBtnMediator;
      
      private var _soundOn:Boolean = true;
      
      private var _musicOn:Boolean = true;
      
      private var _tooltips:Array;
      
      private var _ccModel:CCModel;
      
      private var _soundManager:CCSoundManager;
      
      private var _musicManager:CCMusicManager;
      
      public function SoundPanel(param1:MovieClip, param2:CCModel, param3:CCSoundManager, param4:CCMusicManager)
      {
         super();
         this._musicManager = param4;
         this._soundManager = param3;
         this._ccModel = param2;
         this._soundPanel = param1;
         this._mcSoundButtonMediator = new TopNavBtnMediator(this._soundPanel.soundButton,null,true);
         this._mcMusicButtonMediator = new TopNavBtnMediator(this._soundPanel.musicButton,null,true);
         this._mcSoundButtonMediator.addEventListener(MouseEvent.CLICK,this.handleSoundButton);
         this._mcMusicButtonMediator.addEventListener(MouseEvent.CLICK,this.handleMusicButton);
         this._soundOn = this._ccModel.getInitialSoundFXSetting();
         this._musicOn = this._ccModel.getInitialMusicSetting();
         this._soundManager.setVolumeNormal();
         this._musicManager.setVolumeNormal();
         if(!this._soundOn)
         {
            this.turnOffSound(true);
         }
         if(!this._musicOn)
         {
            this.turnOffMusic(true);
         }
         this.turnOnMusic();
         this.turnOnSound();
      }
      
      public function handleSoundButton(event:Event) : void
      {
         if(this._soundOn)
         {
            this.turnOffSound();
         }
         else
         {
            this.turnOnSound();
         }
         MonsterDebugger.trace(this,"_soundManager.isOn=" + this._soundManager.isOn);
      }
      
      public function handleMusicButton(event:Event) : void
      {
         if(this._musicOn)
         {
            this.turnOffMusic();
         }
         else
         {
            this.turnOnMusic();
         }
         MonsterDebugger.trace(this,"_musicManager.isOn=" + this._musicManager.isOn);
      }
      
      public function turnOnMusic() : void
      {
         if(!this._musicOn)
         {
            this._musicOn = true;
            this._ccModel.setMusic(true);
            this._mcMusicButtonMediator.isOn = true;
            this._musicManager.setVolumeNormal();
         }
      }
      
      public function turnOffMusic(param1:Boolean = false) : void
      {
         if(param1 || this._musicOn)
         {
            this._musicOn = false;
            this._ccModel.setMusic(false);
            this._mcMusicButtonMediator.isOn = false;
            this._musicManager.setVolumeOff();
         }
      }
      
      public function turnOnSound() : void
      {
         if(!this._soundOn)
         {
            this._soundOn = true;
            this._ccModel.setSound(true);
            this._mcSoundButtonMediator.isOn = true;
            this._soundManager.setVolumeNormal();
         }
      }
      
      public function turnOffSound(param1:Boolean = false) : void
      {
         if(param1 || this._soundOn)
         {
            this._soundOn = false;
            this._mcSoundButtonMediator.isOn = false;
            this._ccModel.setSound(false);
            this._soundManager.setVolumeOff();
         }
      }
      
      public function getSound() : Boolean
      {
         if(this._soundOn)
         {
            return true;
         }
         return false;
      }
      
      public function getMusic() : Boolean
      {
         if(this._musicOn)
         {
            return true;
         }
         return false;
      }
      
      public function cleanUp() : void
      {
         this._soundPanel = null;
         this._ccModel = null;
         this._soundManager = null;
         this._musicManager = null;
         this._mcSoundButtonMediator.removeEventListener(MouseEvent.CLICK,this.handleSoundButton);
         this._mcMusicButtonMediator.removeEventListener(MouseEvent.CLICK,this.handleMusicButton);
      }
   }
}

