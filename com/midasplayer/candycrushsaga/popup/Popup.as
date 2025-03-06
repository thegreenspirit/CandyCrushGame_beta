package com.midasplayer.candycrushsaga.popup
{
   import com.greensock.*;
   import com.greensock.easing.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.candycrushsaga.main.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.candycrushsaga.sound.*;
   import com.midasplayer.candycrushsaga.tutorial.*;
   import flash.display.*;
   import flash.events.*;
   
   public class Popup extends MovieClip implements ICCQueueElement
   {
      internal static const TWEEN_SPEED:Number = 0.8;
      
      internal static const EASE_PARAM_VALUE:Number = 1;
      
      public var popId:String = "base";
      
      private var _quitBtn:MovieClip;
      
      protected var _clbExitFunc:Function;
      
      protected var _popGfx:MovieClip;
      
      protected var _friendsList:MovieClip;
      
      protected var _userPicLoader:UserPicLoader;
      
      protected var _tutorialHandler:TutorialHandler;
      
      public function Popup(param1:Function, param2:MovieClip)
      {
         super();
         this._clbExitFunc = param1;
         this._popGfx = param2;
         this.positionPop();
         this.addChild(this._popGfx);
         if(Boolean(this._popGfx.iBG.iButtonQuit))
         {
            this._quitBtn = this._popGfx.iBG.iButtonQuit;
         }
         else if(Boolean(this._popGfx.iButtonQuit))
         {
            this._quitBtn = this._popGfx.iButtonQuit;
         }
         if(Boolean(this._quitBtn))
         {
            this._quitBtn.buttonMode = true;
            this._quitBtn.mouseChildren = false;
            this._quitBtn.gotoAndStop("normal");
            this._quitBtn.addEventListener(MouseEvent.MOUSE_OVER,this.quitButtonOver);
            this._quitBtn.addEventListener(MouseEvent.MOUSE_OUT,this.quitButtonOut);
            this._quitBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.quitButtonDown);
         }
      }
      
      private function quitButtonOver(event:MouseEvent) : void
      {
         this._quitBtn.gotoAndStop("hovered");
      }
      
      private function quitButtonOut(event:MouseEvent) : void
      {
         this._quitBtn.gotoAndStop("normal");
      }
      
      protected function removeListeners() : void
      {
         this._quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.quitButtonDown);
         this._quitBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.quitButtonOver);
         this._quitBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.quitButtonOut);
      }
      
      protected function positionFriendsList() : void
      {
         var _loc_1:* = this._friendsList.width;
         this._friendsList.x = this._popGfx.width - 15;
         this._friendsList.y = 50;
      }
      
      final protected function quitButtonDown(event:MouseEvent = null) : void
      {
         TrackingTrail.track("PopQ(" + this.popId + ")");
         CCSoundManager.getInstance().playSound(SoundInterface.CLICK);
         this.removeListeners();
         if(this._clbExitFunc != null)
         {
            this._clbExitFunc();
         }
         this.closeHook();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
         Console.println("Popup: Dispatching DEACTIVATE_QUEUE_ELEMENT");
      }
      
      protected function closeHook() : void
      {
      }
      
      protected function tweenTo(param1:int) : void
      {
         TweenLite.to(this._popGfx,TWEEN_SPEED,{
            "alpha":1,
            "y":param1,
            "ease":Back.easeOut,
            "easeParams":[EASE_PARAM_VALUE]
         });
      }
      
      protected function positionPop() : void
      {
         this._popGfx.x = CCConstants.STAGE_WIDTH / 2 - this._popGfx.width / 2;
         this._popGfx.y = -this._popGfx.height;
      }
      
      public function triggerCommand() : void
      {
         TrackingTrail.track("PopTrig(" + this.popId + ")");
         dispatchEvent(new Event(CCConstants.ADD_POPUP));
         CCSoundManager.getInstance().playSound(SoundInterface.SHOW_SIGN);
         if(Boolean(this._popGfx.stage))
         {
            this._popGfx.stage.frameRate = 25;
         }
         this._popGfx.alpha = 0;
         var _loc_1:* = CCConstants.STAGE_HEIGHT / 2 - this._popGfx.height / 2;
         DarkLayer.addDarkLayer(CCMain.mcDisplayPopup);
         this.tweenTo(_loc_1);
      }
      
      protected function addFriendsList(param1:int, param2:int, param3:HighScoreListVO, param4:Function = null) : void
      {
         var _loc_5:* = new FriendsHighscoreListMediator(param3);
         if(param4 != null)
         {
            _loc_5.addEventListener(NextUserTarget.HIGHSCORE_DATA_RECEIVED,param4);
         }
         this._friendsList = _loc_5.getHighscoreListMcForLevel(param1,param2);
         this.positionFriendsList();
         this._popGfx.addChild(this._friendsList);
      }
      
      public function deactivate() : void
      {
         this._popGfx.stage.frameRate = CCConstants.CC_FRAMERATE;
      }
      
      public function destruct() : void
      {
         this.removeListeners();
         this._clbExitFunc = null;
         DarkLayer.removeDarkLayer(CCMain.mcDisplayPopup);
         this._popGfx.parent.removeChild(this._popGfx);
         this._popGfx = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

