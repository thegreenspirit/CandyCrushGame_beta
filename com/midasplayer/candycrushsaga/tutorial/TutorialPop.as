package com.midasplayer.candycrushsaga.tutorial
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   import flash.utils.*;
   import tutorial.*;
   
   public class TutorialPop extends MovieClip implements ICCQueueElement
   {
      public static const ARM_TYPE_CROOKED:String = "crooked";
      
      public static const ARM_TYPE_STRAIGHT:String = "straight";
      
      public static const SPAWN_SIDE_LEFT:String = "left";
      
      public static const SPAWN_SIDE_RIGHT:String = "right";
      
      public static const ROW_SPACE:int = 10;
      
      public static const EVENT_REMOVE:String = "eventRemove";
      
      protected var _spawnSide:String;
      
      protected var _armType:String;
      
      protected var _armOrigX:int;
      
      protected var _headOrigX:int;
      
      protected var _bubbleOrigY:int;
      
      protected var _bubbleOrigH:int;
      
      protected var _skipButtonOriginalW:int;
      
      protected var _mcClip:MovieClip;
      
      protected var _mcArm:MovieClip;
      
      protected var _mcHead:MovieClip;
      
      protected var _mcBubble:MovieClip;
      
      protected var _mcArrow:MovieClip;
      
      protected var _image:MovieClip;
      
      protected var _darkLayer:MovieClip;
      
      protected var _skipButton:MovieClip;
      
      protected var _dialogue:String;
      
      protected var _point:Point;
      
      protected var _manMod:TutorialManModVO;
      
      public function TutorialPop(param1:Point, param2:String, param3:MovieClip, param4:TutorialManModVO)
      {
         super();
         this._point = param1;
         this._dialogue = param2;
         this._image = param3;
         this._manMod = param4;
         this._skipButton = new SkipButton();
         this.setUpClip();
      }
      
      protected function setUpClip() : void
      {
         var _loc_4:* = undefined;
         this._mcClip = new TutorialClip();
         this._mcClip.x = this._point.x;
         this._mcClip.y = this._point.y;
         var _loc_1:* = CCConstants.STAGE_WIDTH / 2;
         this._spawnSide = this._point.x > _loc_1 ? TutorialPop.SPAWN_SIDE_LEFT : (_loc_4 = TutorialPop.SPAWN_SIDE_RIGHT, this._spawnSide = TutorialPop.SPAWN_SIDE_RIGHT, _loc_4);
         this._mcClip.gotoAndStop(this._spawnSide);
         this._armType = this._point.y > 200 ? TutorialPop.ARM_TYPE_STRAIGHT : TutorialPop.ARM_TYPE_CROOKED;
         this._mcClip.iAll.gotoAndStop(this._armType);
         var _loc_2:* = Math.max(this._point.x,Math.abs(CCConstants.STAGE_WIDTH - this._point.x));
         var _loc_3:* = Math.round(_loc_2 / 10);
         this._mcClip.iAll.iElements.gotoAndStop(_loc_3);
         this._mcArrow = this._mcClip.iAll.iElements.iBubble.iSkip;
         this._mcArm = this._mcClip.iAll.iElements.iArm;
         this._mcHead = this._mcClip.iAll.iElements.iHead;
         this._mcBubble = this._mcClip.iAll.iElements.iBubble;
         this.addBubbleContent();
         this._armOrigX = this._mcArm.x;
         this._headOrigX = this._mcHead.x;
         this._bubbleOrigY = this._mcBubble.y;
         this._mcArm.x = this.getPosOutsideStage("iArm");
         this._mcHead.x = this.getPosOutsideStage("iHead");
         this._mcBubble.y = this.getPosOutsideStage("iBubble");
      }
      
      private function setUpSkipButton() : void
      {
         CCMain.mcDisplayTutorial.addChild(this._skipButton);
         this._skipButton.y = 600;
         this._skipButton.gotoAndStop("normal");
         this._skipButton.buttonMode = true;
         this._skipButton.mouseChildren = false;
         this._skipButtonOriginalW = this._skipButton.iBG.width;
         this._skipButton.tSkip.text = I18n.getString("cutscene_button_skip");
         this._skipButton.tSkip.setTextFormat(LocalConstants.FORMAT("Tahoma"));
         this._skipButton.tSkip.embedFonts = false;
         this._skipButton.tSkip.autoSize = TextFieldAutoSize.LEFT;
         this.resizeSkipButton();
         this._skipButton.addEventListener(MouseEvent.MOUSE_OVER,this.skipButtonOver);
         this._skipButton.addEventListener(MouseEvent.MOUSE_OUT,this.skipButtonOut);
         this._skipButton.addEventListener(MouseEvent.MOUSE_DOWN,this.skipButtonDown);
         this._skipButton.addEventListener(MouseEvent.MOUSE_UP,this.skipButtonUp);
         TextUtil.scaleToFit(this._skipButton.tSkip);
         this.resizeSkipButton();
      }
      
      private function modifyContent() : void
      {
         if(this._manMod != null)
         {
            this._mcArm.x += this._manMod.armModX;
            this._mcArm.y += this._manMod.armModY;
            this._mcArm.rotation += this._manMod.armModRotation;
            this._mcHead.x += this._manMod.headModX;
            this._mcHead.y += this._manMod.headModY;
            this._mcBubble.x += this._manMod.bubbleModX;
            this._mcBubble.y += this._manMod.bubbleModY;
         }
      }
      
      private function resizeSkipButton() : void
      {
         this._skipButton.iBG.width = this._skipButtonOriginalW + this._skipButton.tSkip.width - 60;
         this._skipButton.iArrows.x = this._skipButton.tSkip.x + this._skipButton.tSkip.width + 10;
         this._skipButton.x = CCConstants.STAGE_WIDTH - this._skipButton.width - 23;
      }
      
      private function skipButtonOver(event:MouseEvent) : void
      {
         this._skipButton.gotoAndStop("hovered");
         this.resizeSkipButton();
      }
      
      private function skipButtonOut(event:MouseEvent) : void
      {
         this._skipButton.gotoAndStop("normal");
         this.resizeSkipButton();
      }
      
      private function skipButtonDown(event:MouseEvent) : void
      {
         this._skipButton.gotoAndStop("pressed");
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK);
         this.resizeSkipButton();
      }
      
      private function skipButtonUp(event:MouseEvent) : void
      {
         TrackingTrail.track("TPSK");
         this.skipTutorial();
      }
      
      private function getPosOutsideStage(param1:String) : int
      {
         if(this._spawnSide == TutorialPop.SPAWN_SIDE_LEFT)
         {
            if(param1 == "iArm")
            {
               return this._armOrigX - (this._point.x + 35);
            }
            if(param1 == "iHead")
            {
               return this._headOrigX - this._point.x;
            }
         }
         else if(this._spawnSide == TutorialPop.SPAWN_SIDE_RIGHT)
         {
            if(param1 == "iArm")
            {
               return this._armOrigX + (CCConstants.STAGE_WIDTH - this._point.x + 35);
            }
            if(param1 == "iHead")
            {
               return this._headOrigX + (CCConstants.STAGE_WIDTH - this._point.x);
            }
         }
         return -this._point.y - this._mcBubble.height;
      }
      
      private function addBubbleContent() : void
      {
         this._mcBubble.tDialogue.text = this._dialogue;
         this._mcBubble.tDialogue.setTextFormat(LocalConstants.FORMAT());
         this._mcBubble.tDialogue.embedFonts = false;
         this._mcBubble.tDialogue.autoSize = TextFieldAutoSize.CENTER;
         var _loc_1:* = this._dialogue == "" ? 0 : this._mcBubble.tDialogue.height;
         if(this._image != null)
         {
            this._mcBubble.addChild(this._image);
            this._image.x = this._mcBubble.tDialogue.x + this._mcBubble.tDialogue.width / 2 - this._image.width / 2;
            if(this._dialogue == "")
            {
               this._image.y = this._mcBubble.tDialogue.y;
            }
            else
            {
               this._image.y = this._mcBubble.tDialogue.y + this._mcBubble.tDialogue.height + ROW_SPACE;
            }
            _loc_1 += this._image.height + ROW_SPACE;
         }
         this._bubbleOrigH = this._mcBubble.iScale.height;
         this.resizeBubbleHeight(_loc_1);
         this.modifyContent();
         TextUtil.scaleToFit(this._mcBubble.tDialogue);
      }
      
      private function resizeBubbleHeight(param1:int) : void
      {
         var _loc_3:* = Math.max(0,param1 - 75);
         if(_loc_3 > 0)
         {
            this._mcBubble.iScale.height = this._bubbleOrigH + _loc_3;
         }
         else
         {
            this._mcBubble.tDialogue.y += 75 / 2 - this._mcBubble.tDialogue.height / 2;
         }
         this.correctBubblePos();
      }
      
      protected function correctBubblePos() : void
      {
         var _loc_4:int = 0;
         if(this is TutorialPopSwitch)
         {
            _loc_4 = 4;
         }
         else
         {
            _loc_4 = 50;
         }
         var _loc_1:* = new Point(this._mcBubble.x,this._mcBubble.y + this._mcBubble.height + _loc_4);
         var _loc_2:* = this._mcBubble.parent.localToGlobal(_loc_1);
         var _loc_3:* = _loc_2.y - CCConstants.STAGE_HEIGHT;
         if(_loc_3 > 0)
         {
            this._mcClip.y -= _loc_3;
         }
      }
      
      protected function activate(event:TimerEvent) : void
      {
         var _loc_2:* = event.currentTarget as Timer;
         _loc_2.stop();
         _loc_2.removeEventListener(TimerEvent.TIMER_COMPLETE,this.activate);
         _loc_2 = null;
      }
      
      public function continueTutorial(event:MouseEvent) : void
      {
         this.tweenOut("continue");
      }
      
      public function skipTutorial() : void
      {
         this.tweenOut("skip");
      }
      
      private function tweenOut(param1:String) : void
      {
         var _loc_2:* = this.getPosOutsideStage("iArm");
         var _loc_3:* = this.getPosOutsideStage("iHead");
         var _loc_4:* = this.getPosOutsideStage("iBubble");
         TweenLite.to(this._mcHead,0.7,{"x":_loc_3});
         TweenLite.to(this._mcArm,0.7,{"x":_loc_2});
         TweenLite.to(this._mcBubble,0.7,{
            "y":_loc_4,
            "onComplete":this.tweenOutDone,
            "onCompleteParams":[param1]
         });
         TweenLite.to(this._skipButton,0.7,{"alpha":0});
      }
      
      public function tweenOutDone(param1:String) : void
      {
         if(param1 == "continue")
         {
            dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
         }
         else
         {
            dispatchEvent(new Event(CCConstants.SKIP_TUTORIALS));
         }
      }
      
      public function triggerCommand() : void
      {
         TrackingTrail.track("TP");
         dispatchEvent(new Event(CCConstants.LOCK_GAME_BOARD));
         CCMain.mcDisplayTutorial.addChild(this._mcClip);
         this.setUpSkipButton();
         TweenLite.to(this._mcHead,1,{
            "x":this._headOrigX,
            "ease":Back.easeInOut,
            "easeParams":[0.5]
         });
         TweenLite.to(this._mcArm,0.9,{
            "x":this._armOrigX,
            "ease":Back.easeInOut,
            "easeParams":[0.5]
         });
         TweenLite.to(this._mcBubble,1,{
            "y":this._bubbleOrigY,
            "ease":Back.easeInOut,
            "easeParams":[0.5],
            "delay":0.3
         });
         TweenLite.to(this._skipButton,1,{"alpha":1});
         var _loc_1:* = new Timer(1000,1);
         _loc_1.addEventListener(TimerEvent.TIMER_COMPLETE,this.activate);
         _loc_1.start();
      }
      
      public function deactivate() : void
      {
         this._skipButton.removeEventListener(MouseEvent.MOUSE_OVER,this.skipButtonOver);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_OUT,this.skipButtonOut);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.skipButtonDown);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_UP,this.skipButtonUp);
         dispatchEvent(new Event(CCConstants.UNLOCK_GAME_BOARD));
      }
      
      public function destruct() : void
      {
         if(Boolean(this._manMod))
         {
            this._manMod = null;
         }
         if(this._mcClip.parent != null)
         {
            this._mcClip.parent.removeChild(this._mcClip);
         }
         this._mcClip = null;
         if(this._skipButton.parent != null)
         {
            this._skipButton.parent.removeChild(this._skipButton);
         }
         this._skipButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

