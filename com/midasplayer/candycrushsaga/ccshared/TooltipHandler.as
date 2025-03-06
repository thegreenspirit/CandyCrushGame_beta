package com.midasplayer.candycrushsaga.ccshared
{
   import flash.display.*;
   
   public class TooltipHandler
   {
      private static var _tooltips:Vector.<Tooltip>;
      
      private static var _getTooltipClip:Function;
      
      private static var _displayBase:MovieClip;
      
      private static const USE_TOOLTIPS:Boolean = true;
      
      public static const TYPE_WORLD:String = "TYPE_WORLD";
      
      public static const TYPE_GAME:String = "TYPE_GAME";
      
      public static const TYPE_ALL:String = "TYPE_ALL";
      
      public function TooltipHandler(param1:MovieClip, param2:Function)
      {
         super();
         _tooltips = new Vector.<Tooltip>();
         _displayBase = param1;
         _getTooltipClip = param2;
      }
      
      public static function createToolTip(param1:MovieClip, param2:String, param3:String) : void
      {
         if(USE_TOOLTIPS == false)
         {
            return;
         }
         var _loc_4:* = new Tooltip(_displayBase,_getTooltipClip,param1,param2,param3);
         _tooltips.push(_loc_4);
      }
      
      public function removeTooltips(param1:String) : void
      {
         var _loc_3:Tooltip = null;
         var _loc_2:int = 0;
         while(_loc_2 < _tooltips.length)
         {
            _loc_3 = _tooltips[_loc_2];
            if(_loc_3.getType() == param1)
            {
               _tooltips.splice(_loc_2,1);
               _loc_3.destruct();
               _loc_3 = null;
               _loc_2 -= 1;
            }
            _loc_2++;
         }
      }
      
      public function removeAllTooltips() : void
      {
         var _loc_2:Tooltip = null;
         var _loc_1:int = 0;
         while(_loc_1 < _tooltips.length)
         {
            _loc_2 = _tooltips[_loc_1];
            _tooltips.splice(_loc_1,1);
            _loc_2.destruct();
            _loc_2 = null;
            _loc_1 -= 1;
            _loc_1++;
         }
      }
   }
}

