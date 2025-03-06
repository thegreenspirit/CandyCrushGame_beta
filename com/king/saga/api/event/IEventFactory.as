package com.king.saga.api.event
{
   public interface IEventFactory
   {
      function create(param1:Object) : SagaEvent;
   }
}

