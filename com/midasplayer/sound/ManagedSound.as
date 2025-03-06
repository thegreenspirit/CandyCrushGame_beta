package com.midasplayer.sound
{
   import flash.media.*;
   
   public class ManagedSound
   {
      private var ClassReference:Class;
      
      public var activeSounds:Array;
      
      private var manager:SoundManager;
      
      public function ManagedSound(param1:SoundManager, param2:Class)
      {
         super();
         this.activeSounds = new Array();
         this.manager = param1;
         this.ClassReference = param2;
      }
      
      public function play(param1:Number = 1, param2:Number = 0) : ManagedSoundChannel
      {
         var _loc_3:* = new this.ClassReference().play(0,0,new SoundTransform(param1,param2));
         return new ManagedSoundChannel(this.manager,this,_loc_3);
      }
      
      public function loop(param1:Number = 1, param2:Number = 0, param3:Number = 999999999) : ManagedSoundChannel
      {
         var _loc_4:* = new this.ClassReference().play(0,param3,new SoundTransform(param1,param2));
         return new ManagedSoundChannel(this.manager,this,_loc_4);
      }
      
      public function stop() : void
      {
         var _loc_1:int = 0;
         while(_loc_1 < this.activeSounds.length)
         {
            this.activeSounds[_loc_1].stop();
            _loc_1++;
         }
      }
      
      public function setPan(param1:Number) : void
      {
         var _loc_2:int = 0;
         while(_loc_2 < this.activeSounds.length)
         {
            this.activeSounds[_loc_2].setPan(param1);
            _loc_2++;
         }
      }
      
      public function setVolume(param1:Number) : void
      {
         var _loc_2:int = 0;
         while(_loc_2 < this.activeSounds.length)
         {
            this.activeSounds[_loc_2].setVolume(param1);
            _loc_2++;
         }
      }
      
      public function fadeTo(param1:Number, param2:Number) : void
      {
         var _loc_3:int = 0;
         while(_loc_3 < this.activeSounds.length)
         {
            this.activeSounds[_loc_3].fadeTo(param1,param2);
            _loc_3++;
         }
      }
      
      public function fadeToAndStop(param1:Number, param2:Number) : void
      {
         var _loc_3:int = 0;
         while(_loc_3 < this.activeSounds.length)
         {
            this.activeSounds[_loc_3].fadeToAndStop(param1,param2);
            _loc_3++;
         }
      }
      
      public function panTo(param1:Number, param2:Number) : void
      {
         var _loc_3:int = 0;
         while(_loc_3 < this.activeSounds.length)
         {
            this.activeSounds[_loc_3].panTo(param1,param2);
            _loc_3++;
         }
      }
      
      public function isPlaying() : Boolean
      {
         return this.activeSounds.length > 0;
      }
      
      public function update() : void
      {
         var _loc_1:int = 0;
         while(_loc_1 < this.activeSounds.length)
         {
            this.activeSounds[_loc_1].update();
            _loc_1++;
         }
      }
   }
}

