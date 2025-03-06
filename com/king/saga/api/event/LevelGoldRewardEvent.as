package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class LevelGoldRewardEvent extends SagaEvent
   {
      public static const Type:String = "LEVEL_GOLD_REWARD";
      
      private var _episodeId:int;
      
      private var _levelId:int;
      
      private var _amount:Number;
      
      public function LevelGoldRewardEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._episodeId = _loc_3.getAsInt("episodeId");
         this._levelId = _loc_3.getAsInt("levelId");
         this._amount = _loc_3.getAsIntNumber("amount");
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
   }
}

