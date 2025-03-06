package com.king.saga.api.listener
{
   import com.king.saga.api.response.CraftResponse;
   
   public interface ICraftListener
   {
      function onCraft(param1:CraftResponse) : void;
   }
}

