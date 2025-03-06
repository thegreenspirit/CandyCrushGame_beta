package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.product.ItemProduct;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.GameConf;
   
   public class CCBoosterHammer extends CCBooster
   {
      public function CCBoosterHammer(param1:String, param2:ItemProduct, param3:Boolean = false)
      {
         super(param1,param2,param3);
         _unlockEpisodeId = 1;
         _unlockLevelId = 7;
         _startAmount = 3;
         _craftable = false;
         _autoGenerating = false;
         _triggerContext = BalanceConstants.POWERUP_TRIGGER_CONTEXT_INGAME;
         _gameModes = [GameConf.MODE_NAME_CLASSIC,GameConf.MODE_NAME_CLASSIC_MOVES,GameConf.MODE_NAME_BALANCE,GameConf.MODE_NAME_DROP_DOWN,GameConf.MODE_NAME_LIGHT_UP];
      }
   }
}

