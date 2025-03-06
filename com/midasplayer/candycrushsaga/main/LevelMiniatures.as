package com.midasplayer.candycrushsaga.main
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import main.level_miniature_frame;
   
   public class LevelMiniatures
   {
      private var _imagesUrlMap:Object;
      
      private var _episodeLevelCounterFunc:Function;
      
      public function LevelMiniatures(param1:Object, param2:Function)
      {
         super();
         this._imagesUrlMap = param1;
         this._episodeLevelCounterFunc = param2;
      }
      
      public function getMiniature(param1:int, param2:int) : MovieClip
      {
         var _loc_3:int = 0;
         var _loc_4:int = 1;
         while(_loc_4 < param1)
         {
            _loc_3 += this._episodeLevelCounterFunc(_loc_4);
            _loc_4++;
         }
         _loc_3 += param2;
         return this._loadMiniature(_loc_3);
      }
      
      private function _loadMiniature(param1:int) : MovieClip
      {
         var pic:*;
         var miniature:level_miniature_frame = null;
         var context:LoaderContext = null;
         var url:String = null;
         var levelNumber:* = param1;
         miniature = new level_miniature_frame();
         miniature.mouseChildren = false;
         miniature.mouseEnabled = false;
         pic = new Loader();
         try
         {
            pic.contentLoaderInfo.addEventListener(Event.COMPLETE,this._onLoadComplete);
            pic.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void
            {
               Console.println("LevelMiniatures -> IOErrorEvent: " + event.toString());
            });
            context = new LoaderContext();
            context.checkPolicyFile = true;
            url = this._imagesUrlMap["/images/levels/" + String(levelNumber) + ".png"];
            if(Boolean(url))
            {
               pic.load(new URLRequest(url),context);
            }
            miniature.gotoAndStop(2);
            miniature.text_level_number.text = I18n.getString("map_level_miniature_level",levelNumber);
            miniature.text_level_number.setTextFormat(LocalConstants.FORMAT("CCS_bananaSplit"));
            miniature.text_level_number.embedFonts = false;
            miniature.miniature_container.addChild(pic);
            TextUtil.scaleToFit(miniature.text_level_number);
         }
         catch(e:Error)
         {
            Console.println("LevelMiniatures -> Error: " + e.message);
            return miniature;
         }
         return miniature;
      }
      
      private function _onLoadComplete(e:Event) : void
      {
         var image:Bitmap = null;
         var event:Event = e;
         var loaderInfo:* = LoaderInfo(event.target);
         loaderInfo.removeEventListener(Event.COMPLETE,this._onLoadComplete);
         try
         {
            image = Bitmap(loaderInfo.loader.content);
            image.smoothing = true;
            image.x = -int(image.width * 0.5) - 2;
            image.y = -int(image.height * 0.5) - 1;
         }
         catch(e:SecurityError)
         {
            Console.println("LevelMiniatures -> SecurityError: " + e.message);
         }
      }
   }
}

