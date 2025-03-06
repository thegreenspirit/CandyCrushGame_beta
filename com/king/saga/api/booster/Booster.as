package com.king.saga.api.booster
{
   import com.midasplayer.util.*;
   
   public class Booster
   {
      private var _id:String;
      
      private var _count:int;
      
      private var _price:Number;
      
      public function Booster(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._id = _loc_2.getAsString("id");
         this._count = _loc_2.getAsInt("count");
         this._price = _loc_2.getAsIntNumber("price");
      }
      
      public function getId() : String
      {
         return this._id;
      }
      
      public function getCount() : int
      {
         return this._count;
      }
      
      public function getPrice() : Number
      {
         return this._price;
      }
   }
}

