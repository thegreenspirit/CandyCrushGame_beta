package com.flashdynamix.motion.plugins
{
   import com.flashdynamix.motion.*;
   import com.flashdynamix.utils.*;
   import flash.display.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.utils.*;
   
   public class TweensyPluginList
   {
      private static var pool:MultiTypeObjectPool;
      
      private static var list:Array;
      
      private static var map:Dictionary;
      
      internal static var inited:Boolean = init();
      
      public function TweensyPluginList()
      {
         super();
      }
      
      private static function init() : Boolean
      {
         if(inited)
         {
            return true;
         }
         list = [];
         map = new Dictionary(true);
         pool = new MultiTypeObjectPool();
         add(MovieClip,MovieClipTween);
         add(DisplayObject,DisplayTween);
         add(ColorTransform,ColorTween);
         add(BitmapFilter,FilterTween);
         add(Matrix,MatrixTween);
         add(SoundTransform,SoundTween);
         add(Object,ObjectTween);
         FilterTween.filters = TweensyGroup.filters;
         return true;
      }
      
      public static function add(param1:Class, param2:Class) : void
      {
         list.push(param1);
         map[param1] = param2;
         pool.add(param2);
      }
      
      public static function checkOut(param1:Object) : AbstractTween
      {
         var _loc_2:int = 0;
         var _loc_4:Class = null;
         var _loc_3:* = list.length - 1;
         _loc_2 = 0;
         while(_loc_2 < _loc_3)
         {
            _loc_4 = list[_loc_2];
            if(param1 is _loc_4)
            {
               return pool.checkOut(map[_loc_4]);
            }
            _loc_2++;
         }
         return pool.checkOut(map[list[_loc_3]]);
      }
      
      public static function checkIn(param1:Object) : void
      {
         pool.checkIn(param1);
      }
      
      public static function empty() : void
      {
         pool.empty();
      }
   }
}

