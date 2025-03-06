package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.product.ExtraLifeProduct;
   import com.king.saga.api.product.ItemProduct;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   
   public class CCCharmOfLife extends CCCharm
   {
      private var _extraLifeProduct:ExtraLifeProduct;
      
      private var _extraLifeAmount:int;
      
      public function CCCharmOfLife(param1:String, param2:ItemProduct, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
         _unlockEpisodeId = 2;
         _unlockLevelId = 1;
         _triggerContext = BalanceConstants.POWERUP_TRIGGER_CONTEXT_NONE;
         _gameModes = [GameConf.MODE_NAME_CLASSIC,GameConf.MODE_NAME_CLASSIC_MOVES,GameConf.MODE_NAME_BALANCE,GameConf.MODE_NAME_DROP_DOWN,GameConf.MODE_NAME_LIGHT_UP];
      }
      
      public function setExtraLifeproduct(param1:ExtraLifeProduct) : void
      {
         this._extraLifeProduct = param1;
      }
      
      override public function getProductId() : int
      {
         return this._extraLifeProduct.getId();
      }
      
      override public function getCost() : int
      {
         return this._extraLifeProduct.getCost().getAmount();
      }
      
      override public function getCurrency() : String
      {
         return this._extraLifeProduct.getCost().getCurrency();
      }
      
      public function getExtraLifeAmount() : int
      {
         return this._extraLifeProduct.getExtraLives();
      }
   }
}

