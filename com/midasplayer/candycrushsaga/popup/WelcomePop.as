package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class WelcomePop extends Popup
   {
      private var _playButton:ButtonRegular;
      
      private var _bouncingCouple:MovieClip;
      
      private var _clbPlayFunc:Function;
      
      private var _gameMode:String;
      
      private var _addCutsceneSnapShot:Function;
      
      private var _hidePreloader:Function;
      
      public function WelcomePop(param1:Function, param2:Function, param3:Function, param4:Function)
      {
         super(param1,new WelcomeContent());
         popId = "WelcomePop";
         this._clbPlayFunc = param2;
         this._addCutsceneSnapShot = param3;
         this._hidePreloader = param4;
         _popGfx.tLevel.text = I18n.getString("popup_welcome_title");
         _popGfx.tWelcomeDesc.text = I18n.getString("popup_welcome_description");
         _popGfx.iBG.iButtonQuit.visible = false;
         this._playButton = new ButtonRegular(_popGfx.iButtonPlay,I18n.getString("popup_game_start_button_play"),this.playButtonDown);
         this._playButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._bouncingCouple = new BouncingCouple();
         this._bouncingCouple.y = CCConstants.STAGE_HEIGHT + this._bouncingCouple.height + CCConstants.TOPNAV_HEIGHT;
         CCMain.mcDisplayPopup.addChild(this._bouncingCouple);
         TextUtil.scaleToFit(_popGfx.tLevel);
         TextUtil.scaleToFit(_popGfx.tWelcomeDesc);
      }
      
      override public function triggerCommand() : void
      {
         this._addCutsceneSnapShot();
         this._hidePreloader();
         var _loc_1:* = CCConstants.STAGE_HEIGHT - this._bouncingCouple.height + 15;
         TweenLite.to(this._bouncingCouple,1,{"y":_loc_1});
         super.triggerCommand();
      }
      
      private function playButtonDown() : void
      {
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK_WRAPPED);
         if(this._clbPlayFunc != null)
         {
            this._clbPlayFunc();
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         if(this._bouncingCouple.parent != null)
         {
            this._bouncingCouple.parent.removeChild(this._bouncingCouple);
         }
         this._bouncingCouple = null;
         this._playButton.destruct();
         this._playButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

