package com.king.saga.api.response
{
   import com.king.saga.api.booster.*;
   import com.king.saga.api.crafting.*;
   import com.king.saga.api.event.*;
   import com.king.saga.api.product.*;
   import com.king.saga.api.universe.*;
   import com.king.saga.api.user.*;
   import com.midasplayer.text.*;
   import com.midasplayer.util.*;
   
   public class GameInitResponse
   {
      private var _resources:TypedKeyVal;
      
      private var _currentUser:CurrentUser;
      
      private var _properties:TypedKeyVal;
      
      private var _availableBoosters:Boosters;
      
      private var _userProfiles:UserProfiles;
      
      private var _universeDescription:UniverseDescription;
      
      private var _userUniverse:UserUniverse;
      
      private var _goldProducts:Vector.<GoldProduct>;
      
      private var _itemProducts:Vector.<ItemProduct>;
      
      private var _lifeProducts:Vector.<LifeProduct>;
      
      private var _inviteReward:Vector.<Award>;
      
      private var _levelReward:Vector.<Award>;
      
      private var _extraLifeProducts:Vector.<ExtraLifeProduct>;
      
      private var _collaborationProducts:Vector.<CollaborationProduct>;
      
      private var _ingameProducts:Vector.<IngameProduct>;
      
      private var _events:Vector.<SagaEvent>;
      
      private var _adsEnabled:Boolean;
      
      private var _itemBalance:Vector.<ItemInfo>;
      
      private var _daysSinceInstall:int = 0;
      
      private var _recipes:Vector.<Recipe>;
      
      public function GameInitResponse(param1:Object, param2:IEventFactory = null)
      {
         var _loc_3:TypedKeyVal = null;
         var _loc_5:Object = null;
         var _loc_6:Array = null;
         var _loc_7:Object = null;
         var _loc_8:Array = null;
         var _loc_9:Object = null;
         var _loc_10:Array = null;
         var _loc_11:Object = null;
         var _loc_12:Array = null;
         var _loc_13:Object = null;
         var _loc_14:Array = null;
         var _loc_15:Object = null;
         var _loc_16:Array = null;
         var _loc_17:Object = null;
         var _loc_18:Array = null;
         var _loc_19:Object = null;
         var _loc_20:Object = null;
         var _loc_21:EventParser = null;
         var _loc_22:Array = null;
         var _loc_23:Object = null;
         var _loc_24:Array = null;
         var _loc_25:Object = null;
         var _loc_26:Array = null;
         var _loc_27:Object = null;
         var _loc_28:Array = null;
         var _loc_29:Object = null;
         super();
         this._availableBoosters = new Boosters();
         this._userProfiles = new UserProfiles();
         this._goldProducts = new Vector.<GoldProduct>();
         this._itemProducts = new Vector.<ItemProduct>();
         this._lifeProducts = new Vector.<LifeProduct>();
         this._inviteReward = new Vector.<Award>();
         this._levelReward = new Vector.<Award>();
         this._extraLifeProducts = new Vector.<ExtraLifeProduct>();
         this._collaborationProducts = new Vector.<CollaborationProduct>();
         this._ingameProducts = new Vector.<IngameProduct>();
         this._itemBalance = new Vector.<ItemInfo>();
         this._recipes = new Vector.<Recipe>();
         _loc_3 = new TypedKeyVal(param1);
         if(_loc_3.has("resources"))
         {
            this._resources = new TypedKeyVal(_loc_3.getAsObject("resources"));
         }
         this._currentUser = new CurrentUser(_loc_3.getAsObject("currentUser"));
         var _loc_4:* = _loc_3.getAsArray("availableBoosters");
         for each(_loc_5 in _loc_4)
         {
            this._availableBoosters.add(new Booster(_loc_5));
         }
         _loc_6 = _loc_3.getAsArray("userProfiles");
         for each(_loc_7 in _loc_6)
         {
            this._userProfiles.add(new UserProfile(_loc_7));
         }
         this._universeDescription = new UniverseDescription(_loc_3.getAsObject("universeDescription"));
         this._userUniverse = new UserUniverse(_loc_3.getAsObject("userUniverse"));
         this._properties = new TypedKeyVal(_loc_3.getAsObject("properties"));
         _loc_8 = _loc_3.getAsArray("goldProducts");
         for each(_loc_9 in _loc_8)
         {
            this._goldProducts.push(new GoldProduct(_loc_9));
         }
         _loc_10 = _loc_3.getAsArray("itemProducts");
         for each(_loc_11 in _loc_10)
         {
            this._itemProducts.push(new ItemProduct(_loc_11));
         }
         _loc_12 = _loc_3.getAsArray("lifeProducts");
         for each(_loc_13 in _loc_12)
         {
            this._lifeProducts.push(new LifeProduct(_loc_13));
         }
         _loc_26 = _loc_3.getAsArray("inviteReward");
         for each(_loc_27 in _loc_26)
         {
            this._inviteReward.push(new Award(_loc_27));
         }
         _loc_28 = _loc_3.getAsArray("levelReward");
         for each(_loc_29 in _loc_28)
         {
            this._levelReward.push(new Award(_loc_27));
         }
         _loc_14 = _loc_3.getAsArray("extraLifeProducts");
         for each(_loc_15 in _loc_14)
         {
            this._extraLifeProducts.push(new ExtraLifeProduct(_loc_15));
         }
         _loc_16 = _loc_3.getAsArray("levelProducts");
         for each(_loc_17 in _loc_16)
         {
            this._collaborationProducts.push(new CollaborationProduct(_loc_17));
         }
         _loc_18 = _loc_3.getAsArray("ingameProducts");
         for each(_loc_19 in _loc_18)
         {
            this._ingameProducts.push(new IngameProduct(_loc_19));
         }
         _loc_20 = _loc_3.getAsObject("events");
         _loc_21 = new EventParser(_loc_20,true,param2);
         this._events = _loc_21.getEvents();
         this._adsEnabled = _loc_3.getAsBool("adsEnabled");
         this._daysSinceInstall = _loc_3.getAsInt("daysSinceInstall");
         _loc_22 = _loc_3.getAsArray("itemBalance");
         for each(_loc_23 in _loc_22)
         {
            this._itemBalance.push(new ItemInfo(_loc_23));
         }
         _loc_24 = _loc_3.getAsArray("recipes");
         for each(_loc_25 in _loc_24)
         {
            this._recipes.push(new Recipe(_loc_25));
         }
      }
      
      public function get resources() : TypedKeyVal
      {
         return this._resources;
      }
      
      public function set resources(value:TypedKeyVal) : void
      {
         this._resources = value;
      }
      
      public function get levelReward() : Vector.<Award>
      {
         return this._levelReward;
      }
      
      public function get inviteReward() : Vector.<Award>
      {
         return this._inviteReward;
      }
      
      public function createResource(param1:String) : Replacer
      {
         return new Replacer(this._resources.getAsObject(param1));
      }
      
      public function getResourceAsObject(param1:String) : Object
      {
         return this._resources.getAsObject(param1);
      }
      
      public function getProperties() : TypedKeyVal
      {
         return this._properties;
      }
      
      public function getCurrentUser() : CurrentUser
      {
         return this._currentUser;
      }
      
      public function getAvailableBoosters() : Boosters
      {
         return this._availableBoosters;
      }
      
      public function getUserProfiles() : UserProfiles
      {
         return this._userProfiles;
      }
      
      public function getUniverseDescription() : UniverseDescription
      {
         return this._universeDescription;
      }
      
      public function getUserUniverse() : UserUniverse
      {
         return this._userUniverse;
      }
      
      public function getGoldProducts() : Vector.<GoldProduct>
      {
         return this._goldProducts;
      }
      
      public function getItemProducts() : Vector.<ItemProduct>
      {
         return this._itemProducts;
      }
      
      public function getLifeProducts() : Vector.<LifeProduct>
      {
         return this._lifeProducts;
      }
      
      public function getExtraLifeProducts() : Vector.<ExtraLifeProduct>
      {
         return this._extraLifeProducts;
      }
      
      public function getCollaborationProducts() : Vector.<CollaborationProduct>
      {
         return this._collaborationProducts;
      }
      
      public function getIngameProducts() : Vector.<IngameProduct>
      {
         return this._ingameProducts;
      }
      
      public function getEvents() : Vector.<SagaEvent>
      {
         return this._events;
      }
      
      public function getAdsEnabled() : Boolean
      {
         return this._adsEnabled;
      }
      
      public function getItemBalance() : Vector.<ItemInfo>
      {
         return this._itemBalance;
      }
      
      public function getDaysSinceInstall() : int
      {
         return this._daysSinceInstall;
      }
      
      public function getRecipes() : Vector.<Recipe>
      {
         return this._recipes;
      }
   }
}

