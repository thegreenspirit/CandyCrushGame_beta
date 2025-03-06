package com.king.platform.rpc
{
   public class JsonRpcErrorCode
   {
      public static const FATAL:int = -32000;
      
      public static const INVALID_JSON:int = -32700;
      
      public static const INVALID_REQUEST:int = -32600;
      
      public static const METHOD_NOT_FOUND:int = -32601;
      
      public static const INVALID_PARAMS:int = -32602;
      
      public static const INTERNAL_ERROR:int = -32603;
      
      public static const SERVICE_UNAVAILABLE:int = -32099;
      
      public static const AUTHENTICATION_ERROR:int = 2;
      
      public static const NO_SESSION_KEY_ERROR:int = 3;
      
      public function JsonRpcErrorCode()
      {
         super();
      }
   }
}

