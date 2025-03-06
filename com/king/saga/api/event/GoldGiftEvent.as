package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class GoldGiftEvent extends SagaEvent
   {
      public static const Type:String = "GOLD_GIFT";
      
      private var _fromId:Number;
      
      private var _gold:int;
      
      public function GoldGiftEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
         this._gold = _loc_3.getAsInt("gold");
      }
      
      public function getFromId() : Number
      {
         return this._fromId;
      }
      
      public function getGold() : int
      {
         return this._gold;
      }
   }
}

