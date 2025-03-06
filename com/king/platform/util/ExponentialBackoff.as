package com.king.platform.util
{
   public class ExponentialBackoff
   {
      public function ExponentialBackoff()
      {
         super();
      }
      
      public static function getTimeout(param1:uint, param2:uint) : uint
      {
         return param1 * (Math.pow(2,Math.max(param2,0)) + Math.random());
      }
   }
}

