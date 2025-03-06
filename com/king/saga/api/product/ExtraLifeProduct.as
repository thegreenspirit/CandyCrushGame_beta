package com.king.saga.api.product
{
   import com.midasplayer.util.*;
   
   public class ExtraLifeProduct extends SagaProduct
   {
      private var _extraLives:int;
      
      private var _immortality:Boolean;
      
      public function ExtraLifeProduct(param1:Object)
      {
         var _loc_2:* = new TypedKeyVal(param1);
         super(_loc_2);
         this._extraLives = _loc_2.getAsInt("extraLives");
         this._immortality = _loc_2.getAsBool("immortality");
      }
      
      public function getExtraLives() : int
      {
         return this._extraLives;
      }
      
      public function isImmortality() : Boolean
      {
         return this._immortality;
      }
   }
}

