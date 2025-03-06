package com.king.saga.api.listener
{
   import com.king.saga.api.response.GameEndResponse;
   
   public interface IGameEndListener
   {
      function onGameEnd(param1:GameEndResponse) : void;
   }
}

