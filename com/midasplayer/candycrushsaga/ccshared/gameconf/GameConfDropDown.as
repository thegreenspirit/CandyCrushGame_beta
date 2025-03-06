package com.midasplayer.candycrushsaga.ccshared.gameconf
{
   import com.midasplayer.util.*;
   
   public class GameConfDropDown extends GameConf
   {
      private var _moveLimit:Number;
      
      private var _ingredients:Array;
      
      private var _numIngredientsOnScreen:int;
      
      private var _ingredientSpawnDensity:int;
      
      public function GameConfDropDown()
      {
         super();
         setGameModeName(GameConf.MODE_NAME_DROP_DOWN);
         _levelInfoVO.isDropDownMode = true;
         this.setMoveLimit(50);
         this.setIngredients([]);
         this.setNumIngredientsOnScreen(1);
         this.setIngredientSpawnDensity(15);
      }
      
      override public function loadFromObject(param1:Object) : void
      {
         super.loadFromObject(param1);
         var _loc_2:* = new TypedKeyVal(param1);
         this.setMoveLimit(_loc_2.getAsNumber("moveLimit"));
         this.setIngredients(_loc_2.getAsArray("ingredients"));
         this.setNumIngredientsOnScreen(_loc_2.getAsInt("numIngredientsOnScreen"));
         this.setIngredientSpawnDensity(_loc_2.getAsInt("ingredientSpawnDensity"));
      }
      
      override public function getAsObject() : Object
      {
         var _loc_1:* = super.getAsObject();
         _loc_1["moveLimit"] = this.moveLimit();
         _loc_1["ingredients"] = this.ingredients();
         _loc_1["numIngredientsOnScreen"] = this.numIngredientsOnScreen();
         _loc_1["ingredientSpawnDensity"] = this.ingredientSpawnDensity();
         return _loc_1;
      }
      
      public function moveLimit() : int
      {
         return this._moveLimit;
      }
      
      public function setMoveLimit(param1:int) : void
      {
         this._moveLimit = param1;
      }
      
      public function ingredients() : Array
      {
         var _loc_2:int = 0;
         var _loc_1:* = new Array();
         while(_loc_2 < this._ingredients.length)
         {
            _loc_1.push(this._ingredients[_loc_2]);
            _loc_2++;
         }
         return _loc_1;
      }
      
      public function setIngredients(param1:Array) : void
      {
         var _loc_2:int = 0;
         this._ingredients = new Array();
         while(_loc_2 < param1.length)
         {
            this._ingredients.push(param1[_loc_2]);
            _loc_2++;
         }
      }
      
      public function ingredientAmount(param1:int) : int
      {
         if(this._ingredients.length > 0 && param1 >= 0 && param1 < this._ingredients.length)
         {
            return this._ingredients[param1];
         }
         return 0;
      }
      
      public function setIngredientAmount(param1:int, param2:int) : void
      {
         var _loc_3:int = 0;
         if(this._ingredients.length < param1 + 1)
         {
            _loc_3 = int(this._ingredients.length);
            while(_loc_3 < param1 + 1)
            {
               this._ingredients.push(0);
               _loc_3++;
            }
         }
         this._ingredients[param1] = param2;
      }
      
      public function numIngredientsOnScreen() : int
      {
         return this._numIngredientsOnScreen;
      }
      
      public function setNumIngredientsOnScreen(param1:int) : void
      {
         this._numIngredientsOnScreen = param1;
      }
      
      public function ingredientSpawnDensity() : int
      {
         return this._ingredientSpawnDensity;
      }
      
      public function setIngredientSpawnDensity(param1:int) : void
      {
         this._ingredientSpawnDensity = param1;
      }
   }
}

