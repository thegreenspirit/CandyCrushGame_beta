package com.midasplayer.candycrushsaga.popup
{
   import com.king.saga.api.listener.IToplistListener;
   import com.king.saga.api.toplist.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import main.*;
   import popup.*;
   
   public class FriendsHighscoreListMediator extends EventDispatcher implements IToplistListener
   {
      public static const USER:String = "user";
      
      public static const FIRST:String = "first";
      
      public static const OTHER:String = "other";
      
      public static const ON_TOP_6:String = "onTop6";
      
      public static const OFF_TOP_6:String = "offTop6";
      
      public static const OVER:String = "over";
      
      public static const NORMAL:String = "normal";
      
      public static const SENT:String = "sent";
      
      private var viewComponent:MovieClip;
      
      private var topListUserObjArr:Array;
      
      private var userToGiftId:int;
      
      private var clickedMc:MovieClip;
      
      private var _currentUserId:Number = 0;
      
      private var _getSmallUserPicById:Function;
      
      private var _getBigUserPicById:Function;
      
      private var _loadTopListByLevel:Function;
      
      private var _getUserProfile:Function;
      
      private var _sendHighscoreLifeTo:Function;
      
      public function FriendsHighscoreListMediator(param1:HighScoreListVO)
      {
         super();
         this._currentUserId = param1.currentUserId;
         this._getSmallUserPicById = param1.getSmallUserPicById;
         this._getBigUserPicById = param1.getBigUserPicById;
         this._loadTopListByLevel = param1.loadTopListByLevel;
         this._getUserProfile = param1.getUserProfile;
         this._sendHighscoreLifeTo = param1.sendHighscoreLifeTo;
         this.viewComponent = new HighscoreBar();
      }
      
      private function addMouseListeners(param1:MovieClip) : void
      {
         param1.gotoAndStop(NORMAL);
         this.removeMouseListeners(param1);
         param1.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         param1.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function removeMouseListeners(param1:MovieClip) : void
      {
         param1.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         param1.removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onClick);
      }
      
      private function onClick(event:MouseEvent) : void
      {
         var _loc_2:int = 0;
         SoundInterface.playSound(SoundInterface.SEND_LIFE);
         this.clickedMc = event.currentTarget as MovieClip;
         this.clickedMc.gotoAndStop(SENT);
         this.removeMouseListeners(this.clickedMc);
         switch(this.clickedMc.parent)
         {
            case this.viewComponent.score_1:
               _loc_2 = 1;
               break;
            case this.viewComponent.score_2:
               _loc_2 = 2;
               break;
            case this.viewComponent.score_3:
               _loc_2 = 3;
               break;
            case this.viewComponent.score_4:
               _loc_2 = 4;
               break;
            case this.viewComponent.score_5:
               _loc_2 = 5;
               break;
            case this.viewComponent.score_6:
               _loc_2 = 6;
               break;
            default:
               return;
         }
         this.userToGiftId = this.topListUserObjArr[_loc_2 - 1];
         this.trySetGiveLifeData(this.userToGiftId);
      }
      
      private function trySetGiveLifeData(param1:int) : void
      {
         LocalStorage.setCookie(CookieObjectVO.GIVE_LIFE,param1,CookieObjectVO.LIFE_GIFT_TTL,this.trySetGiveLifeDataReply);
      }
      
      private function trySetGiveLifeDataReply(param1:Boolean) : void
      {
         if(param1)
         {
            this._sendHighscoreLifeTo(this.userToGiftId);
         }
      }
      
      private function onOut(event:MouseEvent) : void
      {
         event.currentTarget.gotoAndStop(NORMAL);
      }
      
      private function onOver(event:MouseEvent) : void
      {
         event.currentTarget.gotoAndStop(OVER);
      }
      
      private function setHighscoreData(param1:Vector.<ToplistProfile>) : void
      {
         var _loc_3:Object = null;
         var _loc_4:String = null;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         this.topListUserObjArr = [];
         this.viewComponent.higshscoreLabel.text = I18n.getString("popup_highscore_friends_label");
         this.viewComponent.higshscoreLabel.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         this.viewComponent.higshscoreLabel.embedFonts = false;
         TextUtil.scaleToFit(this.viewComponent.higshscoreLabel);
         var _loc_2:* = this.getPlayerPos(param1);
         _loc_4 = _loc_2 == 1 ? USER : FIRST;
         _loc_3 = this.getRowObj(1,param1);
         this.setRowScore(this.viewComponent.score_1,_loc_4,_loc_3);
         _loc_4 = _loc_2 == 2 ? USER : OTHER;
         _loc_3 = this.getRowObj(2,param1);
         this.setRowScore(this.viewComponent.score_2,_loc_4,_loc_3);
         _loc_4 = _loc_2 == 3 ? USER : OTHER;
         _loc_3 = this.getRowObj(3,param1);
         this.setRowScore(this.viewComponent.score_3,_loc_4,_loc_3);
         if(_loc_2 <= 6)
         {
            this.viewComponent.gotoAndStop(ON_TOP_6);
            _loc_4 = _loc_2 == 4 ? USER : OTHER;
            _loc_3 = this.getRowObj(4,param1);
            this.setRowScore(this.viewComponent.score_4,_loc_4,_loc_3);
            _loc_4 = _loc_2 == 5 ? USER : OTHER;
            _loc_3 = this.getRowObj(5,param1);
            this.setRowScore(this.viewComponent.score_5,_loc_4,_loc_3);
            _loc_4 = _loc_2 == 6 ? USER : OTHER;
            _loc_3 = this.getRowObj(6,param1);
            this.setRowScore(this.viewComponent.score_6,_loc_4,_loc_3);
         }
         else
         {
            this.viewComponent.gotoAndStop(OFF_TOP_6);
            _loc_5 = _loc_2 - 1;
            _loc_6 = _loc_2 + 1;
            _loc_3 = this.getRowObj(_loc_5,param1);
            this.setRowScore(this.viewComponent.score_4,OTHER,_loc_3);
            _loc_3 = this.getRowObj(_loc_2,param1);
            this.setRowScore(this.viewComponent.score_5,USER,_loc_3);
            _loc_3 = this.getRowObj(_loc_6,param1);
            this.setRowScore(this.viewComponent.score_6,OTHER,_loc_3);
         }
      }
      
      private function hideAllRows() : void
      {
         this.viewComponent.visible = false;
      }
      
      private function getHighscoreData(param1:int, param2:int) : void
      {
         this._loadTopListByLevel(param1,param2,this);
      }
      
      public function onGetToplist(param1:Vector.<ToplistProfile>) : void
      {
         var _loc_4:uint = 0;
         this.setHighscoreData(param1);
         var _loc_2:* = new NextUserTarget(NextUserTarget.HIGHSCORE_DATA_RECEIVED);
         var _loc_3:Number = 0;
         while(_loc_4 < param1.length)
         {
            if(param1[_loc_4].getUserProfile().getUserId() == this._currentUserId)
            {
               if(_loc_4 > 0)
               {
                  _loc_2.userScore = param1[_loc_4 - 1].getToplistUser().getValue();
                  _loc_3 = param1[_loc_4 - 1].getUserProfile().getUserId();
                  break;
               }
               _loc_2.userScore = param1[_loc_4].getToplistUser().getValue();
               _loc_3 = param1[_loc_4].getUserProfile().getUserId();
               break;
            }
            _loc_2.userScore = param1[param1.length - 1].getToplistUser().getValue();
            _loc_3 = param1[param1.length - 1].getUserProfile().getUserId();
            _loc_4 += 1;
         }
         if(_loc_3 != 0)
         {
            _loc_2.userPic = this._getBigUserPicById(_loc_3);
         }
         dispatchEvent(_loc_2);
      }
      
      public function onGetToplistError(param1:String) : void
      {
      }
      
      public function getHighscoreListMcForLevel(param1:int, param2:int) : MovieClip
      {
         this.hideAllRows();
         this.getHighscoreData(param1,param2);
         return this.viewComponent as MovieClip;
      }
      
      public function onGetLevelToplists(param1:Vector.<LevelToplist>) : void
      {
      }
      
      private function setRowScore(param1:Object, param2:String, param3:Object) : void
      {
         var _loc_4:String = null;
         var _loc_5:UserProfile = null;
         var _loc_6:String = null;
         var _loc_8:MovieClip = null;
         var _loc_9:Object = null;
         var _loc_7:Number = NaN;
         if(param3.userId != 0)
         {
            _loc_5 = this._getUserProfile(param3.userId);
         }
         if(Boolean(_loc_5))
         {
            this.viewComponent.visible = true;
            this.topListUserObjArr.push(param3.userId);
            _loc_6 = _loc_5.getPicSquareUrl();
            _loc_4 = _loc_5.getName();
            if(!_loc_4)
            {
               _loc_4 = "Unknown";
            }
            _loc_7 = _loc_5.getUserId();
            _loc_8 = this._getSmallUserPicById(_loc_7);
            param1.pictureHolder.pictureAttacher.addChild(new DefaultUserPic());
            param1.pictureHolder.pictureAttacher.addChild(_loc_8);
            param1.gotoAndStop(param2);
            param1.positionLabel.text = param3.pos;
            param1.positionLabel.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
            param1.positionLabel.embedFonts = false;
            param1.nameLabel.text = _loc_4;
            param1.nameLabel.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
            param1.nameLabel.embedFonts = false;
            param1.scoreValue.text = ScoreFormatter.format(param3.score);
            param1.scoreValue.setTextFormat(LocalConstants.FORMAT());
            param1.scoreValue.embedFonts = false;
            if(_loc_5.getUserId() == this._currentUserId)
            {
               param1.sendLifeBtn.visible = false;
            }
            else
            {
               _loc_9 = LocalStorage.getCookie(CookieObjectVO.GIVE_LIFE,_loc_5.getUserId());
               if(_loc_9 == null || Boolean(_loc_9.expired))
               {
                  this.addMouseListeners(param1.sendLifeBtn);
                  param1.sendLifeBtn.buttonMode = true;
                  param1.sendLifeBtn.mouseChildren = false;
                  param1.sendLifeBtn.visible = true;
               }
               else
               {
                  param1.sendLifeBtn.gotoAndStop(SENT);
                  this.removeMouseListeners(param1.sendLifeBtn);
               }
            }
         }
         else
         {
            _loc_4 = "";
            param1.sendLifeBtn.visible = false;
            param1.visible = false;
         }
      }
      
      private function getRowObj(param1:int, param2:Vector.<ToplistProfile>) : Object
      {
         var _loc_3:* = new Object();
         var _loc_4:* = param1 > 0 && param1 <= param2.length ? param2[param1 - 1] : null;
         if(param1 > 0 && param1 <= param2.length ? Boolean(param2[param1 - 1]) : Boolean(null))
         {
            _loc_3.pos = param1;
            _loc_3.userId = _loc_4.getUserProfile().getUserId();
            _loc_3.score = _loc_4.getToplistUser().getValue();
         }
         else
         {
            _loc_3.pos = param1;
            _loc_3.userId = 0;
            _loc_3.score = "";
         }
         return _loc_3;
      }
      
      private function getPlayerPos(param1:Vector.<ToplistProfile>) : int
      {
         var _loc_3:ToplistProfile = null;
         var _loc_2:int = 0;
         while(_loc_2 < param1.length)
         {
            _loc_3 = param1[_loc_2];
            if(this._currentUserId == _loc_3.getUserProfile().getUserId())
            {
               return _loc_2 + 1;
            }
            _loc_2++;
         }
         return 0;
      }
   }
}

import flash.events.EventDispatcher;

