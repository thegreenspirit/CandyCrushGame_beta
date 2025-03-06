package com.king.saga.api.response
{
   import com.king.saga.api.crafting.*;
   
   public class GetRecipesResponse
   {
      private var _recipes:Vector.<Recipe>;
      
      public function GetRecipesResponse(param1:Object)
      {
         var _loc_3:Object = null;
         super();
         this._recipes = new Vector.<Recipe>();
         var _loc_2:* = param1 as Array;
         for each(_loc_3 in _loc_2)
         {
            this._recipes.push(new Recipe(_loc_3));
         }
      }
      
      public function getRecipes() : Vector.<Recipe>
      {
         return this._recipes;
      }
   }
}

