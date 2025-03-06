package balance
{
   import flash.display.MovieClip;
   
   public dynamic class PopBoosterButtonClip extends MovieClip
   {
      public var iAmount:MovieClip;
      
      public var iBG:BoosterButtonBGBig;
      
      public var iSymbolContainer:MovieClip;
      
      public function PopBoosterButtonClip()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

