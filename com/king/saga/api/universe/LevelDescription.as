package com.king.saga.api.universe
{
   import com.king.platform.util.*;
   import com.king.saga.api.universe.condition.*;
   import com.midasplayer.util.*;
   
   public class LevelDescription
   {
      private var _levelId:int;
      
      private var _episodeId:int;
      
      private var _starProgressions:Vector.<StarProgression>;
      
      private var _unlockConditions:Vector.<UnlockCondition>;
      
      public function LevelDescription(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         var _loc_5:Array = null;
         var _loc_6:Object = null;
         var _loc_7:TypedKeyVal = null;
         var _loc_8:String = null;
         var _loc_9:Object = null;
         super();
         this._starProgressions = new Vector.<StarProgression>();
         this._unlockConditions = new Vector.<UnlockCondition>();
         _loc_2 = new TypedKeyVal(param1);
         this._levelId = _loc_2.getAsInt("levelId");
         this._episodeId = _loc_2.getAsInt("episodeId");
         var _loc_3:* = _loc_2.getAsArray("starProgressions");
         for each(_loc_4 in _loc_3)
         {
            this._starProgressions.push(new StarProgression(_loc_4));
         }
         _loc_5 = _loc_2.getAsArray("unlockConditions");
         for each(_loc_6 in _loc_5)
         {
            _loc_7 = new TypedKeyVal(_loc_6);
            _loc_8 = _loc_7.getAsString("type");
            _loc_9 = KJSON.parse(_loc_7.getAsString("data"));
            if(_loc_8 == FriendInviteUnlockCondition.Type)
            {
               this._unlockConditions.push(new FriendInviteUnlockCondition(_loc_9));
            }
            else if(_loc_8 == LevelCompletedUnlockCondition.Type)
            {
               this._unlockConditions.push(new LevelCompletedUnlockCondition(_loc_9));
            }
            else if(_loc_8 == LevelUnlockedUnlockCondition.Type)
            {
               this._unlockConditions.push(new LevelUnlockedUnlockCondition(_loc_9));
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
      
      public function getStarProgressions() : Vector.<StarProgression>
      {
         return this._starProgressions;
      }
      
      public function getUnlockConditions() : Vector.<UnlockCondition>
      {
         return this._unlockConditions;
      }
      
      public function getRequiredFriendInvites() : int
      {
         var _loc_1:UnlockCondition = null;
         for each(_loc_1 in this._unlockConditions)
         {
            if(_loc_1 is FriendInviteUnlockCondition)
            {
               return FriendInviteUnlockCondition(_loc_1).getNumOfFriendsRequired();
            }
         }
         return 0;
      }
   }
}

