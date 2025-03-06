package com.king.saga.api.crafting
{
   import com.midasplayer.util.*;
   
   public class Recipe
   {
      private var _name:String;
      
      private var _inputsTypeIds:Vector.<ItemAmount>;
      
      private var _outputsTypeIds:Vector.<ItemAmount>;
      
      public function Recipe(param1:Object)
      {
         var _loc_2:TypedKeyVal = null;
         var _loc_4:Object = null;
         var _loc_5:Array = null;
         var _loc_6:Object = null;
         super();
         this._inputsTypeIds = new Vector.<ItemAmount>();
         this._outputsTypeIds = new Vector.<ItemAmount>();
         _loc_2 = new TypedKeyVal(param1);
         this._name = _loc_2.getAsString("name");
         var _loc_3:* = _loc_2.getAsArray("inputstypeIds");
         for each(_loc_4 in _loc_3)
         {
            this._inputsTypeIds.push(new ItemAmount(_loc_4));
         }
         _loc_5 = _loc_2.getAsArray("outputtypeIds");
         for each(_loc_6 in _loc_5)
         {
            this._outputsTypeIds.push(new ItemAmount(_loc_6));
         }
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getInputTypeIds() : Vector.<ItemAmount>
      {
         return this._inputsTypeIds;
      }
      
      public function getOutputTypeIds() : Vector.<ItemAmount>
      {
         return this._outputsTypeIds;
      }
   }
}

