package com.king.saga.api.universe.condition
{
   public class UnlockCondition
   {
      private var _type:String;
      
      public function UnlockCondition(param1:String)
      {
         super();
         this._type = param1;
      }
      
      public function getType() : String
      {
         return this._type;
      }
   }
}

