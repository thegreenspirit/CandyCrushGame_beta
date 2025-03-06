package com.midasplayer.candycrushsaga.ccshared.debugrender
{
   import flash.display.Graphics;
   
   public class DebugShape
   {
      private var _ttl:Number;
      
      private var _ttlOriginal:Number;
      
      public function DebugShape(param1:Number)
      {
         super();
         this._ttl = param1;
         this._ttlOriginal = param1;
      }
      
      public function update(param1:Number) : void
      {
         this._ttl = Math.max(0,this._ttl - param1);
      }
      
      public function render(param1:Graphics) : void
      {
      }
      
      public function isDone() : Boolean
      {
         return this._ttl == 0;
      }
   }
}

