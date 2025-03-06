package com.king.saga.api.universe
{
   import com.midasplayer.util.*;
   
   public class StarAchievementItemLock
   {
      private var _unlockStars:int;
      
      private var _unlockEpisodeId:int;
      
      private var _starScope:String;
      
      private var _item:StarAchievementItem;
      
      public function StarAchievementItemLock(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._unlockStars = _loc_2.getAsInt("unlockStars");
         this._unlockEpisodeId = _loc_2.getAsInt("unlockEpisodeId");
         this._starScope = _loc_2.getAsString("starScope");
         this._item = new StarAchievementItem(_loc_2.getAsObject("item"));
      }
      
      public function getUnlockStars() : int
      {
         return this._unlockStars;
      }
      
      public function getUnlockEpisodeId() : int
      {
         return this._unlockEpisodeId;
      }
      
      public function getStarScope() : String
      {
         return this._starScope;
      }
      
      public function getItem() : StarAchievementItem
      {
         return this._item;
      }
   }
}

