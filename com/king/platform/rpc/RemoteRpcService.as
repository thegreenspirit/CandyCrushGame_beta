package com.king.platform.rpc
{
   import com.king.platform.events.ErrorCode;
   import com.king.platform.events.ErrorEvent;
   import com.king.platform.util.ExponentialBackoff;
   import com.king.platform.util.KJSON;
   import com.king.platform.util.Logger;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.setTimeout;
   
   public class RemoteRpcService extends EventDispatcher implements IRpcService
   {
      private const maxRetries:int = 3;
      
      private var url:String;
      
      private var sessionKeyProvider:SessionKeyProvider;
      
      private var statistics:StatsAccumulator;
      
      private var methodCalls:Vector.<MethodCall> = new Vector.<MethodCall>();
      
      private var multi:Boolean;
      
      private var retryInProgress:Boolean;
      
      private var fatalError:Boolean;
      
      private var requestCount:int = 0;
      
      public var eventBus:IEventDispatcher;
      
      internal function urlLoaderFactory():URLLoader
      {
         return new URLLoader();
      }
      internal function exponentialBackoff(param1:uint, param2:uint):uint
      {
         return ExponentialBackoff.getTimeout(param1,param2);
      }
      public function RemoteRpcService(param1:String, param2:SessionKeyProvider, param3:StatsAccumulator = null)
      {
         super();
         this.url = param1;
         this.sessionKeyProvider = param2;
         this.statistics = param3 == null ? new DummyStatsAccumulator() : param3;
         this.retryInProgress = false;
         this.fatalError = false;
      }
      
      public function begin() : void
      {
         this.multi = true;
      }
      
      public function send() : void
      {
         if(this.fatalError)
         {
            Logger.debug("RPC: Blocking all RPCs because of fatal error");
            return;
         }
         if(!this.retryInProgress)
         {
            this.jsonRpcCall(0);
            this.multi = false;
         }
      }
      
      public function call(param1:String, param2:Array, param3:Function = null, param4:Function = null) : void
      {
         if(this.fatalError)
         {
            Logger.debug("RPC: Blocking all RPCs because of fatal error: " + param1);
            param4(new JsonRpcError(JsonRpcErrorCode.FATAL,"FATAL"));
            return;
         }
         this.methodCalls.push(new MethodCall(param1,param2,param3,param4));
         if(!this.multi && !this.retryInProgress)
         {
            this.jsonRpcCall(0);
         }
      }
      
      internal function jsonRpcCall(param1:int) : void
      {
         var i:uint;
         var invokeErrorCallbacks:Function;
         var loader:URLLoader;
         var localMethodCalls:Vector.<MethodCall> = null;
         var request:URLRequest = null;
         var requestNr:int = 0;
         var json:String = null;
         var requestId:uint = 0;
         var retry:int = param1;
         if(this.methodCalls.length <= 0)
         {
            return;
         }
         if(this.fatalError)
         {
            Logger.debug("RPC: Blocking all RPCs because of fatal error");
            return;
         }
         localMethodCalls = this.methodCalls;
         this.methodCalls = new Vector.<MethodCall>();
         request = new URLRequest();
         request.url = this.url + "?_session=" + this.sessionKeyProvider.sessionKey;
         request.method = URLRequestMethod.POST;
         request.contentType = "application/json";
         requestNr = ++this.requestCount;
         json = "[";
         i = 0;
         while(i < localMethodCalls.length)
         {
            if(i > 0)
            {
               json += ",";
            }
            json += "{\"id\":" + i + ",\"method\":\"" + localMethodCalls[i].method + "\"" + ",\"params\":" + KJSON.stringify(localMethodCalls[i].params) + "}";
            i++;
         }
         json += "]";
         request.data = json;
         Logger.debug("RPC: call#" + requestNr + "=" + json);
         invokeErrorCallbacks = function(param1:Vector.<MethodCall>, param2:JsonRpcError):void
         {
            var i:uint = 0;
            var methods:Vector.<MethodCall> = param1;
            var error:JsonRpcError = param2;
            i = 0;
            while(i < methods.length)
            {
               try
               {
                  methods[i].errorCallback(error);
               }
               catch(error:Error)
               {
                  Logger.warn("RPC: error callback for " + methods[i].method + " threw exception " + error);
               }
               i++;
            }
         };
         requestId = this.statistics.requestInitiated(retry > 0);
         loader = this.urlLoaderFactory();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var jsonObj:Object;
            var sessionTimeout:Boolean;
            var i:uint;
            var methodCall:MethodCall = null;
            var error:JsonRpcError = null;
            var event:Event = param1;
            statistics.requestSucceeded(requestId,request);
            Logger.debug("RPC: data#" + requestNr + "=" + event.target.data);
            jsonObj = KJSON.parse(event.target.data);
            sessionTimeout = false;
            i = 0;
            while(i < jsonObj.length)
            {
               methodCall = localMethodCalls[jsonObj[i].id];
               if(jsonObj[i].error != undefined)
               {
                  if(jsonObj[i].error.code == 2)
                  {
                     sessionTimeout = true;
                     methodCalls.push(methodCall);
                  }
                  else
                  {
                     try
                     {
                        error = new JsonRpcError(jsonObj[i].code,jsonObj[i].message);
                        methodCall.errorCallback(error);
                     }
                     catch(error:Error)
                     {
                        Logger.warn("RPC: error callback for " + methodCall.method + " threw exception " + error);
                        throw error;
                     }
                  }
               }
               else
               {
                  try
                  {
                     methodCall.callback(jsonObj[i].result);
                  }
                  catch(error:Error)
                  {
                     Logger.warn("RPC: callback for " + methodCall.method + " threw exception " + error);
                     throw error;
                  }
               }
               i++;
            }
            retryInProgress = false;
            if(sessionTimeout)
            {
               fatalError = true;
               invokeErrorCallbacks(localMethodCalls,new JsonRpcError(JsonRpcErrorCode.AUTHENTICATION_ERROR,"SessionTimeout"));
               sendEvent(new ErrorEvent(ErrorEvent.FATAL,ErrorCode.SESSION_TIMEOUT));
               Logger.error("RPC: SessionTimeout");
            }
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:IOErrorEvent):void
         {
            var _loc2_:MethodCall = null;
            statistics.requestFailed(requestId);
            retryInProgress = true;
            Logger.debug("RPC: io_error#" + requestNr + "=" + param1.text);
            if(retry >= maxRetries)
            {
               fatalError = true;
               invokeErrorCallbacks(localMethodCalls,new JsonRpcError(JsonRpcErrorCode.FATAL,param1.toString()));
               sendEvent(new ErrorEvent(ErrorEvent.FATAL,ErrorCode.NO_CONNECTION));
            }
            else
            {
               for each(_loc2_ in localMethodCalls)
               {
                  methodCalls.push(_loc2_);
               }
               setTimeout(jsonRpcCall,exponentialBackoff(1000,retry),retry + 1);
            }
         });
         loader.load(request);
      }
      
      private function sendEvent(param1:ErrorEvent) : void
      {
         Logger.debug("RPC: ErrorEvent(" + param1.type + ", " + param1.message + ")");
         if(this.eventBus != null)
         {
            this.eventBus.dispatchEvent(param1);
         }
         else
         {
            dispatchEvent(param1);
         }
      }
   }
}

class MethodCall
{
   internal var method:String;
   
   internal var params:Array;
   
   internal var callback:Function;
   
   internal var errorCallback:Function;
   
   public function MethodCall(param1:String, param2:Array, param3:Function, param4:Function)
   {
      super();
      this.method = param1;
      this.params = param2;
      this.callback = param3;
      this.errorCallback = param4;
   }
}
