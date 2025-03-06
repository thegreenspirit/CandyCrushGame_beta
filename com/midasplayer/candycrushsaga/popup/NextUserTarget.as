package com.midasplayer.candycrushsaga.popup
{
   import flash.display.*;
   import flash.events.*;
   
   public class NextUserTarget extends Event
   {
      public static const HIGHSCORE_DATA_RECEIVED:String = "highScoreDataReceived";
      
      public var userPic:MovieClip;
      
      public var userScore:Number;
      
      public function NextUserTarget(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc_1:* = new NextUserTarget(this.type,this.bubbles,this.cancelable);
         _loc_1.userPic = this.userPic;
         _loc_1.userScore = this.userScore;
         return _loc_1;
      }
   }
}

import flash.events.Event;

