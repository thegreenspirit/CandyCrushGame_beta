package com.king.saga.api.toplist
{
   import com.midasplayer.util.*;
   
   public class LevelToplist
   {
      private var _episodeId:int;
      
      private var _levelId:int;
      
      private var _toplistUsers:Vector.<ToplistUser>;
      
      public function LevelToplist(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         super();
         this._toplistUsers = new Vector.<ToplistUser>();
         _loc_2 = new TypedKeyVal(param1);
         this._episodeId = _loc_2.getAsInt("episodeId");
         this._levelId = _loc_2.getAsInt("levelId");
         var _loc_3:* = _loc_2.getAsArray("toplist");
         for each(_loc_4 in _loc_3)
         {
            this._toplistUsers.push(new ToplistUser(_loc_4));
         }
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function getToplistUsers() : Vector.<ToplistUser>
      {
         return this._toplistUsers;
      }
   }
}

