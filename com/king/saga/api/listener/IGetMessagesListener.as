package com.king.saga.api.listener
{
   import com.king.saga.api.response.GetMessagesResponse;
   
   public interface IGetMessagesListener
   {
      function onGetMessages(param1:GetMessagesResponse) : void;
   }
}

