package gameViewAssets_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite844_15 extends MovieClip
   {
      public var star_red3:sprite841_14;
      public var star_yellow3:sprite841_14;
      public var star_cyan3:sprite841_14;
      
      public function sprite844_15()
      {
         super();
		 this.star_red3.stop();
		 this.star_yellow3.stop();
		 this.star_cyan3.stop();
         addFrameScript(14,this.frame15,25,this.frame26,36,this.frame37,74,this.frame75);
      }
      
      internal function frame15() : *
      {
		 this.star_red3.play();
      }
      
      internal function frame26() : *
      {
		 this.star_yellow3.play();
      }
      
      internal function frame37() : *
      {
		 this.star_cyan3.play();
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

