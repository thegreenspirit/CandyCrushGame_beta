package com.king.saga.api.response
{
   import com.king.saga.api.event.EventParser;
   import com.king.saga.api.event.IEventFactory;
   import com.king.saga.api.event.SagaEvent;
   import com.king.saga.api.toplist.LevelToplist;
   import com.king.saga.api.user.CurrentUser;
   import com.midasplayer.util.TypedKeyVal;
   
   public class GameEndResponse
   {
      private var _episodeId:int;
      
      private var _levelId:int;
      
      private var _isBestResult:Boolean;
      
      private var _isNewStarLevel:Boolean;
      
      private var _stars:int;
      
      private var _score:Number;
      
      private var _events:Vector.<SagaEvent>;
      
      private var _currentUser:CurrentUser;
      
      private var _levelToplist:LevelToplist;
      
      public function GameEndResponse(param1:Object, param2:Boolean = true, param3:IEventFactory = null)
      {
         var _loc4_:TypedKeyVal = null;
         var _loc5_:Object = null;
         super();
         _loc4_ = new TypedKeyVal(param1);
         this._episodeId = _loc4_.getAsInt("episodeId");
         this._levelId = _loc4_.getAsInt("levelId");
         this._isBestResult = _loc4_.getAsBool("bestResult");
         this._isNewStarLevel = _loc4_.getAsBool("newStarLevel");
         this._stars = _loc4_.getAsInt("stars");
         this._score = _loc4_.getAsIntNumber("score");
         _loc5_ = _loc4_.getAsObject("events");
         var _loc6_:EventParser = new EventParser(_loc5_,param2,param3);
         this._events = _loc6_.getEvents();
         this._currentUser = new CurrentUser(_loc4_.getAsObject("currentUser"));
         this._levelToplist = new LevelToplist(_loc4_.getAsObject("levelToplist"));
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
      
      public function getLevelId() : int
      {
         return this._levelId;
      }
      
      public function isBestResult() : Boolean
      {
         return this._isBestResult;
      }
      
      public function isNewStarLevel() : Boolean
      {
         return this._isNewStarLevel;
      }
      
      public function getStars() : int
      {
         return this._stars;
      }
      
      public function getScore() : Number
      {
         return this._score;
      }
      
      public function getEvents() : Vector.<SagaEvent>
      {
         return this._events;
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
      
      public function getLevelToplist() : LevelToplist
      {
         return this._levelToplist;
      }
   }
}

