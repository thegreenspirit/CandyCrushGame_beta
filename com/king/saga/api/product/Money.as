package com.king.saga.api.product
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   import flash.globalization.*;
   
   public class Money
   {
      private var _cents:int;
      
      private var _currency:String;
      
      public function Money(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._cents = _loc_2.getAsInt("cents");
         this._currency = _loc_2.getAsString("currency");
      }
      
      public static function create(param1:int, param2:String) : Money
      {
         var _loc_3:* = new Object();
         _loc_3.cents = param1;
         _loc_3.currency = param2;
         return new Money(_loc_3);
      }
      
      public function getCurrency() : String
      {
         return this._currency;
      }
      
      public function getAmount() : Number
      {
         return this._cents / 100;
      }
      
      public function toString() : String
      {
         var _loc_2:CurrencyFormatter = null;
         var _loc_3:CurrencyFormatter = null;
         var _loc_1:* = this.getAmount();
         if(this._currency == "FBC")
         {
            return _loc_1.toString();
         }
         if(this._currency == "USD")
         {
            _loc_2 = new CurrencyFormatter("en-US");
            return _loc_2.format(_loc_1,true);
         }
         if(this._currency == "EUR")
         {
            _loc_3 = new CurrencyFormatter("de-DE");
            return _loc_3.format(_loc_1,true);
         }
         Debug.assert(false,"Trying to use an unidentified currency: " + this._currency);
         return _loc_1.toString();
      }
      
      public function copy(param1:Money) : void
      {
         this._cents = param1._cents;
         this._currency = param1._currency;
      }
   }
}

