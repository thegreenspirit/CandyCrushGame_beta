package com.king.saga.api.universe.condition
{
   public class UnlockData
   {
      private var _type:String;
      
      public function UnlockData(param1:String)
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

