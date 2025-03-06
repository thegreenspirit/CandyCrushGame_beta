package com.flashdynamix.motion
{
   import com.flashdynamix.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.utils.*;
   
   public class TweensyGroup
   {
      private static var pool:ObjectPool = new ObjectPool(TweensyTimeline);
      
      private static var frame:Sprite = new Sprite();
      
      private static var map:Dictionary = new Dictionary(true);
      
      private static var keyframes:Dictionary = new Dictionary(true);
      
      public static var filters:Dictionary = new Dictionary(true);
      
      public var lazyMode:Boolean = true;
      
      public var useObjectPooling:Boolean = false;
      
      public var smartRotate:Boolean = true;
      
      public var snapToClosest:Boolean = false;
      
      public var autoHide:Boolean = false;
      
      public var secondsPerFrame:Number = 0.0333333;
      
      public var refreshType:String = "time";
      
      public var onUpdate:Function;
      
      public var onUpdateParams:Array;
      
      public var onComplete:Function;
      
      public var onCompleteParams:Array;
      
      private var first:TweensyTimeline;
      
      private var last:TweensyTimeline;
      
      private var time:Number;
      
      private var _timelines:int = 0;
      
      private var _paused:Boolean;
      
      private var disposed:Boolean = false;
      
      public function TweensyGroup(param1:Boolean = true, param2:Boolean = false, param3:String = "time")
      {
         super();
         this.lazyMode = param1;
         this.useObjectPooling = param2;
         this.refreshType = param3;
         this.time = getTimer();
      }
      
      public static function empty() : void
      {
         pool.empty();
         map = new Dictionary(true);
         keyframes = new Dictionary(true);
         filters = new Dictionary(true);
      }
      
      public function to(param1:Object, param2:Object, param3:Number = 0.5, param4:Function = null, param5:Number = 0, param6:Object = null, param7:Function = null, param8:Array = null) : TweensyTimeline
      {
         var _loc_9:* = this.setup(param3,param4,param5,param7,param8);
         this.setup(param3,param4,param5,param7,param8).to(param1,param2,param6);
         return this.add(_loc_9);
      }
      
      public function from(param1:Object, param2:Object, param3:Number = 0.5, param4:Function = null, param5:Number = 0, param6:Object = null, param7:Function = null, param8:Array = null) : TweensyTimeline
      {
         var _loc_9:* = this.setup(param3,param4,param5,param7,param8);
         this.setup(param3,param4,param5,param7,param8).from(param1,param2,param6);
         return this.add(_loc_9);
      }
      
      public function fromTo(param1:Object, param2:Object, param3:Object, param4:Number = 0.5, param5:Function = null, param6:Number = 0, param7:Object = null, param8:Function = null, param9:Array = null) : TweensyTimeline
      {
         var _loc_10:* = this.setup(param4,param5,param6,param8,param9);
         this.setup(param4,param5,param6,param8,param9).fromTo(param1,param2,param3,param7);
         return this.add(_loc_10);
      }
      
      public function updateTo(param1:Object, param2:Object) : void
      {
         var _loc_3:* = this.first;
         var _loc_4:* = map[param1];
         for each(_loc_3 in _loc_4)
         {
            _loc_3.updateTo(param1,param2);
         }
      }
      
      public function functionTo(param1:Object, param2:Object, param3:Function, param4:Number = 0.5, param5:Function = null, param6:Number = 0) : TweensyTimeline
      {
         var _loc_7:* = this.setup(param4,param5,param6);
         this.setup(param4,param5,param6).to(param1,param2);
         _loc_7.onUpdate = param3;
         _loc_7.onUpdateParams = [param1];
         this.add(_loc_7);
         return _loc_7;
      }
      
      public function alphaTo(param1:Object, param2:Number, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1,{"alpha":param2});
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function scaleTo(param1:Object, param2:Number, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1,{
            "scaleX":param2,
            "scaleY":param2
         });
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function slideTo(param1:Object, param2:Number, param3:Number, param4:Number = 0.5, param5:Function = null, param6:Number = 0) : TweensyTimeline
      {
         var _loc_7:* = this.setup(param4,param5,param6);
         this.setup(param4,param5,param6).to(param1,{
            "x":param2,
            "y":param3
         });
         this.add(_loc_7);
         return _loc_7;
      }
      
      public function rotateTo(param1:Object, param2:Number, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1,{"rotation":param2});
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function matrixTo(param1:DisplayObject, param2:Matrix, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1.transform.matrix,param2,param1);
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function soundTransformTo(param1:Object, param2:SoundTransform, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         if(param1 is SoundChannel)
         {
            _loc_6.to((param1 as SoundChannel).soundTransform,param2,param1);
         }
         else
         {
            _loc_6.to((param1 as Sprite).soundTransform,param2,param1);
         }
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function filterTo(param1:DisplayObject, param2:BitmapFilter, param3:Object, param4:Number = 0.5, param5:Function = null, param6:Number = 0, param7:Boolean = true, param8:Boolean = false) : TweensyTimeline
      {
         var filterMatch:BitmapFilter = null;
         var instanceFilters:Array = null;
         var filterItem:BitmapFilter = null;
         var instance:* = undefined;
         var filter:* = undefined;
         var _loc_10:int = 0;
         instance = undefined;
         filter = undefined;
         var _loc_11:* = undefined;
         instance = param1;
         filter = param2;
         var to:* = param3;
         var duration:* = param4;
         var ease:* = param5;
         var delayStart:* = param6;
         var uniqueFilters:* = param7;
         var autoRemove:* = param8;
         var timeline:* = this.setup(duration,ease,delayStart);
         if(uniqueFilters)
         {
            if(filters[instance] == null)
            {
               filters[instance] = instance.filters;
            }
            instanceFilters = filters[instance];
            _loc_10 = 0;
            _loc_11 = instanceFilters;
            while(_loc_11 in _loc_10)
            {
               filterItem = _loc_11[_loc_10];
               if(getQualifiedClassName(filter) == getQualifiedClassName(filterItem))
               {
                  filterMatch = filterItem;
               }
            }
            filter = Boolean(filterMatch) ? filterMatch : filter;
         }
         timeline.to(filter,to,instance);
         this.add(timeline);
         if(autoRemove)
         {
            timeline._onComplete = function():void
            {
               var _loc_1:* = filters[instance];
               _loc_1.splice(_loc_1.indexOf(filter),1);
               instance.filters = _loc_1;
            };
         }
         return timeline;
      }
      
      public function retrieveFilters(param1:DisplayObject) : Array
      {
         return filters[param1];
      }
      
      public function colorTo(param1:DisplayObject, param2:uint, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         var _loc_7:* = new ColorTransform();
         _loc_7.color = param2;
         _loc_6.to(param1.transform.colorTransform,_loc_7,param1);
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function colorTransformTo(param1:DisplayObject, param2:ColorTransform, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1.transform.colorTransform,param2,param1);
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function contrastTo(param1:DisplayObject, param2:Number, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.setup(param3,param4,param5);
         var _loc_7:* = new ColorTransform(1,1,1,1,param2 * 255,param2 * 255,param2 * 255);
         _loc_6.to(param1.transform.colorTransform,_loc_7,param1);
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function brightnessTo(param1:DisplayObject, param2:Number, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_7:ColorTransform = null;
         var _loc_6:* = this.setup(param3,param4,param5);
         if(param2 > 0)
         {
            _loc_7 = new ColorTransform(param2,param2,param2,1,param2 * 255,param2 * 255,param2 * 255);
         }
         else
         {
            _loc_7 = new ColorTransform(1 + param2,1 + param2,1 + param2);
         }
         _loc_6.to(param1.transform.colorTransform,_loc_7,param1);
         this.add(_loc_6);
         return _loc_6;
      }
      
      public function keyframeTo(param1:Object, param2:int, param3:Number = 0.5, param4:Function = null, param5:Number = 0) : TweensyTimeline
      {
         var _loc_6:* = this.getKeyframe(param1,param2);
         if(this.getKeyframe(param1,param2) == null)
         {
            return null;
         }
         var _loc_7:* = this.setup(param3,param4,param5);
         this.setup(param3,param4,param5).to(param1,_loc_6);
         this.add(_loc_7);
         return _loc_7;
      }
      
      public function addKeyframe(param1:Object, args:*) : void
      {
         var _loc_6:* = undefined;
         var _loc_5:String = null;
         args = {};
         var _loc_4:* = keyframes[param1];
         if(!keyframes[param1])
         {
            _loc_6 = [];
            keyframes[param1] = [];
            _loc_4 = _loc_6;
         }
         _loc_4.push(args);
         for each(_loc_5 in args)
         {
            args[_loc_5] = param1[_loc_5];
         }
      }
      
      public function removeKeyframe(param1:Object, param2:int) : int
      {
         var _loc_3:Array = null;
         if(Boolean(keyframes[param1]))
         {
            _loc_3 = keyframes[param1];
            _loc_3.splice(param2,1);
            return _loc_3.length;
         }
         return -1;
      }
      
      public function getKeyframe(param1:Object, param2:int) : Object
      {
         var _loc_3:* = keyframes[param1];
         if(_loc_3)
         {
            return _loc_3[param2];
         }
         return null;
      }
      
      public function add(param1:TweensyTimeline) : TweensyTimeline
      {
         var _loc_2:Object = null;
         for each(_loc_2 in param1.instances)
         {
            this.addInstance(_loc_2,param1);
         }
         if(!this.hasTimelines)
         {
            this.startUpdate();
         }
         param1.manager = this;
         param1.smartRotate = this.smartRotate;
         param1.snapToClosest = this.snapToClosest;
         param1.autoHide = this.autoHide;
         if(Boolean(this.first))
         {
            this.first.previous = param1;
         }
         else
         {
            this.last = param1;
         }
         param1.next = this.first;
         this.first = param1;
         var _loc_3:* = this;
         var _loc_4:* = this._timelines + 1;
         _loc_3._timelines = _loc_4;
         return param1;
      }
      
      public function remove(param1:TweensyTimeline) : int
      {
         var _loc_3:Object = null;
         if(param1.manager != this)
         {
            return 0;
         }
         if(Boolean(param1.previous))
         {
            param1.previous.next = param1.next;
         }
         if(Boolean(param1.next))
         {
            param1.next.previous = param1.previous;
         }
         if(param1 == this.first)
         {
            this.first = this.first.next;
            if(Boolean(this.first))
            {
               this.first.previous = null;
            }
         }
         if(param1 == this.last)
         {
            this.last = param1.previous;
            if(Boolean(this.last))
            {
               this.last.next = null;
            }
         }
         var _loc_2:* = param1.instances;
         for each(_loc_3 in _loc_2)
         {
            this.removeInstance(_loc_3,param1);
         }
         if(this.useObjectPooling)
         {
            pool.checkIn(param1);
            param1.clear();
         }
         var _loc_4:* = this;
         var _loc_5:* = this._timelines - 1;
         _loc_4._timelines = _loc_5;
         if(!this.hasTimelines)
         {
            this.stopUpdate();
         }
         return this._timelines;
      }
      
      internal function addInstance(param1:Object, param2:TweensyTimeline) : void
      {
         var _loc_7:* = undefined;
         var _loc_4:TweensyTimeline = null;
         var _loc_6:int = 0;
         var _loc_3:* = map[param1];
         if(this.lazyMode)
         {
            if(_loc_3)
            {
               _loc_6 = _loc_3.length - 1;
               while(_loc_6 >= 0)
               {
                  _loc_4 = _loc_3[_loc_6];
                  _loc_4.removeOverlap(param2);
                  _loc_6 -= 1;
               }
            }
         }
         if(!_loc_3)
         {
            _loc_7 = [];
            map[param1] = [];
            _loc_3 = _loc_7;
         }
         _loc_3[_loc_3.length] = param2;
      }
      
      internal function removeInstance(param1:Object, param2:TweensyTimeline) : void
      {
         var _loc_4:int = 0;
         var _loc_3:* = map[param1];
         if(_loc_3)
         {
            _loc_4 = int(_loc_3.indexOf(param2));
            if(_loc_4 != -1)
            {
               _loc_3.splice(_loc_4,1);
               if(_loc_3.length == 0)
               {
                  map[param1] = null;
               }
            }
         }
      }
      
      public function stop(param1:* = null, ... args) : void
      {
         var _loc_4:TweensyTimeline = null;
         var _loc_5:Array = null;
         var _loc_7:int = 0;
         args = map[param1];
         if(Boolean(args))
         {
            _loc_5 = [param1].concat(args);
            _loc_7 = args.length - 1;
            while(_loc_7 >= 0)
            {
               _loc_4 = args[_loc_7];
               _loc_4.stop.apply(null,_loc_5);
               _loc_7 -= 1;
            }
         }
      }
      
      public function stopAll() : void
      {
         var _loc_1:TweensyTimeline = null;
         if(this._timelines > 0)
         {
            _loc_1 = this.first;
         }
         while(Boolean(_loc_1))
         {
            _loc_1.stopAll();
            _loc_1 = _loc_1.next;
         }
      }
      
      public function pause() : void
      {
         this._paused = true;
         var _loc_1:* = this.first;
         while(_loc_1)
         {
            _loc_1.pause();
            _loc_1 = _loc_1.next;
         }
      }
      
      public function resume() : void
      {
         this._paused = false;
         var _loc_1:* = this.first;
         while(_loc_1)
         {
            _loc_1.resume();
            _loc_1 = _loc_1.next;
         }
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function get hasTimelines() : Boolean
      {
         return this._timelines > 0;
      }
      
      public function get timelines() : int
      {
         return this._timelines;
      }
      
      private function setup(param1:Number, param2:Function, param3:Number, param4:Function = null, param5:Array = null) : TweensyTimeline
      {
         var _loc_6:TweensyTimeline = null;
         if(this.useObjectPooling)
         {
            _loc_6 = pool.checkOut();
         }
         else
         {
            _loc_6 = new TweensyTimeline();
         }
         _loc_6.manager = this;
         _loc_6.duration = param1;
         if(param2 != null)
         {
            _loc_6.ease = param2;
         }
         _loc_6.delayStart = param3;
         _loc_6.onComplete = param4;
         _loc_6.onCompleteParams = param5;
         return _loc_6;
      }
      
      private function startUpdate() : void
      {
         this.time = getTimer();
         frame.addEventListener(Event.ENTER_FRAME,this.update,false,0,true);
      }
      
      private function stopUpdate() : void
      {
         frame.removeEventListener(Event.ENTER_FRAME,this.update);
      }
      
      private function update(event:Event) : void
      {
         var _loc_3:TweensyTimeline = null;
         var _loc_2:* = this.first;
         var _loc_4:* = this.secondsPerFrame;
         if(this.refreshType == Tweensy.TIME)
         {
            _loc_4 = getTimer() - this.time;
            this.time += _loc_4;
            _loc_4 *= 0.001;
         }
         while(_loc_2)
         {
            _loc_3 = _loc_2.next;
            if(Boolean(_loc_2.update(_loc_4)))
            {
               this.remove(_loc_2);
            }
            _loc_2 = _loc_3;
         }
         if(this.onUpdate != null)
         {
            this.onUpdate.apply(this,this.onUpdateParams);
         }
         if(!this.hasTimelines && this.onComplete != null)
         {
            this.onComplete.apply(this,this.onCompleteParams);
         }
      }
      
      public function dispose() : void
      {
         if(this.disposed)
         {
            return;
         }
         this.disposed = true;
         this.stopAll();
         this.first = null;
         this.last = null;
         this.onComplete = null;
         this.onCompleteParams = null;
         this.onUpdate = null;
         this.onUpdateParams = null;
         this._timelines = 0;
      }
      
      public function toString() : String
      {
         return "TweensyGroup " + Tweensy.version + " {timelines:" + this._timelines + "}";
      }
   }
}

