package com.midasplayer.candycrushsaga.ccshared.debugrender
{
   import flash.display.Graphics;
   import flash.geom.Vector3D;
   
   public class DebugPoint extends DebugShape
   {
      private var _position:Vector3D;
      
      private var _color:uint;
      
      private var _alpha:Number;
      
      public function DebugPoint(param1:int, param2:int, param3:Number, param4:uint, param5:Number)
      {
         super(param3);
         this._position = new Vector3D(param1,param2);
         this._color = param4;
         this._alpha = param5;
      }
      
      override public function render(param1:Graphics) : void
      {
         param1.lineStyle(0);
         param1.beginFill(this._color,this._alpha);
         param1.drawCircle(this._position.x,this._position.y,3);
         param1.endFill();
      }
   }
}

