package com.midasplayer.candycrushsaga.ccshared.debugrender
{
   import flash.display.Graphics;
   import flash.geom.Vector3D;
   
   public class DebugCircle extends DebugShape
   {
      private var _position:Vector3D;
      
      private var _radius:Number;
      
      private var _color:uint;
      
      private var _alpha:Number;
      
      public function DebugCircle(param1:int, param2:int, param3:Number, param4:Number, param5:uint, param6:Number)
      {
         super(param4);
         this._position = new Vector3D(param1,param2);
         this._radius = param3;
         this._color = param5;
         this._alpha = param6;
      }
      
      override public function render(param1:Graphics) : void
      {
         param1.lineStyle(0);
         param1.beginFill(this._color,this._alpha);
         param1.drawCircle(this._position.x,this._position.y,this._radius);
         param1.endFill();
      }
   }
}

