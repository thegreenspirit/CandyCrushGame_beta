package com.king.saga.api.universe
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class EpisodeDescription
   {
      private var _levelDescriptions:Vector.<LevelDescription>;
      
      private var _episodeId:int;
      
      public function EpisodeDescription(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         super();
         this._levelDescriptions = new Vector.<LevelDescription>();
         _loc_2 = new TypedKeyVal(param1);
         this._episodeId = _loc_2.getAsInt("episodeId");
         var _loc_3:* = _loc_2.getAsArray("levelDescriptions");
         for each(_loc_4 in _loc_3)
         {
            this._levelDescriptions.push(new LevelDescription(_loc_4));
         }
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelDescriptions() : Vector.<LevelDescription>
      {
         return this._levelDescriptions;
      }
      
      public function getLevelDescription(param1:int) : LevelDescription
      {
         var _loc_2:LevelDescription = null;
         for each(_loc_2 in this._levelDescriptions)
         {
            if(_loc_2.getLevelId() == param1)
            {
               return _loc_2;
            }
         }
         Debug.assert(_loc_2 != null,"Could not find level with id: " + param1);
         return null;
      }
   }
}

