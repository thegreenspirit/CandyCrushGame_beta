package com.king.saga.api.listener
{
   import com.king.saga.api.response.GameStartResponse;
   
   public interface IGameStartListener
   {
      function onGameStart(param1:GameStartResponse) : void;
   }
}

