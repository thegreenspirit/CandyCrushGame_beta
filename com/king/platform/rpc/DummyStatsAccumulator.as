package com.king.platform.rpc
{
   import flash.net.URLRequest;
   
   public class DummyStatsAccumulator implements StatsAccumulator
   {
      public function DummyStatsAccumulator()
      {
         super();
      }
      
      public function requestInitiated(param1:Boolean) : uint
      {
         return 0;
      }
      
      public function requestSucceeded(param1:uint, param2:URLRequest) : void
      {
      }
      
      public function requestFailed(param1:uint) : void
      {
      }
      
      public function getResult(param1:String) : StatsResult
      {
         return StatsResult.ZERO;
      }
      
      public function reset() : void
      {
      }
   }
}

