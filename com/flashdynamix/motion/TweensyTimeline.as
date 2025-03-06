package com.flashdynamix.motion
{
   import com.flashdynamix.motion.plugins.*;
   
   public class TweensyTimeline
   {
      public static const YOYO:String = "yoyo";
      
      public static const REPLAY:String = "replay";
      
      public static const LOOP:String = "loop";
      
      public static const NONE:String = null;
      
      public static var defaultTween:Function = easeOut;
      
      private static var defaultArgs:Array = [0,0,1,0];
      
      public var ease:Function;
      
      public var delayStart:Number = 0;
      
      public var delayEnd:Number = 0;
      
      public var repeatType:String;
      
      public var repeats:int = -1;
      
      public var repeatCount:int = 0;
      
      public var repeatEase:Array;
      
      public var smartRotate:Boolean = true;
      
      public var snapToClosest:Boolean = false;
      
      public var autoHide:Boolean = false;
      
      public var onUpdate:Function;
      
      public var onUpdateParams:Array;
      
      public var onComplete:Function;
      
      public var onCompleteParams:Array;
      
      public var onRepeat:Function;
      
      public var onRepeatParams:Array;
      
      internal var manager:TweensyGroup;
      
      internal var next:TweensyTimeline;
      
      internal var previous:TweensyTimeline;
      
      internal var _onComplete:Function;
      
      private var _instances:Array;
      
      public var _tweens:int = 0;
      
      private var _time:Number = 0;
      
      private var _paused:Boolean = false;
      
      private var args:Array;
      
      private var _duration:Number;
      
      private var list:Array;
      
      private var disposed:Boolean = false;
      
      public function TweensyTimeline()
      {
         super();
         this.ease = defaultTween;
         this._instances = [];
         this.args = defaultArgs.concat();
         this.list = [];
      }
      
      public static function empty() : void
      {
         TweensyPluginList.empty();
      }
      
      private static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc_5:* = param1 / param4 - 1;
         param1 = param1 / param4 - 1;
         return param3 * (_loc_5 * param1 * param1 * param1 * param1 + 1) + param2;
      }
      
      public function to(param1:Object, param2:Object, param3:Object = null) : void
      {
         var _loc_4:AbstractTween = null;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         if(param1 is Array)
         {
            _loc_5 = 0;
            _loc_6 = int((param1 as Array).length);
            while(_loc_5 < _loc_6)
            {
               if(param1[_loc_5] is Number || param1[_loc_5] is String)
               {
                  if(!_loc_4)
                  {
                     _loc_4 = this.add(param1,param3);
                  }
                  _loc_4.add(_loc_5.toString(),param2[_loc_5],false);
               }
               else
               {
                  this.to(param1[_loc_5],param2,param3);
               }
               _loc_5++;
            }
         }
         else
         {
            _loc_4 = this.add(param1,param3);
            _loc_4.toTarget(param2);
         }
      }
      
      public function from(param1:Object, param2:Object, param3:Object = null) : void
      {
         var _loc_4:AbstractTween = null;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         if(param1 is Array)
         {
            _loc_5 = 0;
            _loc_6 = int((param1 as Array).length);
            while(_loc_5 < _loc_6)
            {
               if(param1[_loc_5] is Number || param1[_loc_5] is String)
               {
                  if(!_loc_4)
                  {
                     _loc_4 = this.add(param1,param3);
                  }
                  _loc_4.add(_loc_5.toString(),param2[_loc_5],true);
               }
               else
               {
                  this.from(param1[_loc_5],param2,param3);
               }
               _loc_5++;
            }
         }
         else
         {
            _loc_4 = this.add(param1,param3);
            _loc_4.fromTarget(param2);
            _loc_4.apply();
         }
      }
      
      public function fromTo(param1:Object, param2:Object, param3:Object, param4:Object = null) : void
      {
         var _loc_5:AbstractTween = null;
         var _loc_6:int = 0;
         var _loc_7:int = 0;
         if(param1 is Array)
         {
            _loc_6 = 0;
            _loc_7 = int((param1 as Array).length);
            while(_loc_6 < _loc_7)
            {
               if(param1[_loc_6] is Number || param1[_loc_6] is String)
               {
                  if(!_loc_5)
                  {
                     _loc_5 = this.add(param1,param4);
                  }
                  _loc_5.add(_loc_6.toString(),param2[_loc_6],true);
                  _loc_5.add(_loc_6.toString(),param3[_loc_6],false);
               }
               else
               {
                  this.fromTo(param1[_loc_6],param2,param3,param4);
               }
               _loc_6++;
            }
         }
         else
         {
            _loc_5 = this.add(param1,param4);
            _loc_5.fromTarget(param2);
            _loc_5.toTarget(param3);
            _loc_5.apply();
         }
      }
      
      public function updateTo(param1:Object, param2:Object) : void
      {
         var _loc_4:AbstractTween = null;
         var _loc_3:* = this.ease.apply(null,this.args);
         for each(_loc_4 in this.list)
         {
            if(_loc_4.instance == param1)
            {
               _loc_4.updateTo(_loc_3,param2);
            }
         }
      }
      
      public function stop(param1:* = null, ... args) : void
      {
         var _loc_4:AbstractTween = null;
         var _loc_5:int = 0;
         args = param1 is Array ? param1 : (param1 == null ? null : [param1]);
         _loc_5 = this._tweens - 1;
         while(_loc_5 >= 0)
         {
            _loc_4 = this.list[_loc_5];
            if(args == null || args.indexOf(_loc_4.instance) != -1)
            {
               if(args.length == 0)
               {
                  _loc_4.stopAll();
               }
               else
               {
                  _loc_4.stop.apply(null,args);
               }
               if(!_loc_4.hasAnimations)
               {
                  this.remove(_loc_4);
                  this.list.splice(_loc_5,1);
               }
            }
            _loc_5 -= 1;
         }
         if(!this.hasTweens && Boolean(this.manager))
         {
            this.manager.remove(this);
         }
      }
      
      public function stopAll() : void
      {
         this.removeAll();
         if(Boolean(this.manager))
         {
            this.manager.remove(this);
         }
      }
      
      public function update(param1:Number) : Boolean
      {
         var _loc_5:AbstractTween = null;
         var _loc_6:int = 0;
         var _loc_3:Boolean = false;
         var _loc_4:Number = NaN;
         if(this.paused)
         {
            return false;
         }
         this._time += param1;
         var _loc_2:* = this._time - this.delayStart;
         if(_loc_2 > 0)
         {
            _loc_3 = this.finished;
            _loc_2 = _loc_2 > this._duration ? this._duration : _loc_2;
            this.args[0] = _loc_2;
            _loc_4 = Number(this.ease.apply(null,this.args));
            _loc_6 = 0;
            while(_loc_6 < this._tweens)
            {
               _loc_5 = this.list[_loc_6];
               _loc_5.update(_loc_4);
               _loc_6++;
            }
            if(this.onUpdate != null)
            {
               this.onUpdate.apply(null,this.onUpdateParams);
               _loc_3 = this.finished;
            }
            if(_loc_3)
            {
               if(this.canRepeat)
               {
                  if(this.repeatType == YOYO)
                  {
                     this.yoyo();
                  }
                  else if(this.repeatType == REPLAY)
                  {
                     this.replay();
                  }
                  else if(this.repeatType == LOOP)
                  {
                     this.loop();
                  }
                  if(this.onRepeat != null)
                  {
                     this.onRepeat.apply(null,this.onRepeatParams);
                  }
                  _loc_3 = this.finished;
               }
               if(_loc_3)
               {
                  if(this.onComplete != null)
                  {
                     this.onComplete.apply(null,this.onCompleteParams);
                  }
                  _loc_3 = this.finished && !this.canRepeat;
                  if(_loc_3 && this._onComplete != null)
                  {
                     this._onComplete();
                  }
               }
            }
         }
         return _loc_3;
      }
      
      public function pause() : void
      {
         if(this.paused)
         {
            return;
         }
         this._paused = true;
      }
      
      public function resume() : void
      {
         if(!this.paused)
         {
            return;
         }
         this._paused = false;
      }
      
      public function loop() : void
      {
         var _loc_1:AbstractTween = null;
         var _loc_2:Number = NaN;
         for each(_loc_1 in this.list)
         {
            _loc_1.swapToFrom();
         }
         _loc_2 = this.delayStart;
         this.delayStart = this.delayEnd;
         this.delayEnd = _loc_2;
         this.doRepeat();
      }
      
      public function yoyo() : void
      {
         var _loc_1:AbstractTween = null;
         for each(_loc_1 in this.list)
         {
            _loc_1.swapToFrom();
         }
         this.doRepeat();
      }
      
      public function replay() : void
      {
         var _loc_1:AbstractTween = null;
         for each(_loc_1 in this.list)
         {
            _loc_1.update(0);
         }
         this.doRepeat();
      }
      
      public function get canRepeat() : Boolean
      {
         return this.repeatType != NONE && (this.repeats == -1 || this.repeatCount < this.repeats);
      }
      
      public function set position(param1:Number) : void
      {
         var _loc_2:* = param1 * this.totalDuration - this._time;
         this.update(_loc_2);
      }
      
      public function get position() : Number
      {
         return this._time / this.totalDuration;
      }
      
      public function get finished() : Boolean
      {
         return this._time >= this.totalDuration;
      }
      
      public function get totalDuration() : Number
      {
         return this.delayStart + this._duration + this.delayEnd;
      }
      
      public function set time(param1:Number) : void
      {
         this._time = param1;
      }
      
      public function get time() : Number
      {
         return this._time;
      }
      
      public function set duration(param1:Number) : void
      {
         this.args[3] = param1;
         this._duration = param1;
      }
      
      public function get duration() : Number
      {
         return this._duration;
      }
      
      public function set easeParams(param1:Array) : void
      {
         this.args = this.args.slice(0,4).concat(param1);
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function get playing() : Boolean
      {
         return this._time > this.delayStart && this._time < this.delayEnd;
      }
      
      public function get tweens() : int
      {
         return this._tweens;
      }
      
      public function get hasTweens() : Boolean
      {
         return this._tweens > 0;
      }
      
      public function get instances() : Array
      {
         return this._instances;
      }
      
      internal function removeAll() : void
      {
         var _loc_1:AbstractTween = null;
         for each(_loc_1 in this.list)
         {
            this.remove(_loc_1);
         }
         this.list.length = 0;
         this._instances.length = 0;
      }
      
      internal function removeOverlap(param1:TweensyTimeline) : void
      {
         var _loc_2:int = 0;
         var _loc_3:AbstractTween = null;
         var _loc_4:AbstractTween = null;
         if(param1 != this && this.intersects(param1))
         {
            for each(_loc_3 in param1.list)
            {
               _loc_2 = this._tweens - 1;
               while(_loc_2 >= 0)
               {
                  _loc_4 = this.list[_loc_2];
                  _loc_4.removeOverlap(_loc_3);
                  if(!_loc_4.hasAnimations)
                  {
                     this.remove(_loc_4);
                     this.list.splice(_loc_2,1);
                  }
                  _loc_2 -= 1;
               }
            }
            if(!this.hasTweens)
            {
               this.manager.remove(this);
            }
         }
      }
      
      internal function clear() : void
      {
         this.removeAll();
         this.next = null;
         this.previous = null;
         this.args = defaultArgs.concat();
         this.manager = null;
         this.onUpdate = null;
         this.onUpdateParams = null;
         this.onComplete = null;
         this.onCompleteParams = null;
         this.onRepeat = null;
         this.onRepeatParams = null;
         this._onComplete = null;
         this.ease = defaultTween;
         this.delayStart = 0;
         this.delayEnd = 0;
         this.repeatType = NONE;
         this.repeats = -1;
         this.repeatEase = null;
         this.disposed = false;
         this._time = 0;
         this._paused = false;
         this.repeatCount = 0;
      }
      
      private function add(param1:Object, param2:Object = null) : AbstractTween
      {
         var _loc_3:* = TweensyPluginList.checkOut(param1);
         _loc_3.timeline = this;
         _loc_3.construct(param1,param2);
         this._instances.push(_loc_3.instance);
         var _loc_5:* = this;
         _loc_5._tweens = this._tweens + 1;
         var _local5:* = ++this._tweens;
         this.list[_local5] = _loc_3;
         return _loc_3;
      }
      
      private function remove(param1:AbstractTween) : void
      {
         param1.clear();
         TweensyPluginList.checkIn(param1);
         if(Boolean(this.manager))
         {
            this.manager.removeInstance(param1.instance,this);
         }
         this._instances.splice(this._instances.indexOf(param1.instance));
         var _loc_2:* = this;
         var _loc_3:* = this._tweens - 1;
         _loc_2._tweens = _loc_3;
      }
      
      private function intersects(param1:TweensyTimeline) : Boolean
      {
         return param1.delayStart < this.totalDuration - this.time;
      }
      
      private function doRepeat() : void
      {
         this._time = 0;
         var _loc_1:* = this;
         var _loc_2:* = this.repeatCount + 1;
         _loc_1.repeatCount = _loc_2;
         if(Boolean(this.repeatEase))
         {
            this.ease = this.repeatEase[this.repeatCount % this.repeatEase.length];
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
         this.next = null;
         this.previous = null;
         this.args = null;
         this.list = null;
         this.manager = null;
         this.ease = null;
         this.repeatEase = null;
         this.onUpdate = null;
         this.onUpdateParams = null;
         this.onComplete = null;
         this.onCompleteParams = null;
         this.onRepeat = null;
         this.onRepeatParams = null;
      }
      
      public function toString() : String
      {
         return "TweensyTimeline " + Tweensy.version + " {tweens:" + this._tweens + "}";
      }
   }
}

