package com.midasplayer.candycrushsaga.popup
{
   import com.demonsters.debugger.*;
   import com.king.saga.api.product.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   
   public class CollaborationPanelPop extends Popup
   {
      private static var SUGGESTED_FRIENDS:int = 6;
      
      private var _payButton:ButtonBuy;
      
      private var _friendButton:ButtonRegular;
      
      private var getPicFn:Function;
      
      private var stationString:String;
      
      private var product:CollaborationProduct;
      
      private var onAskForCollaborationHelp:Function;
      
      private var onBuyCollaboration:Function;
      
      public function CollaborationPanelPop(param1:int, param2:int, param3:Vector.<Number>, param4:Function, param5:Function, param6:Function, param7:String, param8:CollaborationProduct)
      {
         popId = "CollaborationPanelPop";
         this.onAskForCollaborationHelp = param5;
         this.onBuyCollaboration = param6;
         super(null,new CollaborationPanelContent());
         this.getPicFn = param4;
         this.stationString = param7;
         this.product = param8;
         this.setPictures(param3);
         _popGfx.tTitle.text = I18n.getString("popup_collaboration_panel_title");
         _popGfx.tMessage.text = I18n.getString("popup_collaboration_panel_message",String(param8.getCost()),SUGGESTED_FRIENDS);
         this._payButton = new ButtonBuy(_popGfx.iButtonPay,I18n.getString("popup_collaboration_panel_button_buy"),String(param8.getCost()),this.payButtonDown);
         this._payButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this._friendButton = new ButtonRegular(_popGfx.iButtonFriends,I18n.getString("popup_collaboration_panel_button_friends",SUGGESTED_FRIENDS),this.friendButtonDown);
         this._friendButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         this.setEpisodeGfx(param1);
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
      }
      
      private function setEpisodeGfx(param1:int) : void
      {
         _popGfx.iEpisodeGfx.gotoAndStop(param1);
      }
      
      private function setPictures(param1:Vector.<Number>) : void
      {
         var _loc_2:MovieClip = null;
         if(Boolean(param1))
         {
            if(param1.length > 0 && !isNaN(param1[0]))
            {
               _loc_2 = this.getPicFn(param1[0]);
               _popGfx.iFriendHelpContainer1.iPicContainer.addChild(_loc_2);
            }
            if(param1.length > 1 && !isNaN(param1[1]))
            {
               _loc_2 = this.getPicFn(param1[1]);
               _popGfx.iFriendHelpContainer2.iPicContainer.addChild(_loc_2);
            }
            if(param1.length > 2 && !isNaN(param1[2]))
            {
               _loc_2 = this.getPicFn(param1[2]);
               _popGfx.iFriendHelpContainer3.iPicContainer.addChild(_loc_2);
            }
         }
         this.setupPictureListeners();
      }
      
      private function setupPictureListeners() : void
      {
         _popGfx.iFriendHelpContainer1.buttonMode = true;
         _popGfx.iFriendHelpContainer1.addEventListener(MouseEvent.CLICK,this.friendButtonDown);
         _popGfx.iFriendHelpContainer2.buttonMode = true;
         _popGfx.iFriendHelpContainer2.addEventListener(MouseEvent.CLICK,this.friendButtonDown);
         _popGfx.iFriendHelpContainer3.buttonMode = true;
         _popGfx.iFriendHelpContainer3.addEventListener(MouseEvent.CLICK,this.friendButtonDown);
      }
      
      private function friendButtonDown(event:Event = null) : void
      {
         MonsterDebugger.trace(this,"friendButtonDown");
         this.onAskForCollaborationHelp(this.stationString);
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function payButtonDown() : void
      {
         MonsterDebugger.trace(this,"payButtonDown");
         this.onBuyCollaboration(this.product.getId(),this.stationString);
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         _popGfx.iFriendHelpContainer1.removeEventListener(MouseEvent.CLICK,this.friendButtonDown);
         _popGfx.iFriendHelpContainer2.removeEventListener(MouseEvent.CLICK,this.friendButtonDown);
         _popGfx.iFriendHelpContainer3.removeEventListener(MouseEvent.CLICK,this.friendButtonDown);
         super.destruct();
         this._payButton.destruct();
         this._payButton = null;
         this._friendButton.destruct();
         this._friendButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

