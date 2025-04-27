package com.king.platform.rpc
{
   import com.king.platform.util.*;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.*;
   
   public class RemoteRpcService implements RpcService
   {
      private var url:String;
      
      private var sessionKey:String;
      
      private var methodCalls:Vector.<MethodCall>;
      
      private var multi:Boolean;
      
      private var maxRetries:int = 3;
      
      public function RemoteRpcService(param1:String, param2:String)
      {
         super();
         this.methodCalls = new Vector.<MethodCall>();
         this.url = param1;
         this.sessionKey = param2;
      }
      
      public function begin() : void
      {
         this.multi = true;
      }
      
      public function send() : void
      {
         this.jsonRpcCall(0);
      }
      
      public function call(param1:String, param2:Array, param3:Function = null, param4:Function = null) : void
      {
         this.methodCalls.push(new MethodCall(param1,param2,param3,param4));
         if(!this.multi)
         {
            this.jsonRpcCall(0);
         }
      }
      
      private function jsonRpcCall(param1:int) : void
      {
         var loader:*;
         var localMethodCalls:Vector.<MethodCall> = null;
         var json:String = null;
         var retry:* = undefined;
         var i:uint = 0;
         retry = undefined;
         retry = param1;
         localMethodCalls = this.methodCalls;
         var request:* = new URLRequest();
         request.url = this.url + "?_session=" + this.sessionKey;
         request.method = URLRequestMethod.POST;
         request.contentType = "application/json";
         while(i < localMethodCalls.length)
         {
            if(i > 0)
            {
               json += ",";
            }
            json += "{\"id\":" + i + ",\"method\":\"" + localMethodCalls[i].method + "\"" + ",\"params\":" + KJSON.stringify(localMethodCalls[i].params) + "}";
            i += 1;
         }
         json += "]";
         request.data = json;
         loader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var _loc3_:uint = 0;
            trace("event.target.data=" + param1.target.data);
            var _loc2_:* = KJSON.parse(param1.target.data);
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_].error != undefined)
               {
                  localMethodCalls[_loc2_[_loc3_].id].errorCallback(_loc2_[_loc3_].error);
               }
               else
               {
                  localMethodCalls[_loc2_[_loc3_].id].callback(_loc2_[_loc3_].result);
               }
               _loc3_ += 1;
            }
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            var _loc2_:uint = 0;
            if(retry < maxRetries)
            {
               setTimeout(jsonRpcCall,1000,retry + 1);
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < localMethodCalls.length)
               {
                  localMethodCalls[_loc2_].errorCallback(param1.toString());
                  _loc2_ += 1;
               }
            }
         });
         loader.load(request);
         this.methodCalls = new Vector.<MethodCall>();
         this.multi = false;
      }
      
      private function printObject(param1:Object, param2:String) : void
      {
         var _loc3_:String = null;
         for(_loc3_ in param1)
         {
            trace(param2 + _loc3_ + ":" + param1[_loc3_]);
            if(typeof param1[_loc3_] == "object")
            {
               this.printObject(param1[_loc3_],"  ");
            }
         }
      }
   }
}

class MethodCall
{
   public var method:String;
   
   public var params:Array;
   
   public var callback:Function;
   
   public var errorCallback:Function;
   
   public function MethodCall(param1:String, param2:Array, param3:Function, param4:Function)
   {
      super();
      this.method = param1;
      this.params = param2;
      this.callback = param3;
      this.errorCallback = param4;
   }
}
