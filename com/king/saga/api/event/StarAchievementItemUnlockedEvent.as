package com.king.saga.api.event
{
   import com.king.saga.api.universe.StarAchievementItem;
   
   public class StarAchievementItemUnlockedEvent extends SagaEvent
   {
      public static const Type:String = "STAR_ACHIEVEMENT_ITEM_UNLOCKED";
      
      private var _item:StarAchievementItem;
      
      public function StarAchievementItemUnlockedEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         this._item = new StarAchievementItem(param2);
      }
      
      public function getItem() : StarAchievementItem
      {
         return this._item;
      }
   }
}

