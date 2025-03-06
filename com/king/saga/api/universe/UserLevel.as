package com.king.saga.api.universe
{
   import com.king.platform.util.KJSON;
   import com.king.saga.api.universe.condition.FriendInviteData;
   import com.midasplayer.debug.Debug;
   import com.midasplayer.util.TypedKeyVal;
   
   public class UserLevel
   {
      private var _levelId:int;
      
      private var _episodeId:int;
      
      private var _score:int;
      
      private var _stars:int;
      
      private var _unlocked:Boolean;
      
      private var _friendInviteData:FriendInviteData;
      
      private var _unlockedByEvent:Boolean = false;
      
      public function UserLevel(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         var _loc_5:TypedKeyVal = null;
         var _loc_6:String = null;
         var _loc_7:Object = null;
         super();
         _loc_2 = new TypedKeyVal(param1);
         this._levelId = _loc_2.getAsInt("id");
         this._episodeId = _loc_2.getAsInt("episodeId");
         this._score = _loc_2.getAsIntDef("score",0);
         this._stars = _loc_2.getAsInt("stars");
         this._unlocked = _loc_2.getAsBool("unlocked");
         var _loc_3:* = _loc_2.getAsArray("unlockConditionDataList");
         for each(_loc_4 in _loc_3)
         {
            _loc_5 = new TypedKeyVal(_loc_4);
            _loc_6 = _loc_5.getAsString("type");
            _loc_7 = KJSON.parse(_loc_5.getAsString("data"));
            if(_loc_6 == FriendInviteData.Type)
            {
               Debug.assert(this._friendInviteData == null,"Got 2 different FriendInviteData for same user level.");
               this._friendInviteData = new FriendInviteData(_loc_7);
            }
         }
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getScore() : int
      {
         return this._score;
      }
      
      public function getStars() : int
      {
         return this._stars;
      }
      
      public function getUnlocked() : Boolean
      {
         return this._unlocked;
      }
      
      public function getFriendInviteData() : FriendInviteData
      {
         return this._friendInviteData;
      }
      
      public function getUnlockedByEvent() : Boolean
      {
         return this._unlockedByEvent;
      }
      
      public function setScore(param1:int) : void
      {
         this._score = param1;
      }
      
      public function setStars(param1:int) : void
      {
         this._stars = param1;
      }
      
      public function setUnlockedByEvent(param1:Boolean) : void
      {
         this._unlockedByEvent = true;
         this._unlocked = param1;
      }
      
      public function setFriendInviteData(param1:FriendInviteData) : void
      {
         this._friendInviteData = param1;
      }
   }
}

