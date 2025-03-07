package com.midasplayer.candycrushsaga.popup.notificationcentral
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.king.saga.api.event.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.popup.notificationcentral.button.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   
   public class Notification extends MovieClip
   {
      public static const LIFE_REQUEST:String = "life_request";
      
      public static const HELP_REQUEST:String = "help_request";
      
      private var _clip:MovieClip;
      
      private var _userProfiles:UserProfiles;
      
      private var _type:String;
      
      private var _event:SagaEvent;
      
      protected var _buttons:Vector.<BasicButton>;
      
      private var help_btn:BasicButton;
      
      private var _closeNotification:Function;
      
      private var _tmpEpisodeId:int;
      
      private var _tmpLevelId:int;
      
      private var picLoaderFn:Function;
      
      private var sendLifeFn:Function;
      
      private var sendHelpFn:Function;
      
      public function Notification(param1:String, param2:SagaEvent, param3:UserProfiles, param4:Function, param5:Function, param6:Function, param7:Function)
      {
         super();
         this._buttons = new Vector.<BasicButton>();
         this.sendHelpFn = param7;
         this.sendLifeFn = param6;
         this.picLoaderFn = param5;
         this._clip = new gNotificationContent();
         addChild(this._clip);
         this._type = param1;
         this._event = param2;
         this._userProfiles = param3;
         this._closeNotification = param4;
         this.help_btn = new ButtonResizable(I18n.getString("popup_notification_central_button_accept"),this._sendRequest,this._clip.help_button);
         this.addButton(this.help_btn);
         this.addButton(new ButtonClose(this._close,this._clip.exit_button));
         if(this._type == LIFE_REQUEST)
         {
            this.handleLifeRequest(param2,this._userProfiles);
         }
         if(this._type == HELP_REQUEST)
         {
            this.handleUnlockRequest(param2,this._userProfiles);
         }
      }
      
      private function _close() : void
      {
         SoundInterface.playSound(SoundInterface.CLICK);
         this._closeNotification(this);
      }
      
      private function _sendRequest() : void
      {
         var _loc_3:int = 0;
         SoundInterface.playSound(SoundInterface.SEND_LIFE);
         if(this._type == LIFE_REQUEST)
         {
            _loc_3 = LifeRequestEvent(this._event).getFromId();
            this.sendLifeFn(_loc_3);
         }
         else if(this._type == HELP_REQUEST)
         {
            _loc_3 = LevelUnlockRequestEvent(this._event).getFromId();
            this.sendHelpFn(_loc_3,this._tmpEpisodeId,this._tmpLevelId);
         }
         var _loc_4:* = new gCheckSymbol();
         _loc_4.x = 500;
         _loc_4.y = 30;
         _loc_4.alpha = 0;
         _loc_4.scaleY = 0.1;
         _loc_4.scaleX = 0.1;
         this._clip.addChild(_loc_4);
         TweenLite.to(_loc_4,0.3,{
            "alpha":1,
            "scaleX":1.1,
            "scaleY":1.1,
            "ease":Back.easeInOut
         });
         this._clip.removeChild(this.help_btn);
      }
      
      private function handleLifeRequest(event:SagaEvent, param2:UserProfiles) : void
      {
         var _loc_3:String = null;
         var _loc_5:Number = NaN;
         var _loc_4:String = "";
         _loc_5 = LifeRequestEvent(event).getFromId();
         Debug.assert(param2.exists(_loc_5),"A notification has been created for a non existing user: " + _loc_5);
         _loc_3 = this._userProfiles.getUserProfile(_loc_5).getPicSquareUrl();
         if(this._userProfiles.exists(_loc_5))
         {
            _loc_4 = this._userProfiles.getUserProfile(_loc_5).getName();
         }
         var _loc_6:* = this.picLoaderFn(_loc_5,50,50);
         this._clip.picture_frame.picture_container.addChild(_loc_6);
         this._clip.symbols.gotoAndStop(1);
         this._clip.header_txt.text = I18n.getString("popup_notification_central_life_request_header",_loc_4);
         this._clip.header_txt.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         this._clip.header_txt.embedFonts = false;
         this._clip.body_txt.text = I18n.getString("popup_notification_central_life_request_message",_loc_4);
         this._clip.body_txt.setTextFormat(LocalConstants.FORMAT());
         this._clip.header_txt.embedFonts = false;
      }
      
      private function handleUnlockRequest(event:SagaEvent, param2:UserProfiles) : void
      {
         var _loc_3:String = null;
         var _loc_5:Number = NaN;
         var _loc_4:String = "";
         _loc_5 = LevelUnlockRequestEvent(event).getFromId();
         Debug.assert(param2.exists(_loc_5),"A notification has been created for a non existing user: " + _loc_5);
         _loc_3 = this._userProfiles.getUserProfile(_loc_5).getPicSquareUrl();
         _loc_4 = this._userProfiles.getUserProfile(_loc_5).getName();
         var _loc_6:* = this.picLoaderFn(_loc_5,50,50);
         this._clip.picture_frame.picture_container.addChild(_loc_6);
         this._clip.symbols.gotoAndStop(2);
         this._tmpEpisodeId = LevelUnlockRequestEvent(event).getEpisodeId();
         this._tmpLevelId = LevelUnlockRequestEvent(event).getLevelId();
         this._clip.header_txt.text = I18n.getString("popup_notification_central_unlock_request_header",_loc_4);
         this._clip.header_txt.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         this._clip.header_txt.embedFonts = false;
         this._clip.body_txt.text = I18n.getString("popup_notification_central_unlock_request_message",_loc_4);
         this._clip.body_txt.setTextFormat(LocalConstants.FORMAT());
         this._clip.body_txt.embedFonts = false;
         TextUtil.scaleToFit(this._clip.header_txt);
         TextUtil.scaleToFit(this._clip.body_txt);
      }
      
      public function addButton(param1:BasicButton) : void
      {
         this._buttons.push(param1);
         this._clip.addChild(param1);
      }
      
      public function destroy() : void
      {
         removeChild(this._clip);
         parent.removeChild(this);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

