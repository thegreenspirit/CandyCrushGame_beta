package mx.utils
{
   public class StringUtil
   {
      internal static const VERSION:String = "4.6.0.23201";
      
      public function StringUtil()
      {
         super();
      }
      
      public static function trim(param1:String) : String
      {
         var _loc_2:int = 0;
         if(param1 == null)
         {
            return "";
         }
         while(isWhitespace(param1.charAt(_loc_2)))
         {
            _loc_2++;
         }
         var _loc_3:* = param1.length - 1;
         while(isWhitespace(param1.charAt(_loc_3)))
         {
            _loc_3 -= 1;
         }
         if(_loc_3 >= _loc_2)
         {
            return param1.slice(_loc_2,_loc_3 + 1);
         }
         return "";
      }
      
      public static function trimArrayElements(param1:String, param2:String) : String
      {
         var _loc_3:Array = null;
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         if(param1 != "" && param1 != null)
         {
            _loc_3 = param1.split(param2);
            _loc_4 = int(_loc_3.length);
            _loc_5 = 0;
            while(_loc_5 < _loc_4)
            {
               _loc_3[_loc_5] = StringUtil.trim(_loc_3[_loc_5]);
               _loc_5++;
            }
            if(_loc_4 > 0)
            {
               param1 = _loc_3.join(param2);
            }
         }
         return param1;
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
            default:
               return false;
         }
      }
      
      public static function substitute(param1:String, ... args) : String
      {
         var _loc_4:Array = null;
         var _loc_5:int = 0;
         if(param1 == null)
         {
            return "";
         }
         var arg:int = int(args.length);
         if(arg == 1 && args[0] is Array)
         {
            _loc_4 = args[0] as Array;
            arg = int(_loc_4.length);
         }
         else
         {
            _loc_4 = args;
         }
         while(_loc_5 < arg)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc_5 + "\\}","g"),_loc_4[_loc_5]);
            _loc_5++;
         }
         return param1;
      }
      
      public static function repeat(param1:String, param2:int) : String
      {
         if(param2 == 0)
         {
            return "";
         }
         var _loc_3:* = param1;
         var _loc_4:int = 1;
         while(_loc_4 < param2)
         {
            _loc_3 += param1;
            _loc_4++;
         }
         return _loc_3;
      }
      
      public static function restrict(param1:String, param2:String) : String
      {
         var _loc_6:uint = 0;
         var _loc_5:int = 0;
         if(param2 == null)
         {
            return param1;
         }
         if(param2 == "")
         {
            return "";
         }
         var _loc_3:Array = [];
         var _loc_4:* = param1.length;
         while(_loc_5 < _loc_4)
         {
            _loc_6 = uint(param1.charCodeAt(_loc_5));
            if(testCharacter(_loc_6,param2))
            {
               _loc_3.push(_loc_6);
            }
            _loc_5++;
         }
         return String.fromCharCode.apply(null,_loc_3);
      }
      
      private static function testCharacter(param1:uint, param2:String) : Boolean
      {
         var _loc_9:uint = 0;
         var _loc_11:Boolean = false;
         var _loc_3:Boolean = false;
         var _loc_4:Boolean = false;
         var _loc_5:Boolean = false;
         var _loc_7:uint = 0;
         var _loc_10:int = 0;
         var _loc_6:Boolean = true;
         var _loc_8:* = param2.length;
         if(param2.length > 0)
         {
            _loc_9 = uint(param2.charCodeAt(0));
            if(_loc_9 == 94)
            {
               _loc_3 = true;
            }
         }
         while(_loc_10 < _loc_8)
         {
            _loc_9 = uint(param2.charCodeAt(_loc_10));
            _loc_11 = false;
            if(!_loc_4)
            {
               if(_loc_9 == 45)
               {
                  _loc_5 = true;
               }
               else if(_loc_9 == 94)
               {
                  _loc_6 = !_loc_6;
               }
               else if(_loc_9 == 92)
               {
                  _loc_4 = true;
               }
               else
               {
                  _loc_11 = true;
               }
            }
            else
            {
               _loc_11 = true;
               _loc_4 = false;
            }
            if(_loc_11)
            {
               if(_loc_5)
               {
                  if(_loc_7 <= param1 && param1 <= _loc_9)
                  {
                     _loc_3 = _loc_6;
                  }
                  _loc_5 = false;
                  _loc_7 = 0;
               }
               else
               {
                  if(param1 == _loc_9)
                  {
                     _loc_3 = _loc_6;
                  }
                  _loc_7 = _loc_9;
               }
            }
            _loc_10++;
         }
         return _loc_3;
      }
   }
}

