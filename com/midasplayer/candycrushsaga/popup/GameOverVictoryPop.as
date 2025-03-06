package com.midasplayer.candycrushsaga.popup
{
   import balance.*;
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.king.saga.api.crafting.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class GameOverVictoryPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      private var _clbContinueFunc:Function;
      
      private var _dropClips:Array;
      
      private var ccMain:CCMain;
      
      private var levelId_var:int = 0;
      
      private var score:int = 0;
      
      private var stars:int = 0;
      
      private var episodeId_var:int = 0;
      
      public function GameOverVictoryPop(param1:Function, param2:Function, param3:Object, param4:int, param5:int, param6:int, param7:HighScoreListVO, param8:Vector.<ItemAmount>, param9:CCMain)
      {
         var _loc_11:int = 0;
         var _loc_12:int = 0;
         var _loc_13:ItemAmount = null;
         var _loc_14:MovieClip = null;
         super(param1,new GameOverContentVictory());
         this.ccMain = param9;
         popId = "GameOverVictoryPop";
         this._clbContinueFunc = param2;
         this.episodeId_var = param3.episodeId;
         this.levelId_var = param3.levelId;
         var _loc_10:* = param3.isBestResult;
         this.score = param3.score;
         this.stars = param3.stars;
         if(param8.length > 0)
         {
            _popGfx.gotoAndStop("drops");
         }
         else
         {
            _popGfx.gotoAndStop("noDrops");
         }
         _popGfx.tTitle.embedFonts = false;
         _popGfx.tTitle.text = I18n.getString("popup_game_over_victory_title",param9.getTotalLevel());
         TextUtil.scaleToFit(_popGfx.tTitle);
         _popGfx.iCurtainTop.gotoAndStop(this.stars);
         if(this.stars == 3)
         {
            this.setCharacterMode("superHappy");
         }
         else
         {
            this.setCharacterMode("happy");
         }
         switch(this.stars)
         {
            case 3:
               SoundInterface.playSound(SoundInterface.THREE_STARS);
               break;
            case 2:
               SoundInterface.playSound(SoundInterface.TWO_STARS);
               break;
            case 1:
               SoundInterface.playSound(SoundInterface.ONE_STARS);
         }
         _popGfx.tYourScoreText.text = I18n.getString("popup_game_over_victory_your_score");
         _popGfx.tYourScoreNum.text = ScoreFormatter.format(this.score);
         _popGfx.tHighestScoreText.text = I18n.getString("popup_game_over_victory_best_ever");
         _popGfx.tHighestScoreNum.text = ScoreFormatter.format(param4);
         TextUtil.scaleToFit(_popGfx.tHighestScoreText);
         if(param8.length > 0)
         {
            _popGfx.tCandyCollected.text = I18n.getString("popup_game_over_victory_candy_collected");
            TextUtil.scaleToFit(_popGfx.tCandyCollected);
            this._dropClips = new Array();
            _loc_11 = 35;
            _loc_12 = _popGfx.iButtonContinue.x + _popGfx.iButtonContinue.width / 2 - param8.length * _loc_11 / 2;
            for each(_loc_13 in param8)
            {
               _loc_14 = new DropForPop();
               _loc_14.iDrop.gotoAndStop(_loc_13.getType());
               _loc_14.tAmount.text = _loc_13.getAmount().toString();
               _loc_14.x = _loc_12;
               _loc_14.y = 352;
               this._dropClips.push(_loc_14);
               _popGfx.addChild(_loc_14);
               _loc_12 += _loc_11;
               TextUtil.scaleToFit(_loc_14.tAmount);
            }
         }
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_game_over_victory_button_share"),this.continueButtonDown);
         this._continueButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         if(param7 != null)
         {
            addFriendsList(this.episodeId_var,this.levelId_var,param7);
            _friendsList.y += 40;
         }
         TextUtil.scaleToFit(_popGfx.tYourScoreText);
         TextUtil.scaleToFit(_popGfx.tYourScoreNum);
         TextUtil.scaleToFit(_popGfx.tHighestScoreText);
         TextUtil.scaleToFit(_popGfx.tHighestScoreNum);
         SoundInterface.getMusicPlayer().playVictoryMusicAfterGame();
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
         SoundInterface.getMusicPlayer().stopVictoryMusicAfterGame();
      }
      
      private function setCharacterMode(param1:String) : void
      {
         _popGfx.character.gotoAndStop(param1);
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 0;
         _popGfx.y = -_popGfx.height;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         param1 = 30;
         TweenLite.to(_popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1,
            "ease":Back.easeOut,
            "easeParams":[Popup.EASE_PARAM_VALUE]
         });
      }
      
      override protected function positionFriendsList() : void
      {
         _friendsList.x = 490;
         _friendsList.y = 160;
      }
      
      protected function continueButtonDown(event:MouseEvent = null) : void
      {
         var _loc_2:* = this.ccMain.getTotalLevel();
         if(this._clbContinueFunc != null)
         {
            this._clbContinueFunc(_loc_2,this.score,this.stars);
         }
         SoundInterface.getMusicPlayer().stopVictoryMusicAfterGame();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         var _loc_1:MovieClip = null;
         super.destruct();
         for each(_loc_1 in this._dropClips)
         {
            if(_loc_1.parent != null)
            {
               _loc_1.parent.removeChild(_loc_1);
            }
            _loc_1 = null;
         }
         this._dropClips = null;
         this._continueButton.destruct();
         this._continueButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

