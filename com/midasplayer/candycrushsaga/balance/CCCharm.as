package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.crafting.ItemInfo;
   import com.king.saga.api.product.ItemProduct;
   
   public class CCCharm extends CCPowerUp
   {
      private var _bought:Boolean = false;
      
      public function CCCharm(param1:String, param2:ItemProduct, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3);
         _category = BalanceConstants.CATEGORY_CHARM;
         _startAmount = 1;
         _type = param1;
         _itemProduct = param2;
         _unlocked = param3;
         _autoGenerating = false;
         this._bought = param4;
      }
      
      override public function update(param1:ItemInfo) : void
      {
         super.update(param1);
         this._bought = param1.getAmount() > 0;
      }
      
      public function isBought() : Boolean
      {
         return this._bought;
      }
      
      public function setIsBought() : void
      {
         this._bought = true;
      }
      
      public function getUnlockStars() : int
      {
         return 100;
      }
   }
}

