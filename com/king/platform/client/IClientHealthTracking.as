package com.king.platform.client
{
   public interface IClientHealthTracking
   {
      function flashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void;
      
      function clientException(param1:int, param2:Number, param3:int, param4:String, param5:Function, param6:Function) : void;
      
      function clientError2(param1:int, param2:String, param3:Function, param4:Function) : void;
      
      function clientError(param1:int, param2:Number, param3:int, param4:String, param5:Function, param6:Function) : void;
      
      function ClientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void;
      
      function FlashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void;
      
      function androidClientCrashReport(param1:Number, param2:String, param3:String, param4:String, param5:Function, param6:Function) : void;
      
      function clientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void;
      
      function flashClientInformation2(param1:int, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Function, param8:Function) : void;
      
      function ClientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void;
      
      function clientStartupStage2(param1:int, param2:int, param3:Function, param4:Function) : void;
      
      function clientException2(param1:int, param2:String, param3:Function, param4:Function) : void;
      
      function clientLoadProgress2(param1:int, param2:Number, param3:Function, param4:Function) : void;
      
      function clientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void;
   }
}

