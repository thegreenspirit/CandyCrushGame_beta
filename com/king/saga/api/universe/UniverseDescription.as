package com.king.saga.api.universe
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class UniverseDescription
   {
      private var _episodeDescriptions:Vector.<EpisodeDescription>;
      
      private var _starAchievementItemLocks:Vector.<StarAchievementItemLock>;
      
      public function UniverseDescription(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         var _loc_5:Array = null;
         var _loc_6:Object = null;
         super();
         this._episodeDescriptions = new Vector.<EpisodeDescription>();
         this._starAchievementItemLocks = new Vector.<StarAchievementItemLock>();
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.getAsArray("episodeDescriptions");
         for each(_loc_4 in _loc_3)
         {
            this._episodeDescriptions.push(new EpisodeDescription(_loc_4));
         }
         _loc_5 = _loc_2.getAsArray("starAchievementItemLocks");
         for each(_loc_6 in _loc_5)
         {
            this._starAchievementItemLocks.push(new StarAchievementItemLock(_loc_6));
         }
      }
      
      public function getEpisodeDescriptions() : Vector.<EpisodeDescription>
      {
         return this._episodeDescriptions;
      }
      
      public function getEpisodeDescription(param1:int) : EpisodeDescription
      {
         var _loc_2:* = this._getEpisodeDescription(param1);
         Debug.assert(_loc_2 != null,"Could not find episode with id: " + param1);
         return _loc_2;
      }
      
      public function getLevelDescription(param1:int, param2:int) : LevelDescription
      {
         return this.getEpisodeDescription(param1).getLevelDescription(param2);
      }
      
      public function hasEpisodeDescription(param1:int) : Boolean
      {
         return this._getEpisodeDescription(param1) != null;
      }
      
      public function getStarAchievementItemLocks() : Vector.<StarAchievementItemLock>
      {
         return this._starAchievementItemLocks;
      }
      
      private function _getEpisodeDescription(param1:int) : EpisodeDescription
      {
         var _loc_2:EpisodeDescription = null;
         for each(_loc_2 in this._episodeDescriptions)
         {
            if(_loc_2.getEpisodeId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

