package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import flash.text.*;
   import popup.*;
   
   public class GameOverLossPop extends Popup
   {
      private var _retryButton:ButtonRegular;
      
      private var _clbRetryFunc:Function;
      
      public function GameOverLossPop(param1:Function, param2:Function, param3:int, param4:int, param5:int, param6:int, param7:String, param8:String, param9:HighScoreListVO)
      {
         super(param1,new GameOverContentLoss());
         popId = "GameOverLossPop";
         this._clbRetryFunc = param2;
         var _loc_10:* = I18n.getString("popup_game_over_title_loss",param5);
         _popGfx.iStarMeter.gotoAndStop(1);
         _popGfx.iGameModeSymbol.gotoAndStop(param7);
         _popGfx.tGameEndReason.text = this.getGameEndReasonText(param8,param6);
         _popGfx.tGameEndReason.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tGameEndReason.embedFonts = false;
         _popGfx.tTitle.text = _loc_10;
         _popGfx.tTitle.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         _popGfx.tTitle.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tGameEndReason);
         TextUtil.scaleToFit(_popGfx.tTitle);
         this._retryButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_game_over_loss_button_retry"),this.retryButtonDown);
         this._retryButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         _popGfx.tGameEndReason.autoSize = TextFieldAutoSize.LEFT;
         _popGfx.tGameEndReason.y = _popGfx.iGameModeSymbol.y + _popGfx.iGameModeSymbol.height / 2 - _popGfx.tGameEndReason.height / 2;
         if(param9 != null)
         {
            addFriendsList(param3,param4,param9);
         }
         this.setCharacterMode("sad");
         SoundInterface.playSound(SoundInterface.ZERO_STARS);
         SoundInterface.getMusicPlayer().playLossMusicAfterGame();
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
         SoundInterface.getMusicPlayer().stopLossMusicAfterGame();
      }
      
      private function setCharacterMode(param1:String) : void
      {
         _popGfx.character.gotoAndStop(param1);
      }
      
      private function getGameEndReasonText(param1:String, param2:int) : String
      {
         if(param1 == null)
         {
            param1 = "fail_reason_quit_button_pressed";
         }
         var _loc_3:* = "popup_game_over_" + param1;
         var _loc_4:String = "";
         switch(param1)
         {
            case CCConstants.GAME_FAIL_REASON_LOW_SCORE:
               _loc_4 = I18n.getString(_loc_3,ScoreFormatter.format(param2));
               break;
            case CCConstants.GAME_FAIL_REASON_OUT_OF_TIME:
               _loc_4 = I18n.getString(_loc_3,ScoreFormatter.format(param2));
               break;
            default:
               _loc_4 = I18n.getString(_loc_3);
         }
         return _loc_4;
      }
      
      protected function retryButtonDown(event:MouseEvent = null) : void
      {
         var _loc_2:Boolean = false;
         if(this._clbRetryFunc != null)
         {
            _loc_2 = true;
            this._clbRetryFunc(_loc_2);
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
         SoundInterface.getMusicPlayer().stopLossMusicAfterGame();
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 120;
         _popGfx.y = -_popGfx.height;
      }
      
      override protected function tweenTo(param1:int) : void
      {
         param1 = 40;
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
      
      override public function destruct() : void
      {
         super.destruct();
         this._retryButton.destruct();
         this._retryButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

