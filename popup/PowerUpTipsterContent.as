package popup
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class PowerUpTipsterContent extends MovieClip
   {
      public var iAmount:MovieClip;
      
      public var tItemName:TextField;
      
      public var iButtonBuy:ButtonDefault;
      
      public var iItemPic:MovieClip;
      
      public var tTitle:TextField;
      
      public var tDesc:TextField;
      
      public var iBG:BackgroundMedium;
      
      public var iCost:MovieClip;
      
      public var tMessage:TextField;
      
      public function PowerUpTipsterContent()
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

