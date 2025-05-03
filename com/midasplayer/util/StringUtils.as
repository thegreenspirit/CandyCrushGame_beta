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
         var _loc3_:* = param2 - param1.length;
         if(_loc3_ <= 0)
         {
            return param1;
         }
         var _loc4_:String = " ";
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_)
         {
            _loc4_ += " ";
            _loc5_++;
         }
         return param1 + _loc4_;
      }
      
      public static function rightAlign(param1:String, param2:int) : String
      {
         var _loc3_:* = param2 - param1.length;
         if(_loc3_ <= 0)
         {
            return param1;
         }
         var _loc4_:String = " ";
         var _loc5_:int = 1;
         while(_loc5_ < _loc3_)
         {
            _loc4_ += " ";
            _loc5_++;
         }
         return _loc4_ + param1;
      }
      
      public static function countOccurrence(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : int
      {
         var _loc5_:int = 0;
         if(param2 == "")
         {
            return 0;
         }
         var _loc6_:* = param1.indexOf(param2);
         if(param1.indexOf(param2) == -1)
         {
            return 0;
         }
         if(!param4 && _loc6_ == 0)
         {
            _loc5_++;
         }
         do
         {
            _loc5_++;
            _loc6_ = param1.indexOf(param2,_loc6_) + 1;
         }
         while(param1.indexOf(param2,_loc6_) != 0);
         
         if(param3 && param1.lastIndexOf(param2) == param1.length - param2.length)
         {
            _loc5_--;
         }
         return _loc5_;
      }
   }
}

