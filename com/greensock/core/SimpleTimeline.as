package com.greensock.core
{
   public class SimpleTimeline extends TweenCore
   {
      public var autoRemoveChildren:Boolean;
      
      protected var _lastChild:TweenCore;
      
      protected var _firstChild:TweenCore;
      
      public function SimpleTimeline(vars:Object = null)
      {
         super(0,vars);
      }
      
      override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void
      {
         var dur:Number = NaN;
         var next:TweenCore = null;
         var tween:TweenCore = this._firstChild;
         this.cachedTotalTime = time;
         this.cachedTime = time;
         while(Boolean(tween))
         {
            next = tween.nextNode;
            if(tween.active || time >= tween.cachedStartTime && !tween.cachedPaused && !tween.gc)
            {
               if(!tween.cachedReversed)
               {
                  tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
               }
               else
               {
                  dur = tween.cacheIsDirty ? tween.totalDuration : tween.cachedTotalDuration;
                  tween.renderTime(dur - (time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
               }
            }
            tween = next;
         }
      }
      
      public function addChild(tween:TweenCore) : void
      {
         if(!tween.gc && Boolean(tween.timeline))
         {
            tween.timeline.remove(tween,true);
         }
         tween.timeline = this;
         if(tween.gc)
         {
            tween.setEnabled(true,true);
         }
         if(Boolean(this._firstChild))
         {
            this._firstChild.prevNode = tween;
         }
         tween.nextNode = this._firstChild;
         this._firstChild = tween;
         tween.prevNode = null;
      }
      
      public function remove(tween:TweenCore, skipDisable:Boolean = false) : void
      {
         if(tween.gc)
         {
            return;
         }
         if(!skipDisable)
         {
            tween.setEnabled(false,true);
         }
         if(Boolean(tween.nextNode))
         {
            tween.nextNode.prevNode = tween.prevNode;
         }
         else if(this._lastChild == tween)
         {
            this._lastChild = tween.prevNode;
         }
         if(Boolean(tween.prevNode))
         {
            tween.prevNode.nextNode = tween.nextNode;
         }
         else if(this._firstChild == tween)
         {
            this._firstChild = tween.nextNode;
         }
      }
      
      public function get rawTime() : Number
      {
         return this.cachedTotalTime;
      }
   }
}

