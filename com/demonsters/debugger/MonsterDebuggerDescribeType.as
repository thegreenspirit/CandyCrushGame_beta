package com.demonsters.debugger
{
   import flash.utils.*;
   
   internal class MonsterDebuggerDescribeType
   {
      private static var cache:Object = {};
      
      public function MonsterDebuggerDescribeType()
      {
         super();
      }
      
      internal static function get(param1:*) : XML
      {
         var _loc_2:* = getQualifiedClassName(param1);
         if(_loc_2 in cache)
         {
            return cache[_loc_2];
         }
         var _loc_3:* = describeType(param1);
         cache[_loc_2] = _loc_3;
         return _loc_3;
      }
   }
}

