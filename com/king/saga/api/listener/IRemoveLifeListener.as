package com.king.saga.api.listener
{
   import com.king.saga.api.response.RemoveLifeResponse;
   
   public interface IRemoveLifeListener
   {
      function onRemoveLife(param1:RemoveLifeResponse) : void;
   }
}

