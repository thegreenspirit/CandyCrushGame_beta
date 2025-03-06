package com.king.saga.api.crafting
{
   import com.midasplayer.util.*;
   
   public class ItemAmount
   {
      private var _type:String;
      
      private var _amount:Number;
      
      public function ItemAmount(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._type = _loc_2.getAsString("type");
         this._amount = _loc_2.getAsIntNumber("amount");
      }
      
      public function getType() : String
      {
         return this._type;
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
      
      public function toObject() : Object
      {
         var _loc_1:* = new Object();
         _loc_1.type = this._type;
         _loc_1.amount = this._amount;
         return _loc_1;
      }
   }
}

