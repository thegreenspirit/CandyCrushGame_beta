package com.midasplayer.candycrushsaga.ccshared
{
   import flash.geom.Point;
   
   public class Hint
   {
      public static const DIRECTION_LEFT:String = "direction_left";
      
      public static const DIRECTION_RIGHT:String = "direction_right";
      
      public static const DIRECTION_UP:String = "direction_up";
      
      public static const DIRECTION_DOWN:String = "direction_down";
      
      public var mainCoord:Point;
      
      public var swapDirection:Point;
      
      public var coordsInvolved:Vector.<Point>;
      
      public var swapBuddy:Point;
      
      public function Hint(param1:Point, param2:Point, param3:Point, param4:Vector.<Point>)
      {
         super();
         this.mainCoord = param2;
         this.swapDirection = param3;
         this.coordsInvolved = param4;
         this.swapBuddy = this.getSwapBuddy(param1);
         param4.splice(1,0,this.swapBuddy);
      }
      
      private function getSwapBuddy(param1:Point) : Point
      {
         return new Point(param1.x + this.swapDirection.x,param1.y + this.swapDirection.y);
      }
      
      public function getDirectionString() : String
      {
         if(this.swapDirection.x == 0 && this.swapDirection.y == -1)
         {
            return DIRECTION_UP;
         }
         if(this.swapDirection.x == 0 && this.swapDirection.y == 1)
         {
            return DIRECTION_DOWN;
         }
         if(this.swapDirection.x == -1 && this.swapDirection.y == 0)
         {
            return DIRECTION_LEFT;
         }
         if(this.swapDirection.x == 1 && this.swapDirection.y == 0)
         {
            return DIRECTION_RIGHT;
         }
         return null;
      }
   }
}

