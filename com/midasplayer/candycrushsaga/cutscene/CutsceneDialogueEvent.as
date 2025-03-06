package com.midasplayer.candycrushsaga.cutscene
{
   import flash.events.*;
   
   public class CutsceneDialogueEvent extends Event
   {
      public static const ADD_DIALOGUE:String = "addDialogue";
      
      public var textKey:String;
      
      public function CutsceneDialogueEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc_1:* = new CutsceneDialogueEvent(this.type,this.bubbles,this.cancelable);
         _loc_1.textKey = this.textKey;
         return _loc_1;
      }
   }
}

import flash.events.Event;

