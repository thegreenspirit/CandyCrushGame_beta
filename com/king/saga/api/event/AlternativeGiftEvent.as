package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class AlternativeGiftEvent extends SagaEvent
   {
      public static const Type:String = "ALTERNATIVE_GIFT";
      
      private var _fromId:Number;
      
      private var _itemType:String;
      
      private var _oldType:String;
      
      private var _amount:int;
      
      public function AlternativeGiftEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
         this._itemType = _loc_3.getAsString("itemType");
         this._oldType = _loc_3.getAsString("oldType");
         this._amount = _loc_3.getAsInt("amount");
      }
      
      public function getFromId() : Number
      {
         return this._fromId;
      }
      
      public function getItemType() : String
      {
         return this._itemType;
      }
      
      public function getOldType() : String
      {
         return this._oldType;
      }
      
      public function getAmount() : int
      {
         return this._amount;
      }
   }
}

