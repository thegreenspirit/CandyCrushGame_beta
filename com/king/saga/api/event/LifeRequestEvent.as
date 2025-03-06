package com.king.saga.api.event
{
   import com.midasplayer.util.*;
   
   public class LifeRequestEvent extends SagaEvent
   {
      public static const Type:String = "LIFE_REQUEST";
      
      private var _fromId:Number;
      
      public function LifeRequestEvent(param1:Object, param2:Object)
      {
         super(param1,Type);
         var _loc_3:* = new TypedKeyVal(param2);
         this._fromId = _loc_3.getAsIntNumber("fromId");
      }
      
      public function getFromId() : Number
      {
         return this._fromId;
      }
   }
}

