package com.king.saga.api.listener
{
   import com.king.saga.api.response.PollResponse;
   
   public interface IPollListener
   {
      function onPoll(param1:PollResponse) : void;
   }
}

