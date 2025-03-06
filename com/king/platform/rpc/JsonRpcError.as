package com.king.platform.rpc
{
   import com.king.platform.util.KJSON;
   
   public class JsonRpcError
   {
      public var code:int = 0;
      
      public var message:String = null;
      
      public function JsonRpcError(param1:int = 0, param2:String = null)
      {
         super();
         this.code = param1;
         this.message = param2;
      }
      
      public static function fromJson(param1:String) : JsonRpcError
      {
         return fromJSONObject(KJSON.parse(param1));
      }
      
      public static function fromJSONObject(param1:Object) : JsonRpcError
      {
         if(param1 === null)
         {
            return null;
         }
         var _loc2_:JsonRpcError = new JsonRpcError();
         _loc2_.code = !!param1.hasOwnProperty("code") ? int(param1.code) : 0;
         _loc2_.message = !!param1.hasOwnProperty("message") ? param1.message : null;
         return _loc2_;
      }
      
      public static function toJson(param1:JsonRpcError) : String
      {
         return KJSON.stringify(param1);
      }
      
      public function toString() : String
      {
         return "JsonRpcError" + KJSON.stringify(this);
      }
   }
}

