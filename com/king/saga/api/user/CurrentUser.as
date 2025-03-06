package com.king.saga.api.user
{
   import com.king.saga.api.booster.*;
   import com.king.saga.api.product.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   
   public class CurrentUser
   {
      private var _userId:Number;
      
      public var _lives:int;
      
      private var _gold:Number;
      
      private var _balance:Money;
      
      public var _timeToNextRegeneration:Number;
      
      private var _soundFx:Boolean;
      
      private var _soundMusic:Boolean;
      
      public var _maxLives:int;
      
      private var _immortal:Boolean;
      
      private var _mobileConnected:Boolean;
      
      private var _boosterInventory:BoosterInventory;
      
      private var _unlockedBoosters:Vector.<String>;
      
      private var _credits:Number;
      
      private var _invreward:String;
      
      private var _ivtotal:Number;
      
      public var data:Object;
      
      public function CurrentUser(param1:Object)
      {
         var _loc_4:Object = null;
         super();
         this._unlockedBoosters = new Vector.<String>();
         var _loc_2:TypedKeyVal = new TypedKeyVal(param1);
         this._userId = _loc_2.getAsIntNumber("userId");
         this._lives = _loc_2.getAsInt("lives");
         this._gold = _loc_2.getAsIntNumber("gold");
         this._timeToNextRegeneration = _loc_2.getAsIntNumber("timeToNextRegeneration");
         this._soundFx = _loc_2.getAsBool("soundFx");
         this._soundMusic = _loc_2.getAsBool("soundMusic");
         this._maxLives = _loc_2.getAsInt("maxLives");
         this._immortal = _loc_2.getAsBool("immortal");
         this._mobileConnected = _loc_2.getAsBool("mobileConnected");
         if(_loc_2.has("balance"))
         {
            this._balance = new Money(_loc_2.getAsObject("balance"));
         }
         if(_loc_2.has("boosterInventory"))
         {
            this._boosterInventory = new BoosterInventory(_loc_2.getAsObject("boosterInventory"));
         }
         var _loc_3:* = _loc_2.getAsArray("unlockedBoosters");
         for each(_loc_4 in _loc_3)
         {
            this._unlockedBoosters.push(_loc_4);
         }
         if(!_loc_2.has("credits"))
         {
            this._credits = 0;
         }
         else
         {
            this._credits = _loc_2.getAsNumber("credits");
         }
         if(!_loc_2.has("invreward"))
         {
            this._invreward = "0";
         }
         else
         {
            this._invreward = _loc_2.getAsString("invreward");
         }
         if(!_loc_2.has("ivtotal"))
         {
            this._ivtotal = 0;
         }
         else
         {
            this._ivtotal = _loc_2.getAsNumber("ivtotal");
         }
      }
      
      public function get ivtotal() : Number
      {
         return this._ivtotal;
      }
      
      public function get invreward() : String
      {
         return this._invreward;
      }
      
      public function get credits() : Number
      {
         return this._credits;
      }
      
      public function copy(param1:CurrentUser) : void
      {
         var _loc_2:String = null;
         this._userId = param1._userId;
         this._lives = param1._lives;
         this._gold = param1._gold;
         if(this._balance != null)
         {
            this._balance.copy(param1._balance);
         }
         this._timeToNextRegeneration = param1._timeToNextRegeneration;
         this._soundFx = param1._soundFx;
         this._soundMusic = param1._soundMusic;
         this._maxLives = param1._maxLives;
         this._immortal = param1._immortal;
         if(this._boosterInventory != null)
         {
            this._boosterInventory.copy(param1._boosterInventory);
         }
         this._unlockedBoosters.length = 0;
         for each(_loc_2 in param1._unlockedBoosters)
         {
            this._unlockedBoosters.push(_loc_2);
         }
         this._credits = param1._credits;
         this._invreward = param1._invreward;
         this._ivtotal = param1._ivtotal;
      }
      
      public function getUserId() : Number
      {
         return this._userId;
      }
      
      public function getLives() : int
      {
         return this._lives;
      }
      
      public function getMaxLives() : int
      {
         return this._maxLives;
      }
      
      public function getGold() : Number
      {
         return this._gold;
      }
      
      public function hasBalance() : Boolean
      {
         return this._balance != null;
      }
      
      public function getBalance() : Money
      {
         Debug.assert(this._balance != null,"Trying to get an unexisting balance.");
         return this._balance;
      }
      
      public function getTimeToNextRegeneration() : Number
      {
         return this._timeToNextRegeneration;
      }
      
      public function getSoundFx() : Boolean
      {
         return this._soundFx;
      }
      
      public function getSoundMusic() : Boolean
      {
         return this._soundMusic;
      }
      
      public function getBoosterInventory() : BoosterInventory
      {
         Debug.assert(this._boosterInventory != null,"Trying to get an unexisting boosterInventory.");
         return this._boosterInventory;
      }
      
      public function getUnlockedBoosters() : Vector.<String>
      {
         return this._unlockedBoosters;
      }
      
      public function getInviteTotal() : Number
      {
         return this._ivtotal;
      }
      
      public function getInviteWard() : Array
      {
         if(!this._invreward || this._invreward == "")
         {
            return [];
         }
         return this._invreward.split(",");
      }
      
      public function isBoosterUnlocked(param1:String) : Boolean
      {
         return this._unlockedBoosters.indexOf(param1) != -1;
      }
      
      public function isImmortal() : Boolean
      {
         return this._immortal;
      }
      
      public function isMobileConnected() : Boolean
      {
         return this._mobileConnected;
      }
      
      public function unlockBooster(param1:String) : void
      {
         Debug.assert(!this.isBoosterUnlocked(param1),"Trying to unlock a booster that already is unlocked: " + param1);
         this._unlockedBoosters.push(param1);
      }
      
      public function setGold(param1:Number) : void
      {
         this._gold = param1;
      }
      
      public function getUseForData() : Object
      {
         var data:Object = {};
         data.lives = this._lives;
         data.timeToNextRegeneration = this._timeToNextRegeneration;
         data.maxLives = this._maxLives;
         data.totalStars = 0;
         return data;
      }
   }
}

