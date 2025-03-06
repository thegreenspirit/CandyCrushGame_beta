package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.product.ItemProduct;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   
   public class CCBoosterSwedishFish extends CCBooster
   {
      public function CCBoosterSwedishFish(param1:String, param2:ItemProduct, param3:Boolean = false)
      {
         super(param1,param2,param3);
         _unlockEpisodeId = 1;
         _unlockLevelId = 9;
         _triggerContext = BalanceConstants.POWERUP_TRIGGER_CONTEXT_PREGAME;
         _gameModes = [GameConf.MODE_NAME_LIGHT_UP];
      }
   }
}

