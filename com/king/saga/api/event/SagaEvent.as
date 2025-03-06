package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class SagaEvent
   {
      private var _data:String;
      
      private var _type:String;
      
      public function SagaEvent(param1:Object, param2:String)
      {
         super();
         var _loc_3:* = new TypedKeyVal(param1);
         this._data = _loc_3.getAsString("data");
         this._type = param2;
      }
      
      public function getData() : String
      {
         return this._data;
      }
      
      public function getType() : String
      {
         return this._type;
      }
   }
}

