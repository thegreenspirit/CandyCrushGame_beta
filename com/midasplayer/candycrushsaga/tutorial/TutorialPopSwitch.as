package com.midasplayer.candycrushsaga.tutorial
{
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.event.*;
   import com.midasplayer.candycrushsaga.main.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   
   public class TutorialPopSwitch extends TutorialPop
   {
      private var _ccMain:CCMain;
      
      private var _hintCandies:Vector.<Point>;
      
      private var _hintMask:MovieClip;
      
      private var _locked:Boolean;
      
      private var _swapDirection:String;
      
      public function TutorialPopSwitch(param1:Point, param2:String, param3:MovieClip, param4:TutorialManModVO, param5:String, param6:Vector.<Point>, param7:CCMain, param8:Boolean)
      {
         this._ccMain = param7;
         this._swapDirection = param5;
         this._hintCandies = param6;
         this._locked = param8;
         super(param1,param2,param3,param4);
      }
      
      override protected function setUpClip() : void
      {
         super.setUpClip();
         _mcArrow.visible = false;
      }
      
      override public function triggerCommand() : void
      {
         var _loc_1:Point = null;
         super.triggerCommand();
         _darkLayer = DarkLayer.addDarkLayer(CCMain.mcDisplayTutorial);
         _darkLayer.blendMode = BlendMode.LAYER;
         this._hintMask = new MovieClip();
         if(this._hintCandies != null)
         {
            for each(_loc_1 in this._hintCandies)
            {
               this._hintMask.graphics.beginFill(0);
               this._hintMask.graphics.drawRect(104 + 36 + _loc_1.x * 71 - 71 / 2,17 + CCConstants.TOPNAV_HEIGHT + 63 * _loc_1.y,71,63);
            }
         }
         this._hintMask.graphics.endFill();
         this._hintMask.alpha = 0;
         this._hintMask.blendMode = BlendMode.ERASE;
         this._hintMask.filters = [new GlowFilter(0,1,10,10,5,BitmapFilterQuality.LOW)];
         TweenLite.to(this._hintMask,0.5,{"alpha":1});
         _darkLayer.addChild(this._hintMask);
         this._ccMain.getGame().addEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.switchHasBeenMade);
         if(this._locked == false)
         {
            _darkLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseClick);
         }
      }
      
      override protected function activate(event:TimerEvent) : void
      {
         super.activate(event);
         var _loc_2:* = new Vector.<Point>();
         _loc_2.push(this._hintCandies[0]);
         _loc_2.push(this._hintCandies[1]);
         this._ccMain.getGame().lockBoard(_loc_2);
      }
      
      private function onMouseClick(event:MouseEvent) : void
      {
         if(this._hintMask.hitTestPoint(this._hintMask.mouseX,this._hintMask.mouseY,true))
         {
            return;
         }
         this.prepareRemoval();
      }
      
      private function switchHasBeenMade(event:GameCommEvent) : void
      {
         this.prepareRemoval();
      }
      
      private function prepareRemoval() : void
      {
         this._ccMain.getGame().removeEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.switchHasBeenMade);
         _darkLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseClick);
         DarkLayer.removeDarkLayer(CCMain.mcDisplayPopup);
         TweenLite.to(this._hintMask,0.5,{"alpha":0});
         continueTutorial(null);
      }
      
      override public function deactivate() : void
      {
         this._ccMain.getGame().removeEventListener(GameCommEvent.SUCCESSFUL_SWITCH,this.switchHasBeenMade);
         if(Boolean(_darkLayer))
         {
            _darkLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseClick);
         }
         CCMain.mcDisplayTutorial.mouseEnabled = true;
         super.deactivate();
      }
      
      override public function destruct() : void
      {
         if(Boolean(this._hintMask))
         {
            this._hintMask.parent.removeChild(this._hintMask);
            this._hintMask = null;
         }
         DarkLayer.removeDarkLayer(CCMain.mcDisplayPopup);
         super.destruct();
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

