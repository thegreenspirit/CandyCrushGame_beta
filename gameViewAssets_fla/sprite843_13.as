package gameViewAssets_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite843_13 extends MovieClip
   {
      public var star_red2:sprite841_14;
      public var star_cyan2:sprite841_14;
      
      public function sprite843_13()
      {
         super();
		 this.star_red2.stop();
		 this.star_cyan2.stop();
         addFrameScript(14,this.frame15,25,this.frame26,74,this.frame75);
      }
      
      internal function frame15() : *
      {
		 this.star_red2.play();
      }
      
      internal function frame26() : *
      {
		 this.star_cyan2.play();
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

