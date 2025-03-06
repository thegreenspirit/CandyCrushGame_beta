package com.king.saga.api.universe
{
   import com.midasplayer.util.*;
   
   public class StarAchievementItem
   {
      private var _itemType:String;
      
      private var _itemId:String;
      
      public function StarAchievementItem(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._itemType = _loc_2.getAsString("itemType");
         this._itemId = _loc_2.getAsString("itemId");
      }
      
      public function getItemType() : String
      {
         return this._itemType;
      }
      
      public function getItemId() : String
      {
         return this._itemId;
      }
   }
}

