package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class FriendPassedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      private var _clbContinueFunc:Function;
      
      private var _friendUserIdStr:String;
      
      private var episodeId:int = 0;
      
      private var levelId:int = 0;
      
      private var ccMain:CCMain;
      
      public function FriendPassedPop(param1:Function, param2:Function, param3:FriendPassedVO, param4:CCMain)
      {
         super(param1,new FriendPassedContent());
         popId = "FriendPassedPop";
         this._clbContinueFunc = param2;
         this.ccMain = param4;
         var _loc_5:* = param3.currentUserId;
         var _loc_6:* = param3.currentuserName;
         var _loc_7:* = param3.friendUserId;
         this._friendUserIdStr = param3.friendUserIdStr;
         var _loc_8:* = param3.friendName;
         var _loc_9:* = param3.getBigUserPicById;
         this.episodeId = param3.episodeId;
         this.levelId = param3.levelId;
         _popGfx.tTitle.text = I18n.getString("popup_friend_passed_title");
         _popGfx.tMessage.text = I18n.getString("popup_friend_passed_message",_loc_8);
         var _loc_10:* = _loc_9(_loc_5);
         var _loc_11:* = _loc_9(_loc_7);
         _popGfx.iSlotPasser.iFrame.iPicContainer.addChild(_loc_10);
         _popGfx.iSlotPassed.iPicContainer.addChild(_loc_11);
         _popGfx.tLevel.text = I18n.getString("popup_friend_passed_level",param4.getTotalLevel());
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_friend_passed_button_share"),this.continueButtonDown);
         TextUtil.scaleToFit(_popGfx.tLevel);
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
         SoundInterface.playSound(SoundInterface.FRIEND_PASSED);
      }
      
      override protected function closeHook() : void
      {
      }
      
      private function continueButtonDown() : void
      {
         if(this._clbContinueFunc != null)
         {
            this._clbContinueFunc(this._friendUserIdStr,this.ccMain.getTotalLevel());
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
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

