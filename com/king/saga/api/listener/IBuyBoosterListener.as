package com.king.saga.api.listener
{
   import com.king.saga.api.response.BuyBoosterResponse;
   
   public interface IBuyBoosterListener
   {
      function onBuyBooster(param1:BuyBoosterResponse) : void;
   }
}

