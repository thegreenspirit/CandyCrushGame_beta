package com.midasplayer.sound
{
   import flash.utils.*;
   
   public class SoundManager
   {
      private var managedSoundMap:Object;
      
      private var managedSounds:Array;
      
      private var lastTime:Number = -1;
      
      public var volume:Number = 1;
      
      private var fadeStartTime:Number = -1;
      
      private var fadeEndTime:Number = -1;
      
      private var fadeStartVolume:Number = -1;
      
      private var fadeEndVolume:Number = -1;
      
      public function SoundManager()
      {
         super();
         this.managedSoundMap = new Object();
         this.managedSounds = new Array();
      }
      
      public function get(param1:String) : ManagedSound
      {
         var _loc_2:Class = null;
         if(this.managedSoundMap[param1] == null)
         {
            _loc_2 = getDefinitionByName(param1) as Class;
            if(_loc_2 == null)
            {
               _loc_2 = getDefinitionByName("sound." + param1) as Class;
            }
            if(_loc_2 == null)
            {
               _loc_2 = getDefinitionByName("snd." + param1) as Class;
            }
            if(_loc_2 == null)
            {
               throw new Error("Failed to find sound " + param1);
            }
            this.managedSoundMap[param1] = new ManagedSound(this,_loc_2);
            this.managedSounds.push(this.managedSoundMap[param1]);
         }
         return this.managedSoundMap[param1];
      }
      
      public function getFromClass(param1:Class) : ManagedSound
      {
         var _loc_2:* = getQualifiedClassName(param1);
         if(this.managedSoundMap[_loc_2] == null)
         {
            this.managedSoundMap[_loc_2] = new ManagedSound(this,param1);
            this.managedSounds.push(this.managedSoundMap[_loc_2]);
         }
         return this.managedSoundMap[_loc_2];
      }
      
      public function fadeTo(param1:Number, param2:Number) : void
      {
         this.fadeStartVolume = Math.sqrt(this.volume);
         this.fadeEndVolume = Math.sqrt(param1);
         this.fadeStartTime = getTimer();
         this.fadeEndTime = getTimer() + param2;
      }
      
      public function setVolume(param1:Number) : void
      {
         this.volume = param1;
         this.fadeStartTime = -1;
      }
      
      public function stopAll() : void
      {
         var _loc_1:int = 0;
         while(_loc_1 < this.managedSounds.length)
         {
            this.managedSounds[_loc_1].stop();
            _loc_1++;
         }
      }
      
      public function update() : void
      {
         var _loc_2:int = 0;
         var _loc_3:Number = NaN;
         var _loc_1:* = getTimer();
         if(this.lastTime < 0)
         {
            this.lastTime = _loc_1;
         }
         if(this.fadeStartTime >= 0)
         {
            _loc_3 = (getTimer() - this.fadeStartTime) / (this.fadeEndTime - this.fadeStartTime);
            if(_loc_3 < 0)
            {
               _loc_3 = 0;
            }
            if(_loc_3 > 1)
            {
               _loc_3 = 1;
            }
            this.volume = this.fadeStartVolume + (this.fadeEndVolume - this.fadeStartVolume) * _loc_3;
            this.volume *= this.volume;
            if(_loc_3 == 1)
            {
               this.fadeStartTime = -1;
            }
         }
         while(_loc_2 < this.managedSounds.length)
         {
            this.managedSounds[_loc_2].update();
            _loc_2++;
         }
      }
   }
}

