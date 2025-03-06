package com.king.saga.api.product
{
   import com.midasplayer.util.TypedKeyVal;
   
   public class ItemProduct extends SagaProduct
   {
      private var _type:String;
      
      public function ItemProduct(param1:Object)
      {
         var _loc_2:* = new TypedKeyVal(param1);
         super(_loc_2);
         this._type = _loc_2.getAsString("type");
      }
      
      public function getType() : String
      {
         return this._type;
      }
   }
}

