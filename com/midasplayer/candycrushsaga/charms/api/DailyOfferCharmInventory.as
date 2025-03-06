package com.midasplayer.candycrushsaga.charms.api
{
   import com.king.saga.api.product.*;
   import com.midasplayer.candycrushsaga.charms.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.util.*;
   
   public class DailyOfferCharmInventory extends CharmInventory
   {
      private var _totalCost:Money;
      
      private var _productCategory:int;
      
      private var _productId:int;
      
      public function DailyOfferCharmInventory(param1:Object, param2:CCModel)
      {
         super(param2);
         var _loc_3:* = new TypedKeyVal(param1);
         if(Boolean(_loc_3.has("totalCost")))
         {
            this._totalCost = new Money(_loc_3.getAsObject("totalCost"));
         }
         else
         {
            this._totalCost = Money.create(0,"EMPTY");
         }
         this._productCategory = _loc_3.getAsInt("productCategory");
         this._productId = _loc_3.getAsInt("productId");
      }
      
      public static function createEmpty(param1:CCModel) : DailyOfferCharmInventory
      {
         var _loc_2:* = new Object();
         _loc_2.totalCost = {
            "cents":0,
            "currency":"DBG"
         };
         _loc_2.productCategory = 0;
         _loc_2.productId = 0;
         _loc_2.charms = [];
         _loc_2.minutesRemaining = 0;
         return new DailyOfferCharmInventory(_loc_2,param1);
      }
      
      public function getTotalCost() : Money
      {
         return this._totalCost;
      }
      
      public function getTotalCostStr() : String
      {
         return this._totalCost.toString();
      }
      
      public function getProductCategory() : int
      {
         return this._productCategory;
      }
      
      public function getProductId() : int
      {
         return this._productId;
      }
   }
}

import com.midasplayer.candycrushsaga.charms.CharmInventory;

