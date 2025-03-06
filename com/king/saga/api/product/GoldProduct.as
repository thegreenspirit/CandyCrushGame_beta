package com.king.saga.api.product
{
   import com.midasplayer.util.*;
   
   public class GoldProduct extends SagaProduct
   {
      private var _gold:int;
      
      public function GoldProduct(param1:Object)
      {
         var _loc_2:* = new TypedKeyVal(param1);
         super(_loc_2);
         this._gold = _loc_2.getAsInt("gold");
      }
      
      public function getGold() : int
      {
         return this._gold;
      }
   }
}

