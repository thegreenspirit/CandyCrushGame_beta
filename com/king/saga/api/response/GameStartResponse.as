package com.king.saga.api.response
{
   import com.king.saga.api.user.CurrentUser;
   import com.midasplayer.util.TypedKeyVal;
   
   public class GameStartResponse
   {
      private var _levelData:String;
      
      private var _seed:Number;
      
      private var _currentUser:CurrentUser;
      
      public function GameStartResponse(param1:Object)
      {
         super();
         var _loc2_:TypedKeyVal = new TypedKeyVal(param1);
         this._levelData = _loc2_.getAsString("levelData");
         this._seed = _loc2_.getAsIntNumber("seed");
         this._currentUser = new CurrentUser(_loc2_.getAsObject("currentUser"));
         // hmm?
         this._currentUser._lives -= 1;
         this._currentUser._timeToNextRegeneration = -1;
         if(Boolean(-1))
         {
            this._currentUser._timeToNextRegeneration = 1800;
         }
      }
      
      public function getLevelData() : String
      {
         return this._levelData;
      }
      
      public function getSeed() : Number
      {
         return this._seed;
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
   }
}

