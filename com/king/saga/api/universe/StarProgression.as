package com.king.saga.api.universe
{
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class StarProgression
   {
      private var _numberOfStars:int;
      
      private var _points:Number;
      
      private var _timeLeftPercent:int;
      
      public function StarProgression(param1:Object)
      {
         super();
         var _loc_2:* = new TypedKeyVal(param1);
         this._numberOfStars = _loc_2.getAsInt("numberOfStars");
         this._points = _loc_2.getAsIntNumber("points",-1);
         this._timeLeftPercent = _loc_2.getAsIntDef("timeLeftPercent",-1);
         Debug.assert(this._points != -1 || this._timeLeftPercent != -1,"A star progression hasn\'t got either points or timeLeftPercent set.");
      }
      
      public function getNumberOfStars() : int
      {
         return this._numberOfStars;
      }
      
      public function getPoints() : Number
      {
         Debug.assert(this._points != -1,"Trying to get an unset field in starprogression (points)");
         return this._points;
      }
      
      public function getTimeLeftPercent() : int
      {
         Debug.assert(this._timeLeftPercent != -1,"Trying to get an unset field in starprogression (timeLeftPercent)");
         return this._timeLeftPercent;
      }
   }
}

