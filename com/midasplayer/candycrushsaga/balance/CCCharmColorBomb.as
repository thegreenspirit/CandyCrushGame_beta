package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.product.ItemProduct;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   
   public class CCCharmColorBomb extends CCCharm
   {
      public function CCCharmColorBomb(param1:String, param2:ItemProduct, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
         _unlockEpisodeId = 0;
         _unlockLevelId = 0;
         _cap = 1;
         _triggerContext = BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME;
         _gameModes = [GameConf.MODE_NAME_CLASSIC,GameConf.MODE_NAME_CLASSIC_MOVES,GameConf.MODE_NAME_BALANCE,GameConf.MODE_NAME_DROP_DOWN,GameConf.MODE_NAME_LIGHT_UP];
      }
   }
}

