package com.king.saga.api.user
{
   import com.midasplayer.util.*;
   
   public class UserProfile
   {
      private var _userId:Number;
      
      private var _externalUserId:String;
      
      private var _lastOnlineTime:Number;
      
      private var _fullName:String;
      
      private var _name:String;
      
      private var _picUrl:String;
      
      private var _picSquareUrl:String;
      
      private var _picSmallUrl:String;
      
      private var _countryCode:String;
      
      private var _topEpisode:int;
      
      private var _topLevel:int;
      
      private var _totalStars:int;
      
      private var _invite:String;
      
      private var _masteraward:String;
      
      public function UserProfile(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._userId = _loc_2.getAsIntNumber("userId");
         this._externalUserId = _loc_2.getAsString("externalUserId");
         this._lastOnlineTime = _loc_2.getAsNumber("lastOnlineTime");
         this._fullName = _loc_2.getAsString("fullName");
         this._name = _loc_2.getAsString("name");
         this._picUrl = _loc_2.getAsString("pic");
         this._picSquareUrl = _loc_2.getAsString("picSquare");
         this._picSmallUrl = _loc_2.getAsString("picSmall");
         this._countryCode = _loc_2.getAsString("countryCode","unknown_country");
         this._topEpisode = _loc_2.getAsInt("topEpisode");
         this._topLevel = _loc_2.getAsInt("topLevel");
         this._totalStars = _loc_2.getAsInt("totalStars");
         this._invite = _loc_2.getAsString("invite");
         this._masteraward = _loc_2.getAsString("masteraward");
      }
      
      public function getMasteraward() : String
      {
         return this._masteraward;
      }
      
      public function getInvite() : String
      {
         return this._invite;
      }
      
      public function getUserId() : Number
      {
         return this._userId;
      }
      
      public function getExternalUserId() : String
      {
         return this._externalUserId;
      }
      
      public function getLastOnlineTime() : Number
      {
         return this._lastOnlineTime;
      }
      
      public function getFullName() : String
      {
         return this._fullName;
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getPicUrl() : String
      {
         return this._picUrl;
      }
      
      public function getPicSquareUrl() : String
      {
         return this._picSquareUrl;
      }
      
      public function getPicSmallUrl() : String
      {
         return this._picSmallUrl;
      }
      
      public function getCountryCode() : String
      {
         return this._countryCode;
      }
      
      public function getTopEpisode() : int
      {
         return this._topEpisode;
      }
      
      public function getTopLevel() : int
      {
         return this._topLevel;
      }
      
      public function getTotalStars() : int
      {
         return this._totalStars;
      }
      
      public function setTopEpisode(param1:int) : void
      {
         this._topEpisode = param1;
      }
      
      public function setTopLevel(param1:int) : void
      {
         this._topLevel = param1;
      }
      
      public function setTotalStars(param1:int) : void
      {
         this._totalStars = param1;
      }
      
      public function toString() : String
      {
         return "[UserProfile id=" + this._userId + "]";
      }
   }
}

