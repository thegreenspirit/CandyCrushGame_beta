package com.king.saga.api.listener
{
   import com.king.saga.api.response.GetBalanceResponse;
   
   public interface IGetBalanceListener
   {
      function onGetBalance(param1:GetBalanceResponse) : void;
   }
}

