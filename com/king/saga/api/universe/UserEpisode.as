package com.king.saga.api.universe
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class UserEpisode
   {
      private var _userLevels:Vector.<UserLevel>;
      
      private var _episodeId:int;
      
      public function UserEpisode(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         super();
         this._userLevels = new Vector.<UserLevel>();
         _loc_2 = new TypedKeyVal(param1);
         this._episodeId = _loc_2.getAsInt("id");
         var _loc_3:* = _loc_2.getAsArray("levels");
         for each(_loc_4 in _loc_3)
         {
            this._userLevels.push(new UserLevel(_loc_4));
         }
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getUserLevels() : Vector.<UserLevel>
      {
         return this._userLevels;
      }
      
      public function hasUserLevel(param1:int) : Boolean
      {
         return this._getUserLevel(param1) != null;
      }
      
      public function getUserLevel(param1:int) : UserLevel
      {
         var _loc_2:* = this._getUserLevel(param1);
         Debug.assert(_loc_2 != null,"Could not find user level with episodeId: " + this._episodeId + " levelId: " + param1);
         return _loc_2;
      }
      
      public function addUserLevel(param1:int) : void
      {
         var _loc_2:* = new Object();
         _loc_2.id = param1;
         _loc_2.episodeId = this._episodeId;
         _loc_2.score = 0;
         _loc_2.stars = 0;
         _loc_2.unlocked = false;
         _loc_2.unlockConditionDataList = new Array();
         Debug.assert(this._getUserLevel(param1) == null,"User level already exists, episodeId: " + this._episodeId + " levelId: " + param1);
         this._userLevels.push(new UserLevel(_loc_2));
      }
      
      public function countTotalStars() : int
      {
         var _loc_2:UserLevel = null;
         var _loc_1:int = 0;
         for each(_loc_2 in this._userLevels)
         {
            _loc_1 += _loc_2.getStars();
         }
         return _loc_1;
      }
      
      private function _getUserLevel(param1:int) : UserLevel
      {
         var _loc_2:UserLevel = null;
         for each(_loc_2 in this._userLevels)
         {
            if(_loc_2.getLevelId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

