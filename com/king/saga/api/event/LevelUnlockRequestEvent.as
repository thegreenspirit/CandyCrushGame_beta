package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class LevelUnlockRequestEvent extends SagaEvent
   {
      public static const Type:String = "LEVEL_UNLOCK_REQUEST";
      
      private var _fromId:Number;
      
      private var _episodeId:int;
      
      private var _levelId:int;
      
      public function LevelUnlockRequestEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
         this._episodeId = _loc_3.getAsInt("episodeId");
         this._levelId = _loc_3.getAsInt("levelId");
      }
      
      public function getFromId() : Number
      {
         return this._fromId;
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
   }
}

