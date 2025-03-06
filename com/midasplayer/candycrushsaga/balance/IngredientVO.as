package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.crafting.*;
   import flash.display.*;
   
   public class IngredientVO
   {
      public var mc:MovieClip;
      
      public var item:ItemAmount;
      
      public function IngredientVO(param1:MovieClip, param2:ItemAmount)
      {
         super();
         this.mc = param1;
         this.item = param2;
         this.mc.iIngredient.gotoAndStop(param2.getType());
      }
   }
}

