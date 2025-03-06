package com.king.platform.rpc
{
   public class StatsResult
   {
      public static const ZERO:StatsResult = new StatsResult(0,0,0,0,0,0,0,0,0,0,0);
      
      private var _requests:Number;
      
      private var _failed:Number;
      
      private var _retries:Number;
      
      private var _bytes:Number;
      
      private var _latency_0:Number;
      
      private var _latency_500:Number;
      
      private var _latency_1000:Number;
      
      private var _latency_2000:Number;
      
      private var _latency_3000:Number;
      
      private var _latency_5000:Number;
      
      private var _latency_10000:Number;
      
      public function StatsResult(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number)
      {
         super();
         this._requests = param1;
         this._failed = param2;
         this._retries = param3;
         this._bytes = param4;
         this._latency_0 = param5;
         this._latency_500 = param6;
         this._latency_1000 = param7;
         this._latency_2000 = param8;
         this._latency_3000 = param9;
         this._latency_5000 = param10;
         this._latency_10000 = param11;
      }
      
      public function get requests() : Number
      {
         return this._requests;
      }
      
      public function get failed() : Number
      {
         return this._failed;
      }
      
      public function get retries() : Number
      {
         return this._retries;
      }
      
      public function get bytes() : Number
      {
         return this._bytes;
      }
      
      public function get latency_0() : Number
      {
         return this._latency_0;
      }
      
      public function get latency_500() : Number
      {
         return this._latency_500;
      }
      
      public function get latency_1000() : Number
      {
         return this._latency_1000;
      }
      
      public function get latency_2000() : Number
      {
         return this._latency_2000;
      }
      
      public function get latency_3000() : Number
      {
         return this._latency_3000;
      }
      
      public function get latency_5000() : Number
      {
         return this._latency_5000;
      }
      
      public function get latency_10000() : Number
      {
         return this._latency_10000;
      }
   }
}

