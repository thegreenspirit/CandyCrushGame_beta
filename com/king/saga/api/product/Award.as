package com.king.saga.api.product
{
   import com.midasplayer.util.TypedKeyVal;
   
   public class Award
   {
      private var _amount:int;
      
      private var _id:int;
      
      private var _num:int;
      
      private var _type:String;
      
      public function Award(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._amount = _loc_2.getAsInt("amount");
         this._id = _loc_2.getAsInt("id");
         this._num = _loc_2.getAsInt("num");
         this._type = _loc_2.getAsString("type");
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get num() : int
      {
         return this._num;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

