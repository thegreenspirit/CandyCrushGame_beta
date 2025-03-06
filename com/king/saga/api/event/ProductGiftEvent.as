package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class ProductGiftEvent extends SagaEvent
   {
      public static const Type:String = "PRODUCT_GIFT";
      
      private var _fromId:Number;
      
      private var _categoryId:int;
      
      private var _productId:int;
      
      public function ProductGiftEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
         this._categoryId = _loc_3.getAsInt("categoryId");
         this._productId = _loc_3.getAsInt("productId");
      }
      
      public function getFromId() : Number
      {
         return this._fromId;
      }
      
      public function getCategoryId() : int
      {
         return this._categoryId;
      }
      
      public function getProductId() : int
      {
         return this._productId;
      }
   }
}

