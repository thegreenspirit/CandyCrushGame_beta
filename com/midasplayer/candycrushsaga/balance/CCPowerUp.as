package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.crafting.ItemInfo;
   import com.king.saga.api.product.ItemProduct;
   
   public class CCPowerUp
   {
      protected var _category:String;
      
      protected var _unlocked:Boolean;
      
      protected var _type:String;
      
      protected var _gameModes:Array;
      
      protected var _triggerContext:String;
      
      protected var _itemProduct:ItemProduct;
      
      protected var _unlockEpisodeId:int;
      
      protected var _unlockLevelId:int;
      
      protected var _isPopActivated:Boolean;
      
      protected var _craftable:Boolean;
      
      protected var _autoGenerating:Boolean;
      
      protected var _cap:int = -1;
      
      protected var _cooldown:int = -1;
      
      protected var _duration:int = -1;
      
      protected var _startAmount:int = 3;
      
      public function CCPowerUp(param1:String, param2:ItemProduct, param3:Boolean = false)
      {
         super();
         this._type = param1;
         this._itemProduct = param2;
         this._unlocked = param3;
         this._isPopActivated = false;
         this._craftable = true;
         this._autoGenerating = false;
      }
      
      public function update(param1:ItemInfo) : void
      {
         var _loc_2:* = param1.getAvailability() == BalanceConstants.AVAILABILITY_UNLOCKED ? true : false;
         this._unlocked = _loc_2;
      }
      
      public function getType() : String
      {
         return this._type;
      }
      
      public function isAllowedInContext(param1:String) : Boolean
      {
         if(this._triggerContext == BalanceConstants.POWERUP_TRIGGER_CONTEXT_ALL || this._triggerContext == param1)
         {
            return true;
         }
         return false;
      }
      
      public function acceptedInGameMode(param1:String) : Boolean
      {
         var _loc_2:String = null;
         for each(_loc_2 in this._gameModes)
         {
            if(_loc_2 == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasCap() : Boolean
      {
         if(this._cap != -1)
         {
            return true;
         }
         return false;
      }
      
      public function getCap() : int
      {
         return this._cap;
      }
      
      public function hasCooldown() : Boolean
      {
         if(this._cooldown != -1)
         {
            return true;
         }
         return false;
      }
      
      public function getCooldown() : int
      {
         return this._cooldown;
      }
      
      public function getDuration() : int
      {
         return this._duration;
      }
      
      public function getProductId() : int
      {
         return this._itemProduct.getId();
      }
      
      public function getCost() : int
      {
         return this._itemProduct.getCost().getAmount();
      }
      
      public function getCurrency() : String
      {
         return this._itemProduct.getCost().getCurrency();
      }
      
      public function getUnlocked() : Boolean
      {
         return this._unlocked;
      }
      
      public function getUnlockEpisodeId() : int
      {
         return this._unlockEpisodeId;
      }
      
      public function getUnlockLevelId() : int
      {
         return this._unlockLevelId;
      }
      
      public function setPopActivated(param1:Boolean, param2:String) : void
      {
         if(this.acceptedInGameMode(param2))
         {
            this._isPopActivated = param1;
         }
      }
      
      public function getPopActivated() : Boolean
      {
         return this._isPopActivated;
      }
      
      public function getCraftable() : Boolean
      {
         return this._craftable;
      }
      
      public function getAutoGenerating() : Boolean
      {
         return this._autoGenerating;
      }
      
      public function getStartAmount() : int
      {
         return this._startAmount;
      }
      
      public function needPollAfterPurchase() : Boolean
      {
         if(this is CCCharmOfLife)
         {
            return true;
         }
         return false;
      }
      
      public function isABooster() : Boolean
      {
         if(this._category == BalanceConstants.CATEGORY_BOOSTER)
         {
            return true;
         }
         if(this._category == BalanceConstants.CATEGORY_CHARM)
         {
            return false;
         }
         return false;
      }
   }
}

