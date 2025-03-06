package com.midasplayer.candycrushsaga.engine
{
   import com.adobe.serialization.json.JSON;
   import flash.events.*;
   import flash.net.*;
   
   public class CCMissionsModel extends EventDispatcher
   {
      private static const GET_AVAILABLE_MISSIONS:String = "getAvailableMissions";
      private static const GET_ACCOMPLISHED_MISSIONS:String = "getAccomplishedMissions";
      private static const START_MISSION:String = "activateUserMission";
      
      public static const ACCOMPLISHED_MISSIONS_UPDATED:String = "accomplishedMissionsUpdated";
      public static const AVAILABLE_MISSIONS_UPDATED:String = "availableMissionsUpdated";
      
      public static const BLING_FOLDER:String = "/rpc/bling/";
      
      private var sessionKey:String;
      private var missionsUrl:String;
      
      public var hasAccomplishedMissionsReply:Boolean = false;
      public var hasAvailableMissionsReply:Boolean = false;
      
      private var _missionLoader:URLLoader;
      
      public var availableMissionsDataList:Vector.<CCMissionData>;
      public var accomplishedMissionsDataList:Vector.<CCMissionData>;
      
      public function CCMissionsModel(param1:String, param2:String)
      {
         super();
         this.missionsUrl = param2 + BLING_FOLDER;
         this.sessionKey = param1;
         this.loadAccomplishedMissions();
      }
      
      public function acceptMission(param1:CCMissionData) : void
      {
         var _loc_2:* = param1.missionId;
         var _loc_3:* = this.missionsUrl + START_MISSION;
         var _loc_4:* = new URLVariables();
         _loc_4._session = this.sessionKey;
         _loc_4.arg0 = _loc_2;
         var _loc_5:* = new URLRequest(_loc_3);
         _loc_5.method = URLRequestMethod.GET;
         _loc_5.data = _loc_4;
         this._missionLoader = new URLLoader();
         this._missionLoader.addEventListener(Event.COMPLETE,this.onAcceptMissionReply);
         this._missionLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAcceptMissionError);
         this._missionLoader.load(_loc_5);
      }
      
      public function getAnyAvailableMission() : CCMissionData
      {
         if(this.availableMissionsDataList == null || this.availableMissionsDataList.length == 0)
         {
            return null;
         }
         return this.availableMissionsDataList[0];
      }
      
      private function onAcceptMissionReply(event:Event) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAcceptMissionReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAcceptMissionError);
         this._missionLoader = null;
      }
      
      private function onAcceptMissionError(event:IOErrorEvent) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAcceptMissionReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAcceptMissionError);
         this._missionLoader = null;
      }
      
      private function loadAccomplishedMissions() : void
      {
         var _loc_1:* = this.missionsUrl + GET_ACCOMPLISHED_MISSIONS;
         var _loc_2:* = new URLVariables();
         _loc_2._session = this.sessionKey;
         var _loc_3:* = new URLRequest(_loc_1);
         _loc_3.method = URLRequestMethod.GET;
         _loc_3.data = _loc_2;
         this._missionLoader = new URLLoader();
         this._missionLoader.addEventListener(Event.COMPLETE,this.onAccomplishedMissionsReply);
         this._missionLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAccomplishedLoaderError);
         this._missionLoader.load(_loc_3);
      }
      
      private function onAccomplishedMissionsReply(event:Event) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAccomplishedMissionsReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAccomplishedLoaderError);
         this.setNewAccomplishedData(event.target.data as String);
         this._missionLoader = null;
         this.hasAccomplishedMissionsReply = true;
         dispatchEvent(new Event(CCMissionsModel.ACCOMPLISHED_MISSIONS_UPDATED));
         this.loadAvailableMissions();
      }
      
      private function onAccomplishedLoaderError(event:IOErrorEvent) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAccomplishedMissionsReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAccomplishedLoaderError);
         this._missionLoader = null;
      }
      
      private function setNewAccomplishedData(param1:String) : void
      {
         var _loc_4:Object = null;
         var _loc_5:CCMissionData = null;
         if(!param1 || param1 == "")
         {
            param1 = "[]";
         }
         var _loc_2:* = com.adobe.serialization.json.JSON.decode(param1);
         var _loc_3:* = _loc_2 as Array;
         this.accomplishedMissionsDataList = new Vector.<CCMissionData>();
         if(_loc_3 != null && _loc_3.length > 0)
         {
            for each(_loc_4 in _loc_3)
            {
               _loc_5 = new CCMissionData(_loc_4);
               this.accomplishedMissionsDataList.push(_loc_5);
            }
         }
      }
      
      private function loadAvailableMissions() : void
      {
         var _loc_1:* = this.missionsUrl + GET_AVAILABLE_MISSIONS;
         var _loc_2:* = new URLVariables();
         _loc_2._session = this.sessionKey;
         var _loc_3:* = new URLRequest(_loc_1);
         _loc_3.method = URLRequestMethod.GET;
         _loc_3.data = _loc_2;
         this._missionLoader = new URLLoader();
         this._missionLoader.addEventListener(Event.COMPLETE,this.onAvailableMissionsReply);
         this._missionLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAvailabilityLoaderError);
         this._missionLoader.load(_loc_3);
      }
      
      private function onAvailableMissionsReply(event:Event) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAvailableMissionsReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAvailabilityLoaderError);
         this.setNewAvailabilityData(event.target.data as String);
         this._missionLoader = null;
         this.hasAvailableMissionsReply = true;
         dispatchEvent(new Event(CCMissionsModel.AVAILABLE_MISSIONS_UPDATED));
      }
      
      private function onAvailabilityLoaderError(event:IOErrorEvent) : void
      {
         this._missionLoader.removeEventListener(Event.COMPLETE,this.onAvailableMissionsReply);
         this._missionLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onAvailabilityLoaderError);
         this._missionLoader = null;
      }
      
      private function setNewAvailabilityData(param1:String) : void
      {
         var _loc_4:Object = null;
         var _loc_5:CCMissionData = null;
         if(!param1 || param1 == "")
         {
            param1 = "[]";
         }
         var _loc_2:* = com.adobe.serialization.json.JSON.decode(param1);
         var _loc_3:* = _loc_2 as Array;
         this.availableMissionsDataList = new Vector.<CCMissionData>();
         if(_loc_3 != null && _loc_3.length > 0)
         {
            for each(_loc_4 in _loc_3)
            {
               _loc_5 = new CCMissionData(_loc_4);
               this.availableMissionsDataList.push(_loc_5);
            }
         }
      }
   }
}

import flash.events.EventDispatcher;
