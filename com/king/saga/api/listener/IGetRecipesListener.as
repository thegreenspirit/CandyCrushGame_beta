package com.king.saga.api.listener
{
   import com.king.saga.api.response.GetRecipesResponse;
   
   public interface IGetRecipesListener
   {
      function onGetRecipes(param1:GetRecipesResponse) : void;
   }
}

