package com.midasplayer.text
{
   public class I18n
   {
      private static var m_strings:Object;
      
      public function I18n()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         m_strings = new Object();
         addStrings(param1);
      }
      
      public static function addStrings(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            m_strings[_loc2_] = param1[_loc2_];
         }
      }
      
      public static function getString(param1:String, ... args) : String
      {
         var str:String = null;
         var _loc_4:int = 0;
         var _loc_5:RegExp = null;
         if(!m_strings)
         {
            return "{" + param1 + "}";
         }
         if(m_strings[param1] != undefined)
         {
            str = m_strings[param1];
            if(args.length > 0)
            {
               _loc_4 = 0;
               while(_loc_4 < args.length)
               {
                  _loc_5 = new RegExp("\\{" + _loc_4 + "\\}","gi");
                  str = str.replace(_loc_5,args[_loc_4]);
                  _loc_4++;
               }
            }
            return str;
         }
         return "{" + param1 + "}";
      }
   }
}

