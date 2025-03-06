package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class EpisodeCompletedEvent extends SagaEvent
   {
      public static const Type:String = "EPISODE_COMPLETED";
      
      private var _episodeId:int;
      
      public function EpisodeCompletedEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._episodeId = _loc_3.getAsInt("episodeId");
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
   }
}

