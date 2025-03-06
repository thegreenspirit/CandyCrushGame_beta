package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.king.saga.api.listener.IToplistListener;
   import com.king.saga.api.toplist.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class FriendBeatenPop extends Popup implements IToplistListener
   {
      private var _continueButton:ButtonRegular;
      
      private var _clbContinueFunc:Function;
      
      private var _friendUserId:Number = 0;
      
      private var _friendUserIdStr:String;
      
      private var _friendScore:int;
      
      private var _currentUserId:Number = 0;
      
      private var _currentUserScore:int;
      
      private var _friendName:String;
      
      private var _currentUserName:String;
      
      private var episodeId:int = 0;
      
      private var levelId:int = 0;
      
      private var ccMain:CCMain;
      
      public function FriendBeatenPop(param1:Function, param2:Function, param3:FriendBeatenVO, param4:HighScoreListVO, param5:CCMain)
      {
         super(param1,new FriendBeatenContent());
         popId = "FriendBeatenPop";
         this._clbContinueFunc = param2;
         this.ccMain = param5;
         this._friendUserId = param3.friendUserId;
         this._friendUserIdStr = param3.friendUserIdStr;
         this._currentUserId = param3.currentUserId;
         this._friendName = param3.friendName;
         this._currentUserName = param3.currentuserName;
         this.episodeId = param3.episodeId;
         this.levelId = param3.levelId;
         var _loc_6:* = param3.getBigUserPicById;
         var _loc_7:* = param3.loadTopListByLevel;
         _popGfx.tTitle.text = I18n.getString("popup_friend_beaten_title");
         _popGfx.tTitle.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tTitle.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tTitle);
         var _loc_8:* = _loc_6(this._currentUserId);
         var _loc_9:* = _loc_6(this._friendUserId);
         _popGfx.iSlotUp.iPicFrame.iPicContainter.addChild(_loc_8);
         _popGfx.iSlotDown.iPicFrame.iPicContainter.addChild(_loc_9);
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_friend_beaten_button_share"),this.continueButtonDown);
         this._continueButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         _popGfx.iSlotUp.tScore.text = "";
         _popGfx.iSlotUp.tName.text = "";
         _popGfx.iSlotUp.tPosition.text = "";
         _popGfx.iSlotDown.tScore.text = "";
         _popGfx.iSlotDown.tName.text = "";
         _popGfx.iSlotDown.tPosition.text = "";
         _popGfx.tMessage.text = "";
         _popGfx.tLevel.text = "";
         _popGfx.tLevel.text = I18n.getString("popup_friend_beaten_level",param5.getTotalLevel());
         _popGfx.tLevel.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tLevel.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tLevel);
         _loc_7(this.episodeId,this.levelId,this);
         if(param4 != null)
         {
            addFriendsList(this.episodeId,this.levelId,param4);
         }
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
         SoundInterface.playSound(SoundInterface.FRIEND_BEATEN);
      }
      
      override protected function closeHook() : void
      {
      }
      
      public function onGetToplist(param1:Vector.<ToplistProfile>) : void
      {
         var _loc_3:int = 0;
         var _loc_4:ToplistProfile = null;
         var _loc_2:int = 0;
         for each(_loc_4 in param1)
         {
            _loc_2++;
            if(_loc_4.getToplistUser().getUserId() == this._currentUserId)
            {
               _popGfx.iSlotUp.tScore.text = ScoreFormatter.format(_loc_4.getToplistUser().getValue());
               _popGfx.iSlotUp.tScore.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tScore.embedFonts = false;
               _popGfx.iSlotUp.tName.text = this._currentUserName;
               _popGfx.iSlotUp.tName.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tName.embedFonts = false;
               _popGfx.iSlotUp.tPosition.text = "#" + _loc_2;
               _popGfx.iSlotUp.tPosition.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tPosition.embedFonts = false;
               _loc_3 = _loc_2;
               this._currentUserScore = _loc_4.getToplistUser().getValue();
            }
            else if(_loc_4.getToplistUser().getUserId() == this._friendUserId)
            {
               _popGfx.iSlotDown.tScore.text = ScoreFormatter.format(_loc_4.getToplistUser().getValue());
               _popGfx.iSlotDown.tName.text = this._friendName;
               _popGfx.iSlotDown.tPosition.text = "#" + _loc_2;
               this._friendScore = _loc_4.getToplistUser().getValue();
               _popGfx.iSlotUp.tScore.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tScore.embedFonts = false;
               _popGfx.iSlotUp.tName.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tName.embedFonts = false;
               _popGfx.iSlotUp.tPosition.setTextFormat(LocalConstants.FORMAT());
               _popGfx.iSlotUp.tPosition.embedFonts = false;
            }
            TextUtil.scaleToFit(_popGfx.iSlotDown.tScore);
            TextUtil.scaleToFit(_popGfx.iSlotDown.tName);
            TextUtil.scaleToFit(_popGfx.iSlotDown.tPosition);
            TextUtil.scaleToFit(_popGfx.iSlotUp.tScore);
            TextUtil.scaleToFit(_popGfx.iSlotUp.tName);
            TextUtil.scaleToFit(_popGfx.iSlotUp.tPosition);
         }
         _popGfx.tMessage.text = I18n.getString("popup_friend_beaten_message",this._friendName,_loc_3.toString());
         _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tMessage.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tMessage);
      }
      
      private function continueButtonDown() : void
      {
         if(this._clbContinueFunc != null)
         {
            this._clbContinueFunc(this._friendUserIdStr,this.ccMain.getTotalLevel(),this._friendName,this._friendScore,this._currentUserScore);
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override protected function positionPop() : void
      {
         _popGfx.x = 70;
         _popGfx.y = -_popGfx.height;
      }
      
      override protected function positionFriendsList() : void
      {
         _friendsList.x = 401;
         _friendsList.y = 82;
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
      
      override public function destruct() : void
      {
         super.destruct();
         this._continueButton.destruct();
         this._continueButton = null;
      }
      
      public function onGetLevelToplists(param1:Vector.<LevelToplist>) : void
      {
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

