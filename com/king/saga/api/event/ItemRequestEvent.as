package com.king.saga.api.event
{
   import com.king.saga.api.crafting.*;
   import com.midasplayer.util.*;
   
   public class ItemRequestEvent extends SagaEvent
   {
      public static const Type:String = "ITEM_REQUEST";
      
      private var _fromId:Number;
      
      private var _itemAmount:ItemAmount;
      
      public function ItemRequestEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
         this._itemAmount = new ItemAmount({
            "type":_loc_3.getAsString("itemType"),
            "amount":_loc_3.getAsInt("itemAmount")
         });
      }
      
      public function get fromId() : Number
      {
         return this._fromId;
      }
      
      public function get itemAmount() : ItemAmount
      {
         return this._itemAmount;
      }
   }
}

