package com.midasplayer.candycrushsaga.world
{
   import flash.events.*;
   
   public class WorldEvent extends Event
   {
      public static const PLAY_LEVEL:String = "playLevel";
      
      public static const CLICK_COLLAB:String = "clickCollab";
      
      public static const TWEEN_COMPLETE:String = "tweenComplete";
      
      public var episode_id:int;
      
      public var level_id:int;
      
      public function WorldEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc_1:* = new WorldEvent(this.type,this.bubbles,this.cancelable);
         _loc_1.level_id = this.level_id;
         _loc_1.episode_id = this.episode_id;
         return _loc_1;
      }
   }
}

import flash.events.Event;

