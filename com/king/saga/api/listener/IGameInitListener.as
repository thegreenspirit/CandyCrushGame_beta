package com.king.saga.api.listener
{
   import com.king.saga.api.response.GameInitResponse;
   
   public interface IGameInitListener
   {
      function onGameInit(param1:GameInitResponse) : void;
   }
}

