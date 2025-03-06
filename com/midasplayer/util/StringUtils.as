package com.midasplayer.util
{
   public class StringUtils
   {
      public function StringUtils()
      {
         super();
      }
      
      public static function leftAlign(param1:String, param2:int) : String
      {
         var _loc_3:* = param2 - param1.length;
         if(_loc_3 <= 0)
         {
            return param1;
         }
         var _loc_4:String = " ";
         var _loc_5:int = 1;
         while(_loc_5 < _loc_3)
         {
            _loc_4 += " ";
            _loc_5++;
         }
         return param1 + _loc_4;
      }
      
      public static function rightAlign(param1:String, param2:int) : String
      {
         var _loc_3:* = param2 - param1.length;
         if(_loc_3 <= 0)
         {
            return param1;
         }
         var _loc_4:String = " ";
         var _loc_5:int = 1;
         while(_loc_5 < _loc_3)
         {
            _loc_4 += " ";
            _loc_5++;
         }
         return _loc_4 + param1;
      }
      
      public static function countOccurrence(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : int
      {
         var _loc_5:int = 0;
         if(param2 == "")
         {
            return 0;
         }
         var _loc_6:* = param1.indexOf(param2);
         if(param1.indexOf(param2) == -1)
         {
            return 0;
         }
         if(!param4 && _loc_6 == 0)
         {
            _loc_5++;
         }
         do
         {
            _loc_5++;
            _loc_6 = param1.indexOf(param2,_loc_6) + 1;
         }
         while(_loc_6 != 0);
         
         if(param3 && param1.lastIndexOf(param2) == param1.length - param2.length)
         {
            _loc_5 -= 1;
         }
         return _loc_5;
      }
   }
}

