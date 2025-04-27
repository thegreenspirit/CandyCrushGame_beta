package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.balance.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import popup.*;
   
   public class GameStartPop extends Popup
   {
      private static const POP_TWEEN_DESTY:int = 30;
      
      private var _playButton:ButtonRegular;
      
      private var _clbPlayFunc:Function;
      
      private var _boostermodule:BoosterModule;
      
      private var _gameMode:String;
      
      private var _ccMain:CCMain;
      
      private var _nextScoreTarget:int;
      
      public function GameStartPop(param1:Function, param2:Function, param3:int, param4:int, param5:Inventory, param6:CCMain)
      {
         var _loc_9:Function = null;
         super(param1,new GameStartContent());
         popId = "GameStartPop";
         this._ccMain = param6;
         this._clbPlayFunc = param2;
         this._gameMode = param6.getGameMode();
         this._nextScoreTarget = param6.getNextScoreTarget();
         var _loc_7:* = param6.getStars();
         var _loc_8:* = param6.getBestScoreEver();
         _popGfx.iTarget.gotoAndStop(_loc_7 + 1);
         _popGfx.iTarget.iTargetBox.gotoAndStop(_loc_7 + 1);
         if(param5.getAvailableBoostersAmount(BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME) == 0)
         {
            _popGfx.gotoAndStop("noBoosters");
         }
         else if(param5.getAvailableBoostersAmount(BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME) < 5)
         {
            _popGfx.gotoAndStop("oneRowBoosters");
            this.setupBoosterModule(param5,this._gameMode);
         }
         else
         {
            _popGfx.gotoAndStop("twoRowBoosters");
            this.setupBoosterModule(param5,this._gameMode);
         }
         _popGfx.tLevel.text = I18n.getString("popup_game_start_level",param6.getTotalLevel());
         _popGfx.tLevel.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         _popGfx.tLevel.embedFonts = false;
         if(_loc_7 < 3)
         {
            _popGfx.iTarget.tNextTarget.text = I18n.getString("popup_game_start_next_target",ScoreFormatter.format(this._nextScoreTarget));
            _popGfx.iTarget.tNextTarget.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
            _popGfx.iTarget.tNextTarget.embedFonts = false;
            TextUtil.scaleToFit(_popGfx.iTarget.tNextTarget);
         }
         else
         {
            _loc_9 = this.setTopPlayer;
         }
         if(_loc_8 > 0)
         {
            _popGfx.tHighestScoreText.text = I18n.getString("popup_game_start_best_score");
            _popGfx.tHighestScoreText.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tHighestScoreText.embedFonts = false;
            _popGfx.tHighestScoreNum.text = ScoreFormatter.format(param6.getBestScoreEver());
            _popGfx.tHighestScoreNum.setTextFormat(LocalConstants.FORMAT());
            _popGfx.tHighestScoreNum.embedFonts = false;
            TextUtil.scaleToFit(_popGfx.tHighestScoreText);
         }
         else
         {
            _popGfx.tHighestScoreText.text = "";
            _popGfx.tHighestScoreNum.text = "";
         }
         _popGfx.iGameMode.gotoAndStop(this._gameMode);
         _popGfx.tMessage.text = this.getGameModeDesc(this._gameMode);
         _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tMessage.embedFonts = false;
         _popGfx.tMessage.autoSize = TextFieldAutoSize.LEFT;
         _popGfx.tMessage.y = _popGfx.iGameMode.y + _popGfx.iGameMode.height / 2 - _popGfx.tMessage.height / 2;
         TextUtil.scaleToFit(_popGfx.tMessage);
         TextUtil.scaleToFit(_popGfx.tLevel);
         this._playButton = new ButtonRegular(_popGfx.iButtonPlay,I18n.getString("popup_game_start_button_play"),this.playButtonDown);
         this._playButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         addFriendsList(param3,param4,param6.getHighScoreListData(),_loc_9);
         this.addTutorials();
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 70;
         _popGfx.y = -_popGfx.height;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         param1 = POP_TWEEN_DESTY;
         TweenLite.to(_popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1,
            "ease":Back.easeOut,
            "easeParams":[EASE_PARAM_VALUE]
         });
      }
      
      override protected function positionFriendsList() : void
      {
         _friendsList.x = 401;
         _friendsList.y = 82;
      }
      
      private function setupBoosterModule(param1:Inventory, param2:String) : void
      {
         _popGfx.tSelectBoosters.text = I18n.getString("popup_game_start_select_boosters");
         _popGfx.tSelectBoosters.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         _popGfx.tSelectBoosters.embedFonts = false;
         this._boostermodule = new BoosterModule(param1,param2);
         TextUtil.scaleToFit(_popGfx.tSelectBoosters);
         _popGfx.addChild(this._boostermodule);
      }
      
      private function addTutorials() : void
      {
         var _loc_1:Array = null;
         var _loc_2:TutorialHandler = null;
         var _loc_3:BoosterButton = null;
         var _loc_4:String = null;
         var _loc_5:Boolean = false;
         var _loc_6:Boolean = false;
         var _loc_7:int = 0;
         var _loc_8:int = 0;
         var _loc_9:MovieClip = null;
         var _loc_10:int = 0;
         var _loc_11:int = 0;
         var _loc_12:Point = null;
         if(Boolean(this._boostermodule))
         {
            _loc_1 = this._boostermodule.getAvailableBoosterButtons();
            _loc_2 = this._ccMain.getTutorialHandler();
            for each(_loc_3 in _loc_1)
            {
               _loc_4 = TutorialHandler.POP_INTRODUCE_BOOSTER_PREFIX + _loc_3.getBoosterId();
               _loc_5 = this._ccMain.getSeenBoosterTut(_loc_4);
               _loc_6 = _loc_3.acceptedInGameMode(this._gameMode);
               if(!(_loc_5 || !_loc_6))
               {
                  _loc_7 = _popGfx.x + 2;
                  _loc_8 = POP_TWEEN_DESTY + 2;
                  _loc_9 = _loc_3.getMovieClip();
                  _loc_10 = _loc_3.x + _loc_9.width / 2;
                  _loc_11 = _loc_3.y + _loc_9.height / 2;
                  _loc_12 = new Point(_loc_7 + _loc_10,_loc_8 + _loc_11);
                  if(_loc_2.addTutorialPop(_loc_4,_loc_12,null,false) == true)
                  {
                     return;
                  }
               }
            }
         }
      }
      
      private function setTopPlayer(param1:NextUserTarget) : void
      {
         var _loc_2:* = param1.userScore;
         var _loc_3:* = param1.userPic;
         _popGfx.iTarget.targetPicHolder.addChild(_loc_3);
         _popGfx.iTarget.tNextTarget.text = I18n.getString("popup_game_start_next_target",ScoreFormatter.format(_loc_2));
         _popGfx.iTarget.tNextTarget.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         _popGfx.iTarget.tNextTarget.embedFonts = false;
         Console.println("@ setTopPlayer() - GameStartPop.as | score: " + _loc_2.toString());
      }
      
      private function getGameModeDesc(param1:String) : String
      {
         var _loc_2:* = this._ccMain.getGameConf();
         switch(param1)
         {
            case GameConf.MODE_NAME_BALANCE:
               return I18n.getString("popup_game_start_game_mode_balance");
            case GameConf.MODE_NAME_CLASSIC:
               return I18n.getString("popup_game_start_game_mode_classic",GameConfClassic(_loc_2).timeLimit().toString(),ScoreFormatter.format(this.getLowestScoreTarget()).toString());
            case GameConf.MODE_NAME_LIGHT_UP:
               return I18n.getString("popup_game_start_game_mode_light_up");
            case GameConf.MODE_NAME_CLASSIC_MOVES:
               return I18n.getString("popup_game_start_game_mode_classic_moves",ScoreFormatter.format(this.getLowestScoreTarget()),GameConfClassicMoves(_loc_2).moveLimit().toString());
            case GameConf.MODE_NAME_DROP_DOWN:
               return I18n.getString("popup_game_start_game_mode_drop_down");
            case GameConf.MODE_NAME_DROP_DOWN_SCORE:
               return I18n.getString("popup_game_start_game_mode_drop_down_score");
            case GameConf.MODE_NAME_LIGHT_UP_SCORE:
               return I18n.getString("popup_game_start_game_mode_light_up_score");
            default:
               return "";
         }
      }
      
      private function getNextScoreTarget() : int
      {
         return this._ccMain.getNextScoreTarget();
      }
      
      private function getLowestScoreTarget() : int
      {
         return this._ccMain.getLowestScoreTarget();
      }
      
      private function playButtonDown() : void
      {
         if(Boolean(this._boostermodule))
         {
            this._boostermodule.collectSelectedBoosters();
         }
         if(this._clbPlayFunc != null)
         {
            this._clbPlayFunc();
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         if(this._boostermodule != null)
         {
            this._boostermodule.destroy();
            this._boostermodule = null;
         }
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

