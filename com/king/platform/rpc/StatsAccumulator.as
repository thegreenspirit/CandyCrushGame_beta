package com.king.platform.rpc
{
   import flash.net.URLRequest;
   
   public interface StatsAccumulator
   {
      function requestInitiated(param1:Boolean) : uint;
      
      function requestSucceeded(param1:uint, param2:URLRequest) : void;
      
      function requestFailed(param1:uint) : void;
      
      function getResult(param1:String) : StatsResult;
      
      function reset() : void;
   }
}

