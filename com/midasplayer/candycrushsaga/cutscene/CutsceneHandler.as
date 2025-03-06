package com.midasplayer.candycrushsaga.cutscene
{
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   import flash.events.*;
   
   public class CutsceneHandler extends EventDispatcher
   {
      public var currentCutsceneBytesLoaded:int;
      
      private var _cutsceneFactory:CutsceneFactory;
      
      private var _displayBase:MovieClip;
      
      private var _getSwfUrl:Function;
      
      private var _snappedFrameIndexes:Array;
      
      private var _callBack:Function;
      
      private var pathTracker:PathTracker;
      
      public function CutsceneHandler(param1:MovieClip, param2:Function)
      {
         super();
         this.pathTracker = new PathTracker("CutsceneHandler");
         this._displayBase = param1;
         this._getSwfUrl = param2;
         this._snappedFrameIndexes = new Array();
      }
      
      public function getCutsceneStory(param1:int) : String
      {
         if(param1 == 1)
         {
            return CutsceneConstants.STORY_GIRL;
         }
         if(param1 == 2)
         {
            return CutsceneConstants.STORY_ROBOT;
         }
         if(param1 == 3)
         {
            return CutsceneConstants.STORY_DRAGON;
         }
         if(param1 == 4)
         {
            return CutsceneConstants.STORY_YETI;
         }
         if(param1 == 5)
         {
            return CutsceneConstants.STORY_UNICORN;
         }
         if(param1 == 6)
         {
            return CutsceneConstants.STORY_BUNNY;
         }
         if(param1 == 7)
         {
            return CutsceneConstants.STORY_TROLL;
         }
         if(param1 == 8)
         {
            return CutsceneConstants.STORY_SPACE;
         }
         if(param1 == 9) // this wasn't here for some reason, despite episode 9 being present?
         {
            return CutsceneConstants.STORY_SULTAN;
         }
         Console.println("Could not find required story for episode " + param1);
         return "";
      }
      
      public function loadCutscene(param1:int, param2:String, param3:String, param4:Boolean, param5:Function = null) : void
      {
         if(param2 == "")
         {
            return;
         }
         Console.println("@ loadCutscene() - CutsceneHandler.as");
         this._callBack = param5;
         this._cutsceneFactory = new CutsceneFactory(param2,param3,this._getSwfUrl,param4,this.pathTracker);
         this._cutsceneFactory.addEventListener(CutsceneFactory.CUTSCENE_LOAD_COMPLETED,this.onCutsceneLoaded);
         this._cutsceneFactory.addEventListener(CutsceneFactory.CUTSCENE_PROGRESS,this.onCutsceneProgress);
      }
      
      private function onCutsceneProgress(event:Event) : void
      {
         this.currentCutsceneBytesLoaded = this._cutsceneFactory.getBytesLoaded();
         dispatchEvent(new Event(CutsceneConstants.CUTSCENE_PROGRESS));
      }
      
      private function onCutsceneLoaded(event:Event) : void
      {
         this._cutsceneFactory.removeEventListener(CutsceneFactory.CUTSCENE_LOAD_COMPLETED,this.onCutsceneLoaded);
         dispatchEvent(new Event(CutsceneConstants.CUTSCENE_LOADED));
         if(this._callBack != null)
         {
            this._callBack();
         }
      }
      
      public function removeCutsceneSnapShot() : void
      {
         var mc:MovieClip = null;
         mc = this._displayBase.getChildByName("snapShot") as MovieClip;
         if(Boolean(mc))
         {
            mc.parent.addChild(mc);
            TweenLite.to(mc,1,{
               "alpha":0,
               "onComplete":function():void
               {
                  mc.parent.removeChild(mc);
                  mc = null;
               }
            });
         }
      }
      
      public function getFactory() : CutsceneFactory
      {
         return this._cutsceneFactory;
      }
      
      public function removeCutscene() : void
      {
         if(Boolean(this._cutsceneFactory))
         {
            this._cutsceneFactory.destruct();
            this._cutsceneFactory = null;
         }
      }
      
      public function addCutsceneSnapShot() : void
      {
         var _loc_1:MovieClip = null;
         if(Boolean(this._cutsceneFactory))
         {
            _loc_1 = this._cutsceneFactory.getCutsceneSnapShot();
            _loc_1.name = "snapShot";
            this._displayBase.addChild(_loc_1);
         }
      }
      
      public function setSnappedFrameIndexes() : void
      {
         var _loc_3:MovieClip = null;
         var _loc_4:Object = null;
         var _loc_2:uint = 0;
         this._snappedFrameIndexes = [];
         if(this._cutsceneFactory.getFollowUp() == false)
         {
            return;
         }
         var _loc_1:* = this._cutsceneFactory.getCutscene();
         while(_loc_2 < _loc_1.numChildren)
         {
            _loc_3 = _loc_1.getChildAt(_loc_2) as MovieClip;
            if(Boolean(_loc_3))
            {
               if(_loc_3.currentFrame != 1)
               {
                  _loc_4 = new Object();
                  _loc_4.name = _loc_3.name;
                  _loc_4.frame = _loc_3.currentFrame;
                  this._snappedFrameIndexes.push(_loc_4);
               }
            }
            _loc_2 += 1;
         }
      }
      
      public function getSnappedFrameIndexes() : Array
      {
         return this._snappedFrameIndexes;
      }
   }
}

import flash.events.EventDispatcher;

