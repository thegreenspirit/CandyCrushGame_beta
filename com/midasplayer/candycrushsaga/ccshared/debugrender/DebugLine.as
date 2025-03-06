package com.midasplayer.candycrushsaga.ccshared.debugrender
{
   import flash.display.Graphics;
   import flash.geom.Vector3D;
   
   public class DebugLine extends DebugShape
   {
      private var _startPoint:Vector3D;
      
      private var _endPoint:Vector3D;
      
      private var _thickness:Number;
      
      private var _color:uint;
      
      private var _alpha:Number;
      
      public function DebugLine(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:Number, param7:uint, param8:Number)
      {
         super(param6);
         this._startPoint = new Vector3D(param1,param2);
         this._endPoint = new Vector3D(param3,param4);
         this._thickness = param5;
         this._color = param7;
         this._alpha = param8;
      }
      
      override public function render(param1:Graphics) : void
      {
         param1.lineStyle(this._thickness,this._color,this._alpha);
         param1.moveTo(this._startPoint.x,this._startPoint.y);
         param1.lineTo(this._endPoint.x,this._endPoint.y);
      }
   }
}

