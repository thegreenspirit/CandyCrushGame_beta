package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class MapFriendPassedGoldEvent extends SagaEvent
   {
      public static const Type:String = "MAP_FRIEND_PASSED_GOLD_REWARD";
      
      private var _amount:Number;
      
      public function MapFriendPassedGoldEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._amount = _loc_3.getAsIntNumber("amount");
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
   }
}

