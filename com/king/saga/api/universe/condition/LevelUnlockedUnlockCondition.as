package com.king.saga.api.universe.condition
{
   import com.midasplayer.util.*;
   
   public class LevelUnlockedUnlockCondition extends UnlockCondition
   {
      public static const Type:String = "LevelUnlockedUnlockCondition";
      
      private var _episodeId:int;
      
      private var _levelId:int;
      
      public function LevelUnlockedUnlockCondition(param1:Object)
      {
         super(Type);
         var _loc_2:* = new TypedKeyVal(param1);
         this._episodeId = _loc_2.getAsInt("episodeId");
         this._levelId = _loc_2.getAsInt("levelId");
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function toString() : String
      {
         return "[LevelUnlockedUnlockCondition episodeId=" + this._episodeId + " levelId=" + this._levelId + "]";
      }
   }
}

