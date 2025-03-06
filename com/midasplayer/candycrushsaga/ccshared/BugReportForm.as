package com.midasplayer.candycrushsaga.ccshared
{
   import com.greensock.*;
   import com.midasplayer.bug.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.text.*;
   import flash.utils.*;
   
   public class BugReportForm extends MovieClip
   {
      private var _clip:GA_preloader_bug_report_form;
      
      private var bugMail:String;
      
      public function BugReportForm(param1:String)
      {
         super();
         TrackingTrail.track("BugPop");
         this.bugMail = param1;
         this._clip = new GA_preloader_bug_report_form();
         this._clip.gotoAndStop(1);
         this.addChild(this._clip);
         this._clip.bug_description.addEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.suggestion_description.addEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.feeling_description.addEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.button_send.addEventListener(MouseEvent.CLICK,this._onSendPressed);
         this._clip.button_close.addEventListener(MouseEvent.CLICK,this._onClosePressed);
         this._clip.button_close.mouseEnabled = true;
         this._clip.button_close.buttonMode = true;
         this._clip.bugEntryHintTxt.mouseEnabled = false;
         this._clip.feelingEntryHintTxt.mouseEnabled = false;
         this._clip.suggestionEntryHintTxt.mouseEnabled = false;
         this._clip.button_send.buttonMode = true;
         this._clip.button_send.mouseEnabled = true;
         this.addEventListener(Event.ADDED_TO_STAGE,this.onStage);
         this.filters = [new DropShadowFilter(10,45,0,0.3)];
         this.scaleY = 0;
         this.scaleX = 0;
         TweenLite.to(this,0.3,{
            "y":220,
            "scaleX":1,
            "scaleY":1,
            "delay":0.5
         });
      }
      
      private function onStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onStage);
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onStage);
         this._clip.bug_description.text = "";
         this._clip.feeling_description.text = "";
         this._clip.suggestion_description.text = "";
         this.inactivateSend();
         stage.focus = this._clip.feeling_description;
      }
      
      private function inactivateSend() : void
      {
         this._clip.button_send.alpha = 0.5;
         this._clip.button_send.buttonMode = false;
      }
      
      private function activateSend() : void
      {
         this._clip.button_send.buttonMode = true;
         this._clip.button_send.alpha = 1;
      }
      
      public function destruct() : void
      {
         this._clip.bug_description.removeEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.feeling_description.removeEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.suggestion_description.removeEventListener(Event.CHANGE,this._onEnterDescription);
         this._clip.button_send.removeEventListener(MouseEvent.CLICK,this._onSendPressed);
         this._clip.button_close.removeEventListener(MouseEvent.CLICK,this._onClosePressed);
      }
      
      private function _onSendPressed(event:Event) : void
      {
         if(this._clip.button_send.alpha != 1)
         {
            return;
         }
         this.visible = false;
         setTimeout(this.__displayWaitMessage,200);
      }
      
      private function __displayWaitMessage() : void
      {
         this._clip.bug_description.visible = false;
         this.inactivateSend();
         this._clip.button_close.visible = false;
         this._clip.gotoAndStop(2);
         this.visible = true;
      }
      
      private function _onComplete(param1:String) : void
      {
         this.visible = true;
         this._clip.button_close.visible = true;
         this._clip.bug_description.visible = false;
         this.inactivateSend();
         this._clip.gotoAndStop(3);
      }
      
      private function _onError(param1:String) : void
      {
         this.visible = true;
         this._clip.button_close.visible = true;
         this._clip.bug_description.visible = false;
         this.inactivateSend();
         this._clip.gotoAndStop(4);
      }
      
      private function _onEnterDescription(event:Event) : void
      {
         var _loc_2:* = TextField(event.target);
         if(_loc_2.text.length > 0)
         {
            this.activateSend();
         }
         else
         {
            this.inactivateSend();
         }
      }
      
      private function _getDescription() : String
      {
         var _loc_1:String = "";
         var _loc_2:* = this._clip.bug_description.text;
         if(_loc_2 != "")
         {
            _loc_1 += " [BUGS=] " + _loc_2;
         }
         var _loc_3:* = this._clip.feeling_description.text;
         if(_loc_3 != "")
         {
            _loc_1 += " [FEELINGS=] " + _loc_3;
         }
         var _loc_4:* = this._clip.suggestion_description.text;
         if(this._clip.suggestion_description.text != "")
         {
            _loc_1 += " [SUGGESTIONS=] " + _loc_4;
         }
         if(PathTracker.isUsed())
         {
            _loc_1 += PathTracker.getStatusForAll();
         }
         return _loc_1;
      }
      
      private function _onClosePressed(event:Event = null) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

