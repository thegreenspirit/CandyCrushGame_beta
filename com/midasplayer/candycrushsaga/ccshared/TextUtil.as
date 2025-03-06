package com.midasplayer.candycrushsaga.ccshared
{
   import com.midasplayer.util.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class TextUtil
   {
      public function TextUtil()
      {
         super();
      }
      
      public static function scaleToFit(param1:TextField, param2:String = null, param3:int = 0, param4:int = -1, param5:int = -1, param6:int = 8) : int
      {
         var _loc_17:Rectangle = null;
         var _loc_7:* = param1.getTextFormat(param4,param5);
         var _loc_8:* = Boolean(param1.getTextFormat(param4,param5).size) ? int(_loc_7.size) : 12;
         var _loc_9:* = Boolean(param1.getTextFormat(param4,param5).size) ? int(_loc_7.size) : 12;
         if(Boolean(param2))
         {
            if(param4 == -1)
            {
               param4 = 0;
            }
            if(param5 == -1)
            {
               param5 = param1.length;
            }
            param1.replaceText(param4,param5,param2);
            param5 = param4 + param2.length;
            param1.setTextFormat(_loc_7,param4,param5);
         }
         var _loc_10:* = param1.rotation;
         var _loc_11:* = param1.rotationX;
         var _loc_12:* = param1.rotationY;
         var _loc_13:* = param1.rotationZ;
         var _loc_14:* = param1.transform.matrix;
         param1.rotation = 0;
         param1.rotationX = 0;
         param1.rotationY = 0;
         param1.rotationZ = 0;
         param1.transform.matrix = null;
         var _loc_15:* = getTextRect(param1);
         if(param1.wordWrap)
         {
            while(--_loc_8 > param6 && param1.textHeight > _loc_15.height)
            {
               _loc_7.size = _loc_8 - 1;
               param1.setTextFormat(_loc_7,param4,param5);
            }
         }
         else
         {
            while(--_loc_8 > param6 && (param1.textWidth > _loc_15.width || param1.textHeight > _loc_15.height))
            {
               _loc_7.size = _loc_8 - 1;
               param1.setTextFormat(_loc_7,param4,param5);
            }
         }
         var _loc_16:Number = 0;
         switch(param3)
         {
            case TextFieldReposition.BOTTOM:
               _loc_17 = getTextRect(param1);
               _loc_16 = _loc_15.height - _loc_17.height;
               break;
            case TextFieldReposition.CENTER:
               _loc_17 = getTextRect(param1);
               _loc_16 = 0.5 * (_loc_15.height - _loc_17.height);
         }
         if(_loc_16 != 0)
         {
            if(param1.rotationZ == 0)
            {
               param1.y = Math.floor(param1.y + _loc_16);
            }
            else
            {
               param1.x += _loc_16 * -Math.sin(param1.rotationZ * Math.PI / 180);
               param1.y += _loc_16 * Math.cos(param1.rotationZ * Math.PI / 180);
            }
         }
         param1.rotation = _loc_10;
         param1.rotationX = _loc_11;
         param1.rotationY = _loc_12;
         param1.rotationZ = _loc_13;
         param1.transform.matrix = _loc_14;
         return _loc_9 - _loc_8;
      }
      
      public static function getTextRect(param1:TextField) : Rectangle
      {
         var _loc_2:* = param1.getTextFormat();
         var _loc_3:* = StringUtils.countOccurrence(param1.text,"\r");
         var _loc_4:* = param1.numLines == _loc_3 + 1;
         var _loc_5:* = new Rectangle(2 + (Boolean(_loc_2.leftMargin) ? int(_loc_2.leftMargin) : 0) + (Boolean(_loc_2.rightMargin) ? int(_loc_2.rightMargin) : 0) + (Boolean(_loc_2.blockIndent) ? int(_loc_2.blockIndent) : 0) + (Boolean(_loc_2.indent) && _loc_4 ? int(_loc_2.indent) : 0),2,param1.textWidth + (_loc_2.indent && !_loc_4 && _loc_3 > 0 ? int(_loc_2.indent) : 0),param1.textHeight - (Boolean(_loc_2.leading) ? int(_loc_2.leading) : 0));
         _loc_5.width = Math.min(_loc_5.width,param1.width - 2 - _loc_5.x);
         _loc_5.height = Math.min(_loc_5.height,param1.height - 2 - _loc_5.y);
         return _loc_5;
      }
   }
}

