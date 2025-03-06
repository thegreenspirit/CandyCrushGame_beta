package com.king.saga.api.event
{
   import com.king.saga.api.universe.*;
   import com.midasplayer.util.*;
   
   public class ItemGoldRewardEvent extends SagaEvent
   {
      public static const Type:String = "ITEM_GOLD_REWARD";
      
      private var _amount:Number;
      
      private var _unlockedItem:StarAchievementItem;
      
      public function ItemGoldRewardEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._amount = _loc_3.getAsIntNumber("amount");
         this._unlockedItem = new StarAchievementItem(_loc_3.getAsObject("unlockedItem"));
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
      
      public function getItem() : StarAchievementItem
      {
         return this._unlockedItem;
      }
   }
}

