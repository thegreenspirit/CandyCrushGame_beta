package com.midasplayer.candycrushsaga.engine
{
   public class ScoreFormatter
   {
      public function ScoreFormatter()
      {
         super();
      }
      
      public static function format(param1:int) : String
      {
         var _loc_4:String = null;
         var _loc_5:String = null;
         var _loc_3:* = String(param1);
         if(param1 > 999)
         {
            _loc_4 = _loc_3.substr(0,_loc_3.length - 3);
            _loc_5 = _loc_3.substr(_loc_3.length - 3);
            _loc_3 = _loc_4 + " " + _loc_5;
         }
         if(param1 > 999999)
         {
            _loc_4 = _loc_3.substr(0,_loc_3.length - 7);
            _loc_5 = _loc_3.substr(_loc_3.length - 7);
            _loc_3 = _loc_4 + " " + _loc_5;
         }
         return _loc_3;
      }
   }
}

