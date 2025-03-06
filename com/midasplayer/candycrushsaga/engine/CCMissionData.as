package com.midasplayer.candycrushsaga.engine
{
   public class CCMissionData
   {
      public var id:Number;
      
      public var kingAppId:Number;
      
      public var rewardId:Number;
      
      public var missionId:Number;
      
      public var receivingKingappId:Number;
      
      public var reward:String;
      
      public var status:Number;
      
      public var shortName:String;
      
      public var clientType:String;
      
      public var url:String;
      
      public var missionImageUrl:String;
      
      public var missionPrizeImageUrl:String;
      
      public var title:String;
      
      public var description:String;
      
      public var prize:String;
      
      public var missionOrOfferOfferButton:String;
      
      public var missionCompletedDescription:String;
      
      public var next:String;
      
      public var missionOrOfferTitle:String;
      
      public var missionOrOfferMissionButton:String;
      
      public var missionCompletedTitle:String;
      
      public var easy:String;
      
      public var hard:String;
      
      public var previous:String;
      
      public var medium:String;
      
      public var missionsTitle:String;
      
      public function CCMissionData(param1:Object)
      {
         super();
         var _loc_2:* = param1.mission;
         this.id = _loc_2.id;
         this.kingAppId = _loc_2.kingAppId;
         this.shortName = _loc_2.shortName;
         this.clientType = _loc_2.clientType;
         this.url = _loc_2.url;
         this.missionImageUrl = _loc_2.missionImageUrl;
         this.missionPrizeImageUrl = _loc_2.missionPrizeImageUrl;
         var _loc_3:* = _loc_2.resources;
         if(_loc_3 != null)
         {
            this.title = _loc_3.title;
            this.description = _loc_3.description;
            this.prize = _loc_3.prize;
         }
         var _loc_4:* = param1.reward;
         if(param1.reward != null)
         {
            this.rewardId = _loc_4.id;
            this.missionId = _loc_4.missionId;
            this.reward = _loc_4.reward;
            this.receivingKingappId = _loc_4.receivingKingappId;
         }
         this.status = param1.status;
         var _loc_5:* = param1.generalResources;
         if(param1.generalResources != null)
         {
            this.missionOrOfferOfferButton = _loc_5.missionOrOfferOfferButton;
            this.missionCompletedDescription = _loc_5.missionCompletedDescription;
            this.next = _loc_5.next;
            this.missionOrOfferTitle = _loc_5.missionOrOfferTitle;
            this.missionOrOfferMissionButton = _loc_5.missionOrOfferMissionButton;
            this.missionCompletedTitle = _loc_5.missionCompletedTitle;
            this.easy = _loc_5.easy;
            this.hard = _loc_5.hard;
            this.previous = _loc_5.previous;
            this.medium = _loc_5.medium;
            this.missionsTitle = _loc_5.missionsTitle;
         }
      }
   }
}

