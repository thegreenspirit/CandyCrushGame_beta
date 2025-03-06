package popup
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class GameStartContent extends MovieClip
   {
      public var iGameMode:MovieClip;
      
      public var tLevel:TextField;
      
      public var tSelectBoosters:TextField;
      
      public var iButtonPlay:ButtonDefault;
      
      public var iBG:BackgroundMedium;
      
      public var iTarget:MovieClip;
      
      public var tHighestScoreNum:TextField;
      
      public var tHighestScoreText:TextField;
      
      public var tMessage:TextField;
      
      public function GameStartContent()
      {
         super();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

