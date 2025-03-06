package com.midasplayer.candycrushsaga.cutscene
{
   import com.flashdynamix.motion.*;
   import com.flashdynamix.motion.extras.*;
   import com.greensock.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.main.ICCQueueElement;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class Cutscene extends EventDispatcher implements ICCQueueElement
   {
      private static const MC_NAME_SKIP_BTN:String = "skipBtn";
      
      private static const MC_LABEL_NORMAL:String = "normal";
      
      private static const MC_LABEL_HOVERED:String = "hovered";
      
      private static const MC_LABEL_PRESSED:String = "pressed";
      
      private static const MC_LABEL_ACTIVE:String = "active";
      
      private var _container:MovieClip;
      
      private var _cutscene:MovieClip;
      
      private var _hourGlass:HourGlass;
      
      private var _cutsceneHandler:CutsceneHandler;
      
      private var _cutsceneFactory:CutsceneFactory;
      
      private var _dialogues:Array;
      
      private var _shortVersion:Boolean;
      
      private var _snapShot:Bitmap;
      
      private var _speechBubble:MovieClip;
      
      private var _skipButton:MovieClip;
      
      private var _nextButton:MovieClip;
      
      private var _skipButtonOriginalW:int;
      
      private var _nextButtonOriginalW:int;
      
      private var _lastFrame:int;
      
      private var _nextButtonFadeTimer:Timer;
      
      private var _clickContinueEnabled:Boolean;
      
      private var _beenColorTransformed:Boolean;
      
      public function Cutscene(param1:CutsceneHandler, param2:MovieClip, param3:int, param4:HourGlass, param5:Boolean)
      {
         super();
         this._cutsceneHandler = param1;
         this._cutsceneFactory = param1.getFactory();
         this._container = param2;
         this._shortVersion = param5;
         this._hourGlass = param4;
         this._clickContinueEnabled = false;
         this._beenColorTransformed = false;
         this._lastFrame = 1;
      }
      
      public function getShortVersion() : Boolean
      {
         return this._shortVersion;
      }
      
      public function triggerCommand() : void
      {
         if(this._cutsceneFactory == null || this._cutsceneFactory.getCutsceneAvailable() == false)
         {
            Console.println("Still loading cutscene... Add timeglass...");
            this._hourGlass.setUp(this._cutsceneFactory.getCutsceneAvailable,this.triggerCommand);
            return;
         }
         this._cutscene = this._cutsceneFactory.getCutscene();
         this._cutscene.addEventListener(CutsceneDialogueEvent.ADD_DIALOGUE,this.displayDialogue);
         this._cutscene.addEventListener(CutsceneConstants.END_CUTSCENE,this.endCutscene);
         this._cutscene.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._cutscene.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._container.addChild(this._cutscene);
         this._container.stage.frameRate = 30;
         this.setUpSpeechBubble();
         this.setUpNextButton();
         this.setUpSkipButton();
         this.setStartFrames();
         this.runCutscene();
         if(!this._shortVersion)
         {
            SoundInterface.getMusicPlayer().playMusicInCutscene();
         }
      }
      
      private function setStartFrames() : void
      {
         var ob:Object = null;
         var mc:MovieClip = null;
         var arr:* = this._cutsceneHandler.getSnappedFrameIndexes();
         var _loc_3:* = arr;
         do
         {
            ob = _loc_3[0];
            try
            {
               mc = this._cutscene[ob.name] as MovieClip;
               if(Boolean(mc))
               {
                  if(mc.totalFrames >= ob.frame)
                  {
                     mc.gotoAndPlay(ob.frame);
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         while(_loc_3 in 0);
         
      }
      
      private function runCutscene() : void
      {
         if(this._shortVersion)
         {
            this._cutscene.play();
            this.forceDeactivation();
         }
         else
         {
            this._cutscene.play();
         }
      }
      
      public function displayDialogue(event:CutsceneDialogueEvent) : void
      {
         var _loc_3:int = 0;
         var _loc_4:int = 0;
         var _loc_2:* = event.textKey;
         if(Boolean(this._speechBubble))
         {
            this._speechBubble.tDialogue.text = I18n.getString(_loc_2);
            this._speechBubble.tDialogue.autoSize = TextFieldAutoSize.LEFT;
            TextUtil.scaleToFit(this._speechBubble.tDialogue);
            this._speechBubble.tDialogue.setTextFormat(LocalConstants.FORMAT());
            this._speechBubble.tDialogue.embedFonts = false;
            _loc_3 = 527 + this._speechBubble.tDialogue.height - 60;
            this._speechBubble.bubble.height = _loc_3;
            _loc_4 = 527 - _loc_3;
            this._speechBubble.tDialogue.y = _loc_4;
            this.killNextButtonFadeTimer();
            this._nextButton.alpha = 0;
            this._nextButton.buttonMode = false;
         }
      }
      
      private function activateNextButton() : void
      {
         this.resizeNextButton();
         if(this._nextButtonFadeTimer == null)
         {
            this._nextButtonFadeTimer = new Timer(1000,1);
            this._nextButtonFadeTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.fadeInNextButton);
            this._nextButtonFadeTimer.start();
         }
      }
      
      private function fadeInNextButton(event:TimerEvent) : void
      {
         var e:* = event;
         TweenLite.to(this._nextButton,1,{
            "alpha":1,
            "onComplete":function():void
            {
               _nextButton.gotoAndStop(Cutscene.MC_LABEL_ACTIVE);
               _nextButton.buttonMode = true;
               resizeNextButton();
            }
         });
      }
      
      private function killNextButtonFadeTimer() : void
      {
         if(this._nextButtonFadeTimer == null)
         {
            return;
         }
         this._nextButtonFadeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.fadeInNextButton);
         this._nextButtonFadeTimer.stop();
         this._nextButtonFadeTimer = null;
      }
      
      private function setUpSpeechBubble() : void
      {
         this._speechBubble = this._cutscene.getChildByName("speechBubble") as MovieClip;
         this._speechBubble.tDialogue.mouseEnabled = false;
      }
      
      private function setUpSkipButton() : void
      {
         this._skipButton = this._cutscene.skipBtn;
         this._skipButton.gotoAndStop(Cutscene.MC_LABEL_NORMAL);
         this._skipButton.buttonMode = true;
         this._skipButton.mouseChildren = false;
         this._skipButtonOriginalW = this._skipButton.iBG.width;
         this._skipButton.tSkip.text = I18n.getString("cutscene_button_skip");
         this._skipButton.tSkip.setTextFormat(LocalConstants.FORMAT("Tahoma"));
         this._skipButton.tSkip.embedFonts = false;
         this._skipButton.tSkip.autoSize = TextFieldAutoSize.LEFT;
         TextUtil.scaleToFit(this._skipButton.tSkip);
         this.resizeSkipButton();
         this._skipButton.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._skipButton.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._skipButton.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._skipButton.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
      
      private function resizeSkipButton() : void
      {
         this._skipButton.iBG.width = this._skipButtonOriginalW + this._skipButton.tSkip.width - 60;
         this._skipButton.iArrows.x = this._skipButton.tSkip.x + this._skipButton.tSkip.width + 10;
         this._skipButton.x = CCConstants.STAGE_WIDTH - this._skipButton.width - 23;
      }
      
      private function setUpNextButton() : void
      {
         this._nextButton = this._speechBubble.nextBtn;
         this._nextButton.alpha = 0;
         this._nextButton.mouseChildren = false;
         this._nextButtonOriginalW = this._nextButton.iBG.width;
         this._nextButton.tNext.text = I18n.getString("cutscene_button_next");
         this._nextButton.tNext.autoSize = TextFieldAutoSize.LEFT;
         TextUtil.scaleToFit(this._nextButton.tNext);
         this._nextButton.tNext.setTextFormat(LocalConstants.FORMAT("Tahoma"));
         this._nextButton.tNext.embedFonts = false;
         this.resizeNextButton();
      }
      
      private function resizeNextButton() : void
      {
         this._nextButton.iBG.width = this._nextButtonOriginalW + this._nextButton.tNext.width - 70;
      }
      
      private function onEnterFrame(event:Event) : void
      {
         if(!this._cutscene || this._cutscene.currentFrame == this._cutscene.totalFrames)
         {
            return;
         }
         if(this._cutscene.currentFrame != this._lastFrame)
         {
            this._clickContinueEnabled = false;
         }
         else
         {
            this._clickContinueEnabled = true;
            this.activateNextButton();
         }
         this._lastFrame = this._cutscene.currentFrame;
      }
      
      private function onMouseOver(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(!_loc_2)
         {
            return;
         }
         switch(_loc_2.name)
         {
            case MC_NAME_SKIP_BTN:
               _loc_2.gotoAndStop(Cutscene.MC_LABEL_HOVERED);
               this.resizeSkipButton();
         }
      }
      
      private function onMouseOut(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(!_loc_2)
         {
            return;
         }
         switch(_loc_2.name)
         {
            case MC_NAME_SKIP_BTN:
               _loc_2.gotoAndStop(Cutscene.MC_LABEL_NORMAL);
               this.resizeSkipButton();
         }
      }
      
      private function onMouseDown(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(!_loc_2)
         {
            return;
         }
         switch(_loc_2.name)
         {
            case Cutscene.MC_NAME_SKIP_BTN:
               _loc_2.gotoAndStop(Cutscene.MC_LABEL_PRESSED);
               this.resizeSkipButton();
               break;
            default:
               if(!this._clickContinueEnabled)
               {
                  return;
               }
               this.runCutscene();
               this.killNextButtonFadeTimer();
               this._nextButton.gotoAndStop(Cutscene.MC_LABEL_NORMAL);
               this.resizeNextButton();
               this._clickContinueEnabled = false;
               TweenLite.to(this._nextButton,0.5,{"alpha":0});
               break;
         }
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK);
      }
      
      private function onMouseUp(event:MouseEvent) : void
      {
         var _loc_2:* = event.currentTarget as MovieClip;
         if(!_loc_2)
         {
            return;
         }
         switch(_loc_2.name)
         {
            case MC_NAME_SKIP_BTN:
               this.forceDeactivation();
         }
      }
      
      private function forceDeactivation() : void
      {
         if(this._cutsceneFactory.getFollowUp())
         {
            this._cutscene.gotoAndStop(1);
            this.endCutscene();
         }
         else
         {
            this._cutscene.gotoAndStop(this._cutscene.totalFrames);
         }
      }
      
      private function endCutscene(event:Event = null) : void
      {
         this._cutscene.stop();
         SoundInterface.getMusicPlayer().stopMusicInCutscene();
         var _loc_2:* = CutsceneConstants.CUTSCENE_CLOSING_PAUSE;
         this.hideGUI(_loc_2);
         var _loc_3:* = new Timer(_loc_2,1);
         _loc_3.addEventListener(TimerEvent.TIMER_COMPLETE,this.deactivateCutscene);
         _loc_3.start();
         this.colorTransformBG();
      }
      
      private function colorTransformBG() : void
      {
         if(this._beenColorTransformed)
         {
            return;
         }
         var _loc_1:* = new TweensyGroup();
         _loc_1.to(new ColorMatrixFilter(),new ColorMatrix(0.1,0.7,1),1,null,0,this._cutscene);
         this._beenColorTransformed = true;
      }
      
      private function hideGUI(param1:int = 0) : void
      {
         this._skipButton.buttonMode = false;
         this._skipButton.mouseEnabled = false;
         TweenLite.to(this._skipButton,param1 / 1500,{"alpha":0});
      }
      
      private function deactivateCutscene(event:TimerEvent = null) : void
      {
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      private function takeSnapShot() : void
      {
         this.hideGUI(0);
         this.colorTransformBG();
         var _loc_1:* = new BitmapData(CCConstants.STAGE_WIDTH,CCConstants.STAGE_HEIGHT);
         _loc_1.draw(this._cutsceneFactory.getCutscene());
         this._snapShot = null;
         this._snapShot = new Bitmap(_loc_1);
         var _loc_2:* = new MovieClip();
         _loc_2.addChild(this._snapShot);
         this._cutsceneHandler.setSnappedFrameIndexes();
         this._cutsceneFactory.setCutsceneSnapShot(_loc_2);
      }
      
      public function deactivate() : void
      {
         this._cutsceneFactory.stopAllAnimations(this._cutsceneFactory.getCutscene());
         this.takeSnapShot();
      }
      
      public function destruct() : void
      {
         this._container.stage.frameRate = CCConstants.CC_FRAMERATE;
         this._cutscene.removeEventListener(CutsceneDialogueEvent.ADD_DIALOGUE,this.displayDialogue);
         this._cutscene.removeEventListener(CutsceneConstants.END_CUTSCENE,this.endCutscene);
         this._cutscene.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._cutscene.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._skipButton.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         if(this._cutscene.parent != null)
         {
            this._cutscene.parent.removeChild(this._cutscene);
         }
         this._cutscene = null;
      }
   }
}

import flash.events.EventDispatcher;

