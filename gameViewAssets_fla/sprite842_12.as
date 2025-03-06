package gameViewAssets_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite842_12 extends MovieClip
   {
      public var star_red1:sprite841_14;
      
      public function sprite842_12()
      {
         super();
		 this.star_red1.stop();
         addFrameScript(0,this.frame1,74,this.frame75);
      }
      
      internal function frame1() : *
      {
		 this.star_red1.play();
      }
      
      internal function frame75() : *
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

