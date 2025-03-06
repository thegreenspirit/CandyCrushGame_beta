package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.product.ItemProduct;
   
   public class CCBooster extends CCPowerUp
   {
      public function CCBooster(param1:String, param2:ItemProduct, param3:Boolean = false)
      {
         super(param1,param2,param3);
         _category = BalanceConstants.CATEGORY_BOOSTER;
         _type = param1;
         _itemProduct = param2;
         _unlocked = param3;
         _isPopActivated = false;
         _craftable = true;
         _autoGenerating = false;
      }
   }
}

