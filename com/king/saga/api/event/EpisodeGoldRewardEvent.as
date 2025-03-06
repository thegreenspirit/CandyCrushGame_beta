package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class EpisodeGoldRewardEvent extends SagaEvent
   {
      public static const Type:String = "EPISODE_GOLD_REWARD";
      
      private var _episodeId:int;
      
      private var _amount:Number;
      
      public function EpisodeGoldRewardEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._episodeId = _loc_3.getAsInt("episodeId");
         this._amount = _loc_3.getAsIntNumber("amount");
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
   }
}

