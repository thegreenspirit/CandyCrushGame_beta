package com.midasplayer.candycrushsaga.ccshared
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import main.*;
   
   public class HourGlass extends MovieClip
   {
      private static const _LOAD_COMPLETE:Boolean = true;
      
      private var _container:MovieClip;
      
      private var _loadingProcesses:Array;
      
      private var _pic:MovieClip;
      
      public function HourGlass(param1:MovieClip)
      {
         super();
         this._loadingProcesses = new Array();
         this._pic = new LoadingIcon();
         this._container = param1;
         this._pic.x = CCConstants.STAGE_WIDTH / 2;
         this._pic.y = CCConstants.STAGE_HEIGHT / 2;
      }
      
      public function setUp(param1:Function, param2:Function = null, args:Object = null) : void
      {
         if(this._loadingProcesses.length == 0)
         {
            this._container.addChild(this._pic);
            DarkLayer.addDarkLayer(this._pic);
            this.addEventListener(Event.ENTER_FRAME,this.checkStatus);
         }
         var _args:* = new Object();
         _args.getStatusFunc = param1;
         _args.callBack = param2;
         _args.data = args;
         this._loadingProcesses.push(_args);
      }
      
      private function checkStatus(event:Event) : void
      {
         var _loc_2:* = this._loadingProcesses[0];
         if(_loc_2.getStatusFunc() == _LOAD_COMPLETE)
         {
            if(Boolean(_loc_2.callBack))
            {
               _loc_2.callBack.apply(this,_loc_2.data);
            }
            this._loadingProcesses.splice(0,1);
            _loc_2 = null;
         }
         if(this._loadingProcesses.length == 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.checkStatus);
            TweenLite.to(this._pic,1,{
               "alpha":0,
               "onComplete":this.removeHourGlass
            });
         }
      }
      
      private function removeHourGlass() : void
      {
         DarkLayer.removeDarkLayer(this._pic);
         this._container.removeChild(this._pic);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

