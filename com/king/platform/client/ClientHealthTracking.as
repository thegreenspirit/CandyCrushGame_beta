package com.king.platform.client
{
   import com.king.platform.rpc.RpcService;
   
   public class ClientHealthTracking
   {
      private var rpcService:RpcService;
      
      public function ClientHealthTracking(param1:RpcService)
      {
         super();
         this.rpcService = param1;
      }
      
      public function ClientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var stage:* = param4;
         var callback:* = param5;
         var errorCallback:* = param6;
         var args:* = new Array(appId,coreUserId,clientType,stage);
         this.rpcService.call("ClientHealthTracking.ClientStartupStage",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientStartupStage(param1:int, param2:Number, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var stage:* = param4;
         var callback:* = param5;
         var errorCallback:* = param6;
         var args:* = new Array(appId,coreUserId,clientType,stage);
         this.rpcService.call("ClientHealthTracking.clientStartupStage",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientStartupStage2(param1:int, param2:int, param3:Function, param4:Function) : void
      {
         var clientType:* = param1;
         var stage:* = param2;
         var callback:* = param3;
         var errorCallback:* = param4;
         var args:* = new Array(clientType,stage);
         this.rpcService.call("ClientHealthTracking.clientStartupStage2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function ClientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var bytesLoaded:* = param4;
         var callback:* = param5;
         var errorCallback:* = param6;
         var args:* = new Array(appId,coreUserId,clientType,bytesLoaded);
         this.rpcService.call("ClientHealthTracking.ClientLoadProgress",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientLoadProgress(param1:int, param2:Number, param3:int, param4:Number, param5:Function, param6:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var bytesLoaded:* = param4;
         var callback:* = param5;
         var errorCallback:* = param6;
         var args:* = new Array(appId,coreUserId,clientType,bytesLoaded);
         this.rpcService.call("ClientHealthTracking.clientLoadProgress",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientLoadProgress2(param1:int, param2:Number, param3:Function, param4:Function) : void
      {
         var clientType:* = param1;
         var bytesLoaded:* = param2;
         var callback:* = param3;
         var errorCallback:* = param4;
         var args:* = new Array(clientType,bytesLoaded);
         this.rpcService.call("ClientHealthTracking.clientLoadProgress2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function FlashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var version:* = param4;
         var manufacturer:* = param5;
         var os:* = param6;
         var screenWidth:* = param7;
         var screenHeight:* = param8;
         var callback:* = param9;
         var errorCallback:* = param10;
         var args:* = new Array(appId,coreUserId,clientType,version,manufacturer,os,screenWidth,screenHeight);
         this.rpcService.call("ClientHealthTracking.FlashClientInformation",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function flashClientInformation(param1:int, param2:Number, param3:int, param4:String, param5:String, param6:String, param7:int, param8:int, param9:Function, param10:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var version:* = param4;
         var manufacturer:* = param5;
         var os:* = param6;
         var screenWidth:* = param7;
         var screenHeight:* = param8;
         var callback:* = param9;
         var errorCallback:* = param10;
         var args:* = new Array(appId,coreUserId,clientType,version,manufacturer,os,screenWidth,screenHeight);
         this.rpcService.call("ClientHealthTracking.flashClientInformation",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function flashClientInformation2(param1:int, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Function, param8:Function) : void
      {
         var clientType:* = param1;
         var version:* = param2;
         var manufacturer:* = param3;
         var os:* = param4;
         var screenWidth:* = param5;
         var screenHeight:* = param6;
         var callback:* = param7;
         var errorCallback:* = param8;
         var args:* = new Array(clientType,version,manufacturer,os,screenWidth,screenHeight);
         this.rpcService.call("ClientHealthTracking.flashClientInformation2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientException(param1:int, param2:Number, param3:int, param4:String, param5:Function, param6:Function) : void
      {
         var appId:* = param1;
         var coreUserId:* = param2;
         var clientType:* = param3;
         var text:* = param4;
         var callback:* = param5;
         var errorCallback:* = param6;
         var args:* = new Array(appId,coreUserId,clientType,text);
         this.rpcService.call("ClientHealthTracking.clientException",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
      
      public function clientException2(param1:int, param2:String, param3:Function, param4:Function) : void
      {
         var clientType:* = param1;
         var text:* = param2;
         var callback:* = param3;
         var errorCallback:* = param4;
         var args:* = new Array(clientType,text);
         this.rpcService.call("ClientHealthTracking.clientException2",args,function(param1:Object):void
         {
            callback();
         },errorCallback);
      }
   }
}

