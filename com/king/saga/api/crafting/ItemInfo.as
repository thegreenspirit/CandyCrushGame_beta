package com.king.saga.api.crafting
{
   import com.midasplayer.util.*;
   
   public class ItemInfo
   {
      public static const NOT_SET:int = 0;
      
      public static const LOCKED:int = 1;
      
      public static const UNLOCKED:int = 2;
      
      public static const ACTIVATED:int = 3;
      
      private var _typeId:int;
      
      private var _type:String;
      
      private var _category:String;
      
      public var _amount:Number;
      
      private var _availability:int;
      
      public function ItemInfo(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._typeId = _loc_2.getAsInt("typeId");
         this._type = _loc_2.getAsString("type");
         this._category = _loc_2.getAsString("category");
         this._amount = _loc_2.getAsIntNumber("amount");
         this._availability = _loc_2.getAsInt("availability");
      }
      
      public function Export() : Object
      {
         var data:Object = {};
         data.typeId = this._typeId;
         data.type = this._type;
         data.category = this._category;
         data.amount = this._amount;
         if(data.amount < 0)
         {
            data.amount = 0;
         }
         data.availability = this._availability;
         data.leaseStatus = 0;
         return data;
      }
      
      public function getTypeId() : int
      {
         return this._typeId;
      }
      
      public function getType() : String
      {
         return this._type;
      }
      
      public function getCategory() : String
      {
         return this._category;
      }
      
      public function getAmount() : Number
      {
         return this._amount;
      }
      
      public function getAvailability() : int
      {
         return this._availability;
      }
   }
}

