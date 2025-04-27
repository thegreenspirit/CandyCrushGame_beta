package com.midasplayer.candycrushsaga.popup.notificationcentral
{
   import com.king.saga.api.event.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.text.*;
   
   public class NotificationsPopup extends SagaPopupBase
   {
      public static const Type:String = "NOTIFICATIONS_POPUP";
      
      private static const _CONTENT_X:Number = 59;
      
      private static const _CONTENT_Y:Number = 107;
      
      private var _user:UserProfile;
      
      private var _slider:Slider;
      
      private var _notifications:Vector.<Notification>;
      
      private var picLoaderFn:Function;
      
      private var sendAcceptUnlockRequestTo:Function;
      
      private var sendAcceptLifeRequestTo:Function;
      
      public function NotificationsPopup(param1:Vector.<SagaEvent>, param2:UserProfiles, param3:Function, param4:Function, param5:Function)
      {
         super(new NOTIFICATIONS_POPUP());
         this.sendAcceptLifeRequestTo = param4;
         this.sendAcceptUnlockRequestTo = param5;
         this.picLoaderFn = param3;
         _clip.pop.header_txt.text = I18n.getString("popup_notification_central_header");
         _clip.pop.header_txt.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         _clip.pop.header_txt.embedFonts = false;
         _clip.pop.request_txt.text = I18n.getString("popup_notification_central_message_count",param1.length);
         _clip.pop.request_txt.setTextFormat(LocalConstants.FORMAT());
         _clip.pop.header_txt.embedFonts = false;
         TextField(_clip.pop.header_txt).mouseEnabled = false;
         TextField(_clip.pop.request_txt).mouseEnabled = false;
         this._addNotifications(param1,param2);
         this._slider = new Slider(_clip.pop.container,_clip.pop.containerMask,_clip.pop.container.x,_clip.pop.container.y,_clip.pop.sliderBg,_clip.pop.sliderKnob,_clip.pop.arrow1,_clip.pop.arrow2);
         this._slider.adjust(_clip.pop.container);
         addSkipButton(this.onCloseNotifC);
         TextUtil.scaleToFit(_clip.pop.header_txt);
         TextUtil.scaleToFit(_clip.pop.request_txt);
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      public function onCloseNotifC() : void
      {
         SoundInterface.playSound(SoundInterface.CLICK);
         close();
      }
      
      private function _addNotifications(param1:Vector.<SagaEvent>, param2:UserProfiles) : void
      {
         var _loc_3:Notification = null;
         var _loc_6:SagaEvent = null;
         var _loc_5:int = 0;
         var _loc_7:Number = NaN;
         this._notifications = new Vector.<Notification>();
         for each(_loc_6 in param1)
         {
            if(_loc_6 is LifeRequestEvent)
            {
               _loc_7 = LifeRequestEvent(_loc_6).getFromId();
               if(param2.exists(_loc_7))
               {
                  _loc_3 = new Notification(Notification.LIFE_REQUEST,_loc_6,param2,this._closeNotification,this.picLoaderFn,this.sendAcceptLifeRequestTo,this.sendAcceptUnlockRequestTo);
               }
            }
            else if(_loc_6 is LevelUnlockRequestEvent)
            {
               _loc_7 = LevelUnlockRequestEvent(_loc_6).getFromId();
               if(param2.exists(_loc_7))
               {
                  _loc_3 = new Notification(Notification.HELP_REQUEST,_loc_6,param2,this._closeNotification,this.picLoaderFn,this.sendAcceptLifeRequestTo,this.sendAcceptUnlockRequestTo);
               }
            }
            _clip.pop.container.addChild(_loc_3);
            this._notifications.push(_loc_3);
            _loc_3.y = _loc_5;
            _loc_5 += _loc_3.height + 2;
         }
      }
      
      private function _closeNotification(param1:Notification) : void
      {
         var _loc_5:Notification = null;
         var _loc_2:int = 0;
         var _loc_4:int = 0;
         if(Boolean(_clip.pop.container.contains(param1)))
         {
            _clip.pop.container.removeChild(param1);
         }
         while(_loc_2 < this._notifications.length)
         {
            if(this._notifications[_loc_2] == param1)
            {
               this._notifications.splice(_loc_2,1);
            }
            _loc_2++;
         }
         for each(_loc_5 in this._notifications)
         {
            _loc_5.y = _loc_4;
            _loc_4 += _loc_5.height + 2;
         }
         this._slider.adjust(_clip.pop.container);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

