package com.king.platform.util
{
   import com.adobe.serialization.json.JSON;
   
   public class KJSON
   {
      public function KJSON()
      {
         super();
      }
      
      public static function parse(param1:String) : Object
      {
         return com.adobe.serialization.json.JSON.decode(param1,true);
      }
      
      public static function stringify(param1:Object) : String
      {
         return com.adobe.serialization.json.JSON.encode(param1);
      }
   }
}

