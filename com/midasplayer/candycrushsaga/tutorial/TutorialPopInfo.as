package com.midasplayer.candycrushsaga.tutorial
{
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import tutorial.*;
   
   public class TutorialPopInfo extends TutorialPop
   {
      private var _mcFokusMask:MovieClip;
      
      private var _maskScale:Number;
      
      private var _focusClickFunc:Function;
      
      private var _manPointing:Boolean;
      
      public function TutorialPopInfo(param1:Point, param2:String, param3:MovieClip, param4:TutorialManModVO, param5:Number, param6:Function = null, param7:Boolean = true)
      {
         this._maskScale = param5;
         this._focusClickFunc = param6;
         this._manPointing = param7;
         super(param1,param2,param3,param4);
      }
      
      override protected function setUpClip() : void
      {
         super.setUpClip();
         this._mcFokusMask = new FocusMask();
         var _loc_1:* = this._maskScale;
         this._mcFokusMask.scaleY = this._maskScale;
         this._mcFokusMask.scaleX = _loc_1;
         if(this._manPointing == false)
         {
            _mcArm.visible = false;
            this._mcFokusMask.visible = false;
         }
         this.setUpSkipButton();
      }
      
      private function setUpSkipButton() : void
      {
         var _loc_1:* = _mcArrow.width;
         _mcArrow.tSkip.text = I18n.getString("tutorial_button_skip");
         _mcArrow.tSkip.autoSize = TextFieldAutoSize.LEFT;
         _mcArrow.alpha = 0;
         _mcArrow.iBG.width = _loc_1 + _mcArrow.tSkip.width - 70;
         TextUtil.scaleToFit(_mcArrow.tSkip);
      }
      
      override protected function correctBubblePos() : void
      {
         super.correctBubblePos();
         this.positionArrow();
      }
      
      private function positionArrow() : void
      {
         if(_spawnSide == TutorialPop.SPAWN_SIDE_RIGHT)
         {
            _mcArrow.x = _mcBubble.width - 115;
         }
         else
         {
            _mcArrow.x = _mcBubble.width - 35;
         }
         _mcArrow.y = _mcBubble.height - 20;
         _mcArrow.parent.addChild(_mcArrow);
      }
      
      override public function triggerCommand() : void
      {
         _darkLayer = DarkLayer.addDarkLayer(CCMain.mcDisplayTutorial);
         _darkLayer.blendMode = BlendMode.LAYER;
         _darkLayer.addChild(this._mcFokusMask);
         this._mcFokusMask.x = _point.x;
         this._mcFokusMask.y = _point.y;
         this._mcFokusMask.alpha = 0;
         CCMain.mcDisplayTutorial.mouseEnabled = false;
         _mcHead.mouseEnabled = false;
         _mcHead.mouseChildren = false;
         _mcArm.mouseEnabled = false;
         _mcArm.mouseChildren = false;
         _mcBubble.mouseEnabled = false;
         _mcBubble.mouseChildren = true;
         _mcArrow.mouseEnabled = true;
         _mcArrow.mouseChildren = false;
         _mcArrow.buttonMode = true;
         TweenLite.to(_mcArrow,1,{
            "alpha":1,
            "delay":2
         });
         TweenLite.to(this._mcFokusMask,1,{
            "alpha":1,
            "delay":0.5
         });
         super.triggerCommand();
      }
      
      override protected function activate(event:TimerEvent) : void
      {
         super.activate(event);
         _darkLayer.addEventListener(MouseEvent.CLICK,this.continueTutorial);
         _mcClip.addEventListener(MouseEvent.CLICK,this.continueTutorial);
         if(this._focusClickFunc != null)
         {
            this._mcFokusMask.addEventListener(MouseEvent.CLICK,this.onFocusClick);
            this._mcFokusMask.buttonMode = true;
         }
      }
      
      private function onFocusClick(event:MouseEvent) : void
      {
         this._focusClickFunc();
         this.continueTutorial(null);
      }
      
      override public function continueTutorial(event:MouseEvent) : void
      {
         _darkLayer.removeEventListener(MouseEvent.CLICK,this.continueTutorial);
         _mcClip.removeEventListener(MouseEvent.CLICK,this.continueTutorial);
         if(this._focusClickFunc != null)
         {
            this._mcFokusMask.removeEventListener(MouseEvent.CLICK,this.onFocusClick);
            this._mcFokusMask.buttonMode = false;
         }
         TweenLite.to(this._mcFokusMask,1,{"alpha":0});
         TweenLite.to(_mcArrow,0.5,{"alpha":0});
         super.continueTutorial(event);
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK);
      }
      
      override public function deactivate() : void
      {
         if(Boolean(_darkLayer))
         {
            _darkLayer.removeEventListener(MouseEvent.CLICK,this.continueTutorial);
         }
         if(Boolean(_mcClip))
         {
            _mcClip.removeEventListener(MouseEvent.CLICK,this.continueTutorial);
         }
         CCMain.mcDisplayTutorial.mouseEnabled = true;
         super.deactivate();
      }
      
      override public function destruct() : void
      {
         if(Boolean(_darkLayer))
         {
            _darkLayer.removeChild(this._mcFokusMask);
         }
         if(Boolean(this._mcFokusMask))
         {
            this._mcFokusMask = null;
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

