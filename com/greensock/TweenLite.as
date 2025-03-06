package com.greensock
{
   import com.greensock.core.*;
   import com.greensock.plugins.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TweenLite extends TweenCore
   {
      public static var onPluginEvent:Function;
      
      public static var overwriteManager:Object;
      
      public static var rootFrame:Number;
      
      public static var rootTimeline:SimpleTimeline;
      
      public static var rootFramesTimeline:SimpleTimeline;
      
      public static const version:Number = 11.133;
      
      public static var plugins:Object = {};
      
      public static var fastEaseLookup:Dictionary = new Dictionary(false);
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      public static var masterList:Dictionary = new Dictionary(false);
      
      private static var _shape:Shape = new Shape();
      
      protected static var _reservedProps:Object = {
         "ease":1,
         "delay":1,
         "overwrite":1,
         "onComplete":1,
         "onCompleteParams":1,
         "useFrames":1,
         "runBackwards":1,
         "startAt":1,
         "onUpdate":1,
         "onUpdateParams":1,
         "roundProps":1,
         "onStart":1,
         "onStartParams":1,
         "onReverseComplete":1,
         "onReverseCompleteParams":1,
         "onRepeat":1,
         "onRepeatParams":1,
         "proxiedEase":1,
         "easeParams":1,
         "yoyo":1,
         "onCompleteListener":1,
         "onUpdateListener":1,
         "onStartListener":1,
         "onReverseCompleteListener":1,
         "onRepeatListener":1,
         "orientToBezier":1,
         "timeScale":1,
         "immediateRender":1,
         "repeat":1,
         "repeatDelay":1,
         "timeline":1,
         "data":1,
         "paused":1
      };
      
      protected var _hasPlugins:Boolean;
      
      public var propTweenLookup:Object;
      
      public var cachedPT1:PropTween;
      
      protected var _overwrite:uint;
      
      protected var _ease:Function;
      
      public var target:Object;
      
      public var ratio:Number = 0;
      
      protected var _overwrittenProps:Object;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      public function TweenLite(target:Object, duration:Number, vars:Object)
      {
         var sibling:TweenLite = null;
         super(duration,vars);
         this.target = target;
         if(this.target is TweenCore && "timeScale" in this.vars)
         {
            this.cachedTimeScale = 1;
         }
         this.propTweenLookup = {};
         this._ease = defaultEase;
         this._overwrite = Number(vars.overwrite) <= -1 || !overwriteManager.enabled && vars.overwrite > 1 ? uint(overwriteManager.mode) : uint(int(vars.overwrite));
         var a:Array = masterList[target];
         if(!a)
         {
            masterList[target] = [this];
         }
         else if(this._overwrite == 1)
         {
            for each(sibling in a)
            {
               if(!sibling.gc)
               {
                  sibling.setEnabled(false,false);
               }
            }
            masterList[target] = [this];
         }
         else
         {
            a[a.length] = this;
         }
         if(this.active || Boolean(this.vars.immediateRender))
         {
            this.renderTime(0,false,true);
         }
      }
      
      public static function initClass() : void
      {
         rootFrame = 0;
         rootTimeline = new SimpleTimeline(null);
         rootFramesTimeline = new SimpleTimeline(null);
         rootTimeline.cachedStartTime = getTimer() * 0.001;
         rootFramesTimeline.cachedStartTime = rootFrame;
         rootTimeline.autoRemoveChildren = true;
         rootFramesTimeline.autoRemoveChildren = true;
         _shape.addEventListener(Event.ENTER_FRAME,updateAll,false,0,true);
         if(overwriteManager == null)
         {
            overwriteManager = {
               "mode":1,
               "enabled":false
            };
         }
      }
      
      public static function killTweensOf(target:Object, complete:Boolean = false) : void
      {
         var a:Array = null;
         var i:int = 0;
         if(target in masterList)
         {
            a = masterList[target];
            i = int(a.length);
            while(Boolean(i--))
            {
               if(!TweenLite(a[i]).gc)
               {
                  if(complete)
                  {
                     TweenLite(a[i]).complete(false,false);
                  }
                  else
                  {
                     TweenLite(a[i]).setEnabled(false,false);
                  }
               }
            }
            delete masterList[target];
         }
      }
      
      public static function from(target:Object, duration:Number, vars:Object) : TweenLite
      {
         vars.runBackwards = true;
         if(!("immediateRender" in vars))
         {
            vars.immediateRender = true;
         }
         return new TweenLite(target,duration,vars);
      }
      
      protected static function easeOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         t = 1 - t / d;
         return 1 - t * t;
      }
      
      public static function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array = null, useFrames:Boolean = false) : TweenLite
      {
         return new TweenLite(onComplete,0,{
            "delay":delay,
            "onComplete":onComplete,
            "onCompleteParams":onCompleteParams,
            "immediateRender":false,
            "useFrames":useFrames,
            "overwrite":0
         });
      }
      
      protected static function updateAll(e:Event = null) : void
      {
         var ml:Dictionary = null;
         var tgt:Object = null;
         var a:Array = null;
         var i:int = 0;
         rootTimeline.renderTime((getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale,false,false);
         ++rootFrame;
         rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale,false,false);
         if(!(rootFrame % 60))
         {
            ml = masterList;
            for(tgt in ml)
            {
               a = ml[tgt];
               i = int(a.length);
               while(Boolean(i--))
               {
                  if(TweenLite(a[i]).gc)
                  {
                     a.splice(i,1);
                  }
               }
               if(a.length == 0)
               {
                  delete ml[tgt];
               }
            }
         }
      }
      
      public static function to(target:Object, duration:Number, vars:Object) : TweenLite
      {
         return new TweenLite(target,duration,vars);
      }
      
      protected function easeProxy(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
      
      override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void
      {
         var isComplete:Boolean = false;
         var prevTime:Number = this.cachedTime;
         if(time >= this.cachedDuration)
         {
            this.cachedTotalTime = this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            isComplete = true;
            if(this.cachedDuration == 0)
            {
               if((time == 0 || _rawPrevTime < 0) && _rawPrevTime != time)
               {
                  force = true;
               }
               _rawPrevTime = time;
            }
         }
         else if(time <= 0)
         {
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if(time < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime > 0)
                  {
                     force = true;
                     isComplete = true;
                  }
                  _rawPrevTime = time;
               }
            }
            if(this.cachedReversed && prevTime != 0)
            {
               isComplete = true;
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = time;
            this.ratio = this._ease(time,0,1,this.cachedDuration);
         }
         if(this.cachedTime == prevTime && !force)
         {
            return;
         }
         if(!this.initted)
         {
            this.init();
            if(!isComplete && Boolean(this.cachedTime))
            {
               this.ratio = this._ease(this.cachedTime,0,1,this.cachedDuration);
            }
         }
         if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         if(prevTime == 0 && this.vars.onStart && this.cachedTime != 0 && !suppressEvents)
         {
            this.vars.onStart.apply(null,this.vars.onStartParams);
         }
         var pt:PropTween = this.cachedPT1;
         while(Boolean(pt))
         {
            pt.target[pt.property] = pt.start + this.ratio * pt.change;
            pt = pt.nextNode;
         }
         if(_hasUpdate && !suppressEvents)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(isComplete)
         {
            if(this._hasPlugins && Boolean(this.cachedPT1))
            {
               onPluginEvent("onComplete",this);
            }
            complete(true,suppressEvents);
         }
      }
      
      override public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean = false) : Boolean
      {
         var a:Array = null;
         if(enabled)
         {
            a = TweenLite.masterList[this.target];
            if(!a)
            {
               TweenLite.masterList[this.target] = [this];
            }
            else
            {
               a[a.length] = this;
            }
         }
         super.setEnabled(enabled,ignoreTimeline);
         if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1))
         {
            return onPluginEvent(enabled ? "onEnable" : "onDisable",this);
         }
         return false;
      }
      
      protected function init() : void
      {
         var p:String = null;
         var i:int = 0;
         var plugin:* = undefined;
         var prioritize:Boolean = false;
         var siblings:Array = null;
         var pt:PropTween = null;
         if(typeof this.vars.ease == "function")
         {
            this._ease = this.vars.ease;
         }
         if(Boolean(this.vars.easeParams))
         {
            this.vars.proxiedEase = this._ease;
            this._ease = this.easeProxy;
         }
         this.cachedPT1 = null;
         this.propTweenLookup = {};
         for(p in this.vars)
         {
            if(!(p in _reservedProps && !(p == "timeScale" && this.target is TweenCore)))
            {
               if(p in plugins && Boolean((plugin = new (plugins[p] as Class)()).onInitTween(this.target,this.vars[p],this)))
               {
                  this.cachedPT1 = new PropTween(plugin,"changeFactor",0,1,plugin.overwriteProps.length == 1 ? plugin.overwriteProps[0] : "_MULTIPLE_",true,this.cachedPT1);
                  if(this.cachedPT1.name == "_MULTIPLE_")
                  {
                     i = int(plugin.overwriteProps.length);
                     while(Boolean(i--))
                     {
                        this.propTweenLookup[plugin.overwriteProps[i]] = this.cachedPT1;
                     }
                  }
                  else
                  {
                     this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                  }
                  if(Boolean(plugin.priority))
                  {
                     this.cachedPT1.priority = plugin.priority;
                     prioritize = true;
                  }
                  if(Boolean(plugin.onDisable) || Boolean(plugin.onEnable))
                  {
                     this._notifyPluginsOfEnabled = true;
                  }
                  this._hasPlugins = true;
               }
               else
               {
                  this.cachedPT1 = new PropTween(this.target,p,Number(this.target[p]),typeof this.vars[p] == "number" ? Number(this.vars[p]) - this.target[p] : Number(this.vars[p]),p,false,this.cachedPT1);
                  this.propTweenLookup[p] = this.cachedPT1;
               }
            }
         }
         if(prioritize)
         {
            onPluginEvent("onInit",this);
         }
         if(Boolean(this.vars.runBackwards))
         {
            pt = this.cachedPT1;
            while(Boolean(pt))
            {
               pt.start += pt.change;
               pt.change = -pt.change;
               pt = pt.nextNode;
            }
         }
         _hasUpdate = Boolean(this.vars.onUpdate != null);
         if(Boolean(this._overwrittenProps))
         {
            this.killVars(this._overwrittenProps);
            if(this.cachedPT1 == null)
            {
               this.setEnabled(false,false);
            }
         }
         if(this._overwrite > 1 && this.cachedPT1 && (siblings = masterList[this.target]) && siblings.length > 1)
         {
            if(Boolean(overwriteManager.manageOverwrites(this,this.propTweenLookup,siblings,this._overwrite)))
            {
               this.init();
            }
         }
         this.initted = true;
      }
      
      public function killVars(vars:Object, permanent:Boolean = true) : Boolean
      {
         var p:String = null;
         var pt:PropTween = null;
         var changed:Boolean = false;
         if(this._overwrittenProps == null)
         {
            this._overwrittenProps = {};
         }
         for(p in vars)
         {
            if(p in this.propTweenLookup)
            {
               pt = this.propTweenLookup[p];
               if(pt.isPlugin && pt.name == "_MULTIPLE_")
               {
                  pt.target.killProps(vars);
                  if(pt.target.overwriteProps.length == 0)
                  {
                     pt.name = "";
                  }
               }
               if(pt.name != "_MULTIPLE_")
               {
                  if(Boolean(pt.nextNode))
                  {
                     pt.nextNode.prevNode = pt.prevNode;
                  }
                  if(Boolean(pt.prevNode))
                  {
                     pt.prevNode.nextNode = pt.nextNode;
                  }
                  else if(this.cachedPT1 == pt)
                  {
                     this.cachedPT1 = pt.nextNode;
                  }
                  if(pt.isPlugin && Boolean(pt.target.onDisable))
                  {
                     pt.target.onDisable();
                     if(Boolean(pt.target.activeDisable))
                     {
                        changed = true;
                     }
                  }
                  delete this.propTweenLookup[p];
               }
            }
            if(permanent)
            {
               this._overwrittenProps[p] = 1;
            }
         }
         return changed;
      }
      
      override public function invalidate() : void
      {
         if(this._notifyPluginsOfEnabled && Boolean(this.cachedPT1))
         {
            onPluginEvent("onDisable",this);
         }
         this.cachedPT1 = null;
         this._overwrittenProps = null;
         _hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
         this.propTweenLookup = {};
      }
   }
}

import com.greensock.core.TweenCore;

