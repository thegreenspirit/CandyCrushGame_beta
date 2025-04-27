package com.king.platform.rpc
{
   public interface RpcService
   {
      function begin() : void;
      
      function send() : void;
      
      function call(param1:String, param2:Array, param3:Function = null, param4:Function = null) : void;
   }
}

