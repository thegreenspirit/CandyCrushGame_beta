package com.king.platform.client
{
   import com.king.platform.rpc.IRpcService;
   
   public class ClientHealthTracking implements IClientHealthTracking
   {
      private var rpcService:IRpcService;
      
      public function ClientHealthTracking(param1:IRpcService)
      {
         super();
         this.rpcService = param1;
      }
      
      public function flashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var version:String = param4;
         var manufacturer:String = param5;
         var os:String = param6;
         var screenWidth:int = param7;
         var screenHeight:int = param8;
         var callback:Function = param9;
         var errorCallback:Function = param10;
         var args:Array = [appId,coreUserId,clientType,version,manufacturer,os,screenWidth,screenHeight];
         this.rpcService.call("ClientHealthTracking.flashClientInformation",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientException(param1:int, param2:Number, param3:int, param4:String, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var text:String = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,text];
         this.rpcService.call("ClientHealthTracking.clientException",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientError2(param1:int, param2:String, param3:Function, param4:Function) : void
      {
         var clientType:int = param1;
         var text:String = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var args:Array = [clientType,text];
         this.rpcService.call("ClientHealthTracking.clientError2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientError(param1:int, param2:Number, param3:int, param4:String, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var text:String = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,text];
         this.rpcService.call("ClientHealthTracking.clientError",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function ClientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var bytesLoaded:Number = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,bytesLoaded];
         this.rpcService.call("ClientHealthTracking.ClientLoadProgress",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function FlashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var version:String = param4;
         var manufacturer:String = param5;
         var os:String = param6;
         var screenWidth:int = param7;
         var screenHeight:int = param8;
         var callback:Function = param9;
         var errorCallback:Function = param10;
         var args:Array = [appId,coreUserId,clientType,version,manufacturer,os,screenWidth,screenHeight];
         this.rpcService.call("ClientHealthTracking.FlashClientInformation",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function androidClientCrashReport(param1:Number, param2:String, param3:String, param4:String, param5:Function, param6:Function) : void
      {
         var coreUserId:Number = param1;
         var installId:String = param2;
         var version:String = param3;
         var text:String = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [coreUserId,installId,version,text];
         this.rpcService.call("ClientHealthTracking.androidClientCrashReport",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var bytesLoaded:Number = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,bytesLoaded];
         this.rpcService.call("ClientHealthTracking.clientLoadProgress",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function flashClientInformation2(param1:int, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Function, param8:Function) : void
      {
         var clientType:int = param1;
         var version:String = param2;
         var manufacturer:String = param3;
         var os:String = param4;
         var screenWidth:int = param5;
         var screenHeight:int = param6;
         var callback:Function = param7;
         var errorCallback:Function = param8;
         var args:Array = [clientType,version,manufacturer,os,screenWidth,screenHeight];
         this.rpcService.call("ClientHealthTracking.flashClientInformation2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function ClientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var stage:int = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,stage];
         this.rpcService.call("ClientHealthTracking.ClientStartupStage",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientStartupStage2(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         var clientType:int = param1;
         var stage:int = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var args:Array = [clientType,stage];
         this.rpcService.call("ClientHealthTracking.clientStartupStage2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientException2(param1:int, param2:String, param3:Function, param4:Function) : void
      {
         var clientType:int = param1;
         var text:String = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var args:Array = [clientType,text];
         this.rpcService.call("ClientHealthTracking.clientException2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientLoadProgress2(param1:int, param2:Number, param3:Function, param4:Function) : void
      {
         var clientType:int = param1;
         var bytesLoaded:Number = param2;
         var callback:Function = param3;
         var errorCallback:Function = param4;
         var args:Array = [clientType,bytesLoaded];
         this.rpcService.call("ClientHealthTracking.clientLoadProgress2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var appId:int = param1;
         var coreUserId:Number = param2;
         var clientType:int = param3;
         var stage:int = param4;
         var callback:Function = param5;
         var errorCallback:Function = param6;
         var args:Array = [appId,coreUserId,clientType,stage];
         this.rpcService.call("ClientHealthTracking.clientStartupStage",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
   }
}

