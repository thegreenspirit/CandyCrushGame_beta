package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class ToplistFriendBeatenEvent extends SagaEvent
   {
      public static const Type:String = "TOPLIST_FRIEND_BEATEN";
      
      private var _friendUserId:Number;
      
      private var _score:Number;
      
      private var _episodeId:int;
      
      private var _levelId:int;
      
      public function ToplistFriendBeatenEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._friendUserId = _loc_3.getAsIntNumber("friendUserId");
         if(Boolean(_loc_3.has("score")))
         {
            this._score = _loc_3.getAsIntNumber("score");
         }
         if(Boolean(_loc_3.has("episodeId")))
         {
            this._episodeId = _loc_3.getAsInt("episodeId");
         }
         if(Boolean(_loc_3.has("levelId")))
         {
            this._levelId = _loc_3.getAsInt("levelId");
         }
      }
      
      public function getFriendUserId() : Number
      {
         return this._friendUserId;
      }
      
      public function getScore() : Number
      {
         return this._score;
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function hasScore() : Boolean
      {
         return this._score > 0;
      }
      
      public function hasEpisodeId() : Boolean
      {
         return this._episodeId > 0;
      }
      
      public function hasLevelId() : Boolean
      {
         return this._levelId > 0;
      }
   }
}

