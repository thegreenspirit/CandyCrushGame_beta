package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.events.*;
   import flash.net.*;
   import popup.*;
   
   public class MissionAccomplishedPop extends Popup
   {
      private var _button:ButtonRegular;
      
      private var _missionData:CCMissionData;
      
      private var _clbPlayFunc:Function;
      
      public function MissionAccomplishedPop(param1:Function, param2:CCMissionData)
      {
         super(null,new BWSMissionPromoComplete());
         popId = "MissionAccomplishedPop";
         this._missionData = param2;
         this._clbPlayFunc = param1;
         var _loc_3:* = Number(this._missionData.reward);
         _popGfx.tTitle.text = I18n.getString("popup_mission_accomplished_header");
         _popGfx.tMessage.text = I18n.getString("popup_mission_accomplished_content",_loc_3);
         this._button = new ButtonRegular(_popGfx.iButtonContinue,I18n.getString("popup_mission_accomplished_continue_button"),this.acceptMission);
      }
      
      private function acceptMission() : void
      {
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK_WRAPPED);
         var url:* = this._missionData.url;
         var request:* = new URLRequest(url);
         try
         {
         }
         catch(e:Error)
         {
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._button.destruct();
         this._button = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

