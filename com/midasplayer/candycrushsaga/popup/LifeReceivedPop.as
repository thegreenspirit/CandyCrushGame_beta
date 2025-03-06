package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class LifeReceivedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      private var _sendLifeFunc:Function;
      
      private var _friendUserId:int;
      
      private var _lifeAlreadySent:Boolean = false;
      
      public function LifeReceivedPop(param1:Function, param2:Function, param3:GiftReceivedVO, param4:Function)
      {
         var _loc_5:* = undefined;
         var _loc_9:String = null;
         super(param1,new LifeReceivedContent());
         popId = "LifeReceivedPop";
         this._sendLifeFunc = param2;
         if(Boolean(param3))
         {
            this._friendUserId = param3.friendUserId;
            _loc_5 = param3.friendName;
         }
         var _loc_6:* = param4(this._friendUserId);
         var _loc_7:* = LocalStorage.getCookie(CookieObjectVO.GIVE_LIFE,this._friendUserId);
         if(LocalStorage.getCookie(CookieObjectVO.GIVE_LIFE,this._friendUserId) != null)
         {
            if(_loc_7.expired == true)
            {
               Console.println(" : Life-cookie is expired.");
            }
            else
            {
               this._lifeAlreadySent = true;
               Console.println(" : There\'s life-cookies.");
            }
         }
         else
         {
            Console.println(" : No life-cookies. Set cookie.");
         }
         _popGfx.iGiftContainer.iPicContainer.addChild(_loc_6);
         _popGfx.tTitle.text = I18n.getString("popup_life_received_title");
         _popGfx.tTitle.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
         _popGfx.tTitle.embedFonts = false;
         var _loc_8:* = I18n.getString("popup_life_received_message",_loc_5);
         if(!this._lifeAlreadySent)
         {
            _loc_8 += " " + I18n.getString("popup_life_received_accept_send_message");
         }
         _popGfx.tMessage.text = _loc_8;
         _popGfx.tMessage.setTextFormat(LocalConstants.FORMAT());
         _popGfx.tMessage.embedFonts = false;
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         if(this._lifeAlreadySent == false)
         {
            _loc_9 = I18n.getString("popup_life_received_button_accept_send");
         }
         else
         {
            _loc_9 = I18n.getString("popup_life_received_button_continue");
         }
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,_loc_9,this.continueButtonDown);
      }
      
      private function continueButtonDown() : void
      {
         if(this._sendLifeFunc != null && !this._lifeAlreadySent)
         {
            Console.println(" : Life is sent back to friend.");
            LocalStorage.setCookie(CookieObjectVO.GIVE_LIFE,this._friendUserId,CookieObjectVO.LIFE_GIFT_TTL,this.cookieHasBeenSet);
            this._sendLifeFunc(this._friendUserId);
         }
         else
         {
            Console.println(" : Friend do already recieved life. No life will be sent back.");
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function cookieHasBeenSet(param1:Boolean) : void
      {
         if(param1)
         {
            Console.println("Cookie has been set.");
         }
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
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

