package com.midasplayer.candycrushsaga.balance
{
   import com.king.saga.api.crafting.*;
   import com.king.saga.api.listener.*;
   import com.king.saga.api.product.*;
   import com.king.saga.api.response.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.*;
   import com.midasplayer.console.IConsoleCommandProcessor;
   import flash.events.*;
   
   public class Inventory extends EventDispatcher implements IGetBalanceListener, IGetRecipesListener, ICraftListener, IBuyAnyProductListener, IConsoleCommandProcessor
   {
      public static const FIND_TYPE:String = "findType";
      
      public static const FIND_CATEGORY:String = "findCategory";
      
      public static const FIND_POWERUP_CONTEXT:String = "findPowerUpContext";
      
      private var _onBuyAnyProductListener:IBuyAnyProductListener;
      
      private var _pollAfterPurchase:Boolean;
      
      private var _ccBoosters:Vector.<CCBooster>;
      
      private var _ccCharms:Vector.<CCCharm>;
      
      private var _selectedPowerUps:Vector.<CCBooster>;
      
      private var _ingredients:Vector.<ItemInfo>;
      
      private var _recipes:Vector.<Recipe>;
      
      private var _itemTypesToUnlock:Vector.<String>;
      
      private var _ccModel:CCModel;
      
      public var itemUnlockCorrectionDone:Boolean = false;
      
      public function Inventory(param1:CCModel)
      {
         super();
         this._selectedPowerUps = new Vector.<CCBooster>();
         this._ccModel = param1;
         this._ccBoosters = new Vector.<CCBooster>();
         this._ccCharms = new Vector.<CCCharm>();
         this._ingredients = new Vector.<ItemInfo>();
         this._itemTypesToUnlock = new Vector.<String>();
         var _loc_2:* = this._ccModel.getPlayerItems();
         this._ccModel.getRecipes(this);
         this.setUpBoosters(_loc_2);
         this.setUpIngredients(_loc_2);
         this.setUpCharms(_loc_2);
         Console.registerProcessor("craft",this,"Creates item(s). Type in craft, itemType and amount, like: \'craft CandyShuffle 2\'");
         Console.registerProcessor("unlock",this,"Unlock CharmOfExtraLife");
         Console.registerProcessor("buy",this,"Buy Charm of eternal life");
         Console.registerProcessor("activate",this,"Activate CharmOfExtraLife");
      }
      
      private function setUpBoosters(param1:Vector.<ItemInfo>) : void
      {
         var _loc_3:String = null;
         var _loc_4:ItemInfo = null;
         var _loc_5:CCPowerUp = null;
         Console.println("@ func setUpBoosters()");
         var _loc_2:* = BalanceConstants.ALL_BOOSTER_TYPES;
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = this.getSagaItem(param1,Inventory.FIND_TYPE,_loc_3);
            _loc_5 = CCBooster(this.createCCBooster(_loc_3,_loc_4));
            this._ccBoosters.push(_loc_5);
         }
      }
      
      private function createCCBooster(param1:String, param2:ItemInfo = null) : CCPowerUp
      {
         var _loc_4:Boolean = false;
         var _loc_3:* = this.getItemProduct(param1);
         if(Boolean(param2))
         {
            _loc_4 = param2.getAvailability() == BalanceConstants.AVAILABILITY_UNLOCKED ? true : false;
         }
         else
         {
            _loc_4 = false;
         }
         switch(param1)
         {
            case BalanceConstants.BOOSTER_COLORBOMB:
               return new CCBoosterColorBomb(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_EXTRA_TIME:
               return new CCBoosterExtraTime(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_EXTRA_MOVES:
               return new CCBoosterExtraMoves(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_COLOR_REMOVE:
               return new CCBoosterColorRemove(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_COMBO_HELPER:
               return new CCBoosterComboHelper(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_HAMMER:
               return new CCBoosterHammer(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_SWEDISH_FISH:
               return new CCBoosterSwedishFish(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_DOUBLE_SCORE:
               return new CCBoosterDoubleScores(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_COCONUT_LIQUORICE:
               return new CCBoosterCoconutLiquorice(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_MARSHMALLOW:
               return new CCBoosterMarshmallow(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_SHUFFLE:
               return new CCBoosterShuffle(param1,_loc_3,_loc_4);
            case BalanceConstants.BOOSTER_SUGAR_DUSTING:
               return new CCBoosterSugarDusting(param1,_loc_3,_loc_4);
            default:
               return null;
         }
      }
      
      private function setUpCharms(param1:Vector.<ItemInfo>) : void
      {
         var _loc_3:String = null;
         var _loc_4:ItemInfo = null;
         var _loc_5:CCCharm = null;
         Console.println("@ setUpCharms()");
         var _loc_2:* = BalanceConstants.ALL_CHARM_TYPES;
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = this.getSagaItem(param1,Inventory.FIND_TYPE,_loc_3);
            _loc_5 = this.createCCCharm(_loc_3,_loc_4);
            this._ccCharms.push(_loc_5);
         }
      }
      
      private function createCCCharm(param1:String, param2:ItemInfo = null) : CCCharm
      {
         var _loc_4:Boolean = false;
         var _loc_5:CCCharmOfLife = null;
         var _loc_6:ItemProduct = null;
         if(Boolean(param2))
         {
            _loc_4 = param2.getAvailability() == BalanceConstants.AVAILABILITY_UNLOCKED ? true : false;
         }
         else
         {
            _loc_4 = false;
         }
         var _loc_3:* = Boolean(param2) ? param2.getAmount() > 0 : false;
         if(param1 == BalanceConstants.CHARM_OF_LIFE)
         {
            _loc_5 = new CCCharmOfLife(param1,null,_loc_4,_loc_3);
            _loc_5.setExtraLifeproduct(this._ccModel.getExtraLifeProduct());
            return _loc_5;
         }
         _loc_6 = this.getItemProduct(param1);
         switch(param1)
         {
            case BalanceConstants.CHARM_STRIPED_CANDY:
               return new CCCharmStripedCandy(param1,_loc_6,_loc_4,_loc_3);
            case BalanceConstants.CHARM_COLOR_BOMB:
               return new CCCharmColorBomb(param1,_loc_6,_loc_4,_loc_3);
            default:
               return null;
         }
      }
      
      private function setUpIngredients(param1:Vector.<ItemInfo>) : void
      {
         this.updateIngredients(param1);
      }
      
      public function getBalance() : void
      {
         this._ccModel.getItemBalance(this);
      }
      
      public function buyPowerUp(param1:CCPowerUp, param2:IBuyAnyProductListener, param3:Boolean = false) : void
      {
         var _loc_5:int = 0;
         if(Boolean(param2))
         {
            this._onBuyAnyProductListener = param2;
         }
         if(param1 is CCCharmOfLife)
         {
            _loc_5 = CCConstants.CATEGORY_ID_EXTRA_LIFE_PRODUCT;
         }
         else
         {
            _loc_5 = CCConstants.CATEGORY_ID_ITEM_CATEGORY;
         }
         var _loc_4:* = param1.getProductId();
         Console.println("@ buyPowerUp() - Inventory.as : powerup: " + param1.getType() + " | category: " + _loc_5 + " | id: " + _loc_4 + " | listenener: " + param2);
         this._ccModel.buyAnyProduct(_loc_4,_loc_5,this);
         this._pollAfterPurchase = param3;
      }
      
      public function craftBooster(param1:String) : void
      {
         var _loc_2:* = this.getRecipe(param1);
         this._ccModel.craft(this,_loc_2.getName());
      }
      
      public function useBoostersInGame() : void
      {
         var _loc_5:Object = null;
         var _loc_4:uint = 0;
         if(this._selectedPowerUps.length == 0)
         {
            return;
         }
         var _loc_1:* = this._ccModel.getUserActiveEpisode();
         var _loc_2:* = this._ccModel.getUserActiveLevel();
         var _loc_3:* = new Vector.<ItemAmount>();
         while(_loc_4 < this._selectedPowerUps.length)
         {
            _loc_5 = new Object();
            _loc_5.type = this._selectedPowerUps[_loc_4].getType();
            _loc_5.amount = 1;
            _loc_3.push(new ItemAmount(_loc_5));
            _loc_4 += 1;
         }
         this._ccModel.useItemsInGame(this,_loc_3,_loc_1,_loc_2);
         this._selectedPowerUps.length = 0;
      }
      
      public function tryUnlockItem(param1:int, param2:int) : void
      {
         var _loc_4:CCBooster = null;
         var _loc_5:CCCharm = null;
         var _loc_6:uint = 0;
         this._itemTypesToUnlock.length = 0;
         var _loc_3:* = new Vector.<String>();
         for each(_loc_4 in this._ccBoosters)
         {
            if(!_loc_4.getUnlocked() && _loc_4.getUnlockEpisodeId() == param1 && _loc_4.getUnlockLevelId() == param2)
            {
               this._itemTypesToUnlock.push(_loc_4.getType());
               _loc_3.push(BalanceConstants.CATEGORY_BOOSTER);
            }
         }
         for each(_loc_5 in this._ccCharms)
         {
            if(!_loc_5.getUnlocked() && _loc_5.getUnlockEpisodeId() == param1 && _loc_5.getUnlockLevelId() == param2)
            {
               this._itemTypesToUnlock.push(_loc_5.getType());
               _loc_3.push(BalanceConstants.CATEGORY_CHARM);
            }
         }
         _loc_6 = 0;
         while(_loc_6 < this._itemTypesToUnlock.length)
         {
            this._ccModel.unlockItem(this,this._itemTypesToUnlock[_loc_6],_loc_3[_loc_6]);
            _loc_6 += 1;
         }
      }
      
      public function onGetBalance(param1:GetBalanceResponse) : void
      {
         Console.println("@ onGetBalance() - Inventory.as : recieved data from server and updates inventory.");
         this.updateInventory();
         dispatchEvent(new Event(BalanceConstants.EVENT_INVENTORY_HAS_BEEN_UPDATED));
      }
      
      public function onCraft(param1:CraftResponse) : void
      {
         Console.println("@ onCraft() - Inventory.as  : recieved data from server and updates inventory.");
         if(this.setItemUnlockedStartAmount() == true)
         {
            return;
         }
         this.updateInventory();
         dispatchEvent(new Event(BalanceConstants.EVENT_INVENTORY_HAS_BEEN_UPDATED));
      }
      
      public function onGetRecipes(param1:GetRecipesResponse) : void
      {
         this._recipes = param1.getRecipes();
      }
      
      public function onBuyAnyProduct(param1:String, param2:String, param3:int, param4:int) : void
      {
         Console.println("@ onBuyAnyProduct() - Inventory.as | status:" + param1 + " | category:" + param2 + " | id:" + param3 + " | param3:" + param4 + "| poll after purchase:" + this._pollAfterPurchase);
         if(param1 == "ok")
         {
            if(Boolean(this._onBuyAnyProductListener))
            {
               this._onBuyAnyProductListener.onBuyAnyProduct(param1,param2,param3,param4);
            }
            if(this._pollAfterPurchase)
            {
               this._ccModel.poll(null);
            }
            if(param4 == 1)
            {
               this._ccModel.poll(null);
            }
            this._ccModel.getItemBalance(this);
         }
      }
      
      private function setItemUnlockedStartAmount() : Boolean
      {
         var _loc_1:Vector.<String> = null;
         var _loc_2:Vector.<int> = null;
         var _loc_3:int = 0;
         var _loc_4:String = null;
         var _loc_5:CCCharm = null;
         var _loc_6:CCBooster = null;
         if(this._itemTypesToUnlock.length > 0)
         {
            _loc_1 = this._itemTypesToUnlock;
            _loc_2 = new Vector.<int>();
            _loc_3 = 0;
            while(_loc_3 < _loc_1.length)
            {
               for each(_loc_5 in this._ccCharms)
               {
                  if(_loc_5.getType() == _loc_1[_loc_3])
                  {
                     _loc_1.splice(_loc_3,1);
                     _loc_3 -= 1;
                     break;
                  }
               }
               _loc_3++;
            }
            for each(_loc_4 in _loc_1)
            {
               for each(_loc_6 in this._ccBoosters)
               {
                  if(_loc_6.getType() == _loc_4)
                  {
                     _loc_2.push(_loc_6.getStartAmount());
                  }
               }
            }
            this.handOutItemWinnings(_loc_1,_loc_2);
            this._itemTypesToUnlock.length = 0;
            return true;
         }
         return false;
      }
      
      private function updateInventory() : void
      {
         var _loc_1:* = this._ccModel.getPlayerItems();
         this.updateCCBoosters(_loc_1);
         this.updateIngredients(_loc_1);
         this.updateCharms(_loc_1);
      }
      
      private function updateCCBoosters(param1:Vector.<ItemInfo>) : void
      {
         var _loc_3:ItemInfo = null;
         var _loc_4:CCBooster = null;
         var _loc_2:* = this.getSagaItems(param1,BalanceConstants.CATEGORY_BOOSTER);
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = this.getCCBooster(_loc_3.getType());
            if(Boolean(_loc_4))
            {
               _loc_4.update(_loc_3);
            }
         }
      }
      
      private function updateIngredients(param1:Vector.<ItemInfo>) : void
      {
         this._ingredients.length = 0;
         this._ingredients = this.getSagaItems(param1,BalanceConstants.CATEGORY_RESOURCE);
      }
      
      private function updateCharms(param1:Vector.<ItemInfo>) : void
      {
         var _loc_3:ItemInfo = null;
         var _loc_4:CCCharm = null;
         var _loc_2:* = this.getSagaItems(param1,BalanceConstants.CATEGORY_CHARM);
         for each(_loc_3 in _loc_2)
         {
            _loc_4 = this.getCCCharm(_loc_3.getType());
            if(Boolean(_loc_4))
            {
               _loc_4.update(_loc_3);
            }
         }
      }
      
      public function getSagaItem(param1:Vector.<ItemInfo>, param2:String, param3:String, param4:Boolean = true) : ItemInfo
      {
         var _loc_5:ItemInfo = null;
         var _loc_6:Boolean = false;
         for each(_loc_5 in param1)
         {
            if(this.pickSagaItem(_loc_5,param2,param3))
            {
               if(param4)
               {
                  _loc_6 = _loc_5.getAvailability() == BalanceConstants.AVAILABILITY_UNLOCKED ? true : false;
                  if(_loc_6)
                  {
                     return _loc_5;
                  }
               }
            }
         }
         return null;
      }
      
      private function pickSagaItem(param1:ItemInfo, param2:String, param3:String) : Boolean
      {
         switch(param2)
         {
            case Inventory.FIND_CATEGORY:
               if(param1.getCategory() == param3)
               {
                  return true;
               }
               break;
            case Inventory.FIND_TYPE:
               if(param1.getType() == param3)
               {
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function getSagaItems(param1:Vector.<ItemInfo>, param2:String) : Vector.<ItemInfo>
      {
         var _loc_4:ItemInfo = null;
         var _loc_3:* = new Vector.<ItemInfo>();
         for each(_loc_4 in param1)
         {
            if(_loc_4.getCategory() == param2)
            {
               _loc_3.push(_loc_4);
            }
         }
         return _loc_3;
      }
      
      public function getRecipe(param1:String) : Recipe
      {
         var _loc_2:Recipe = null;
         var _loc_3:Vector.<ItemAmount> = null;
         var _loc_4:ItemAmount = null;
         var _loc_5:String = null;
         for each(_loc_2 in this._recipes)
         {
            _loc_3 = _loc_2.getOutputTypeIds();
            _loc_4 = _loc_3[0];
            _loc_5 = _loc_4.getType();
            if(_loc_5 == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getCCPowerUps(param1:String, param2:String, param3:Boolean = true) : Vector.<CCPowerUp>
      {
         var _loc_5:CCPowerUp = null;
         var _loc_6:CCPowerUp = null;
         var _loc_7:Boolean = false;
         var _loc_4:* = new Vector.<CCPowerUp>();
         for each(_loc_5 in this._ccCharms)
         {
            if(param3)
            {
               if(this.pickCCPowerUp(_loc_5,param1,param2))
               {
                  _loc_7 = _loc_5.getUnlocked();
                  if(_loc_7)
                  {
                     _loc_4.push(_loc_5);
                  }
               }
            }
         }
         for each(_loc_6 in this._ccBoosters)
         {
            if(param3)
            {
               if(this.pickCCPowerUp(_loc_6,param1,param2))
               {
                  _loc_7 = _loc_6.getUnlocked();
                  if(_loc_7)
                  {
                     _loc_4.push(_loc_6);
                  }
               }
            }
         }
         return _loc_4;
      }
      
      public function getCCPowerUpByType(param1:String) : CCPowerUp
      {
         var _loc_2:CCBooster = null;
         var _loc_3:CCCharm = null;
         for each(_loc_2 in this._ccBoosters)
         {
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         for each(_loc_3 in this._ccCharms)
         {
            if(_loc_3.getType() == param1)
            {
               return _loc_3;
            }
         }
         return null;
      }
      
      public function getCCBooster(param1:String) : CCBooster
      {
         var _loc_2:CCBooster = null;
         for each(_loc_2 in this._ccBoosters)
         {
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getCCBoosters(param1:String, param2:String, param3:Boolean = true) : Vector.<CCBooster>
      {
         var _loc_5:CCBooster = null;
         var _loc_6:Boolean = false;
         var _loc_4:* = new Vector.<CCBooster>();
         for each(_loc_5 in this._ccBoosters)
         {
            if(this.pickCCPowerUp(_loc_5,param1,param2))
            {
               if(param3)
               {
                  _loc_6 = _loc_5.getUnlocked();
                  if(_loc_6)
                  {
                     _loc_4.push(_loc_5);
                  }
               }
            }
         }
         return _loc_4;
      }
      
      private function pickCCPowerUp(param1:CCPowerUp, param2:String, param3:String) : Boolean
      {
         switch(param2)
         {
            case Inventory.FIND_POWERUP_CONTEXT:
               if(param1.isAllowedInContext(param3))
               {
                  return true;
               }
               break;
         }
         return false;
      }
      
      public function getAvailableBoostersAmount(param1:String) : int
      {
         var _loc_3:CCBooster = null;
         var _loc_2:int = 0;
         for each(_loc_3 in this._ccBoosters)
         {
            if(_loc_3.getUnlocked() == true && _loc_3.isAllowedInContext(param1))
            {
               _loc_2++;
            }
         }
         return _loc_2;
      }
      
      public function addToSelectedBoosters(param1:CCPowerUp) : void
      {
         this._selectedPowerUps.push(param1);
      }
      
      public function getSelectedBoosters() : Vector.<CCBooster>
      {
         return this._selectedPowerUps;
      }
      
      private function getCCCharm(param1:String) : CCCharm
      {
         var _loc_2:CCCharm = null;
         for each(_loc_2 in this._ccCharms)
         {
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getCCCharmByProductId(param1:int) : CCCharm
      {
         var _loc_2:CCCharm = null;
         for each(_loc_2 in this._ccCharms)
         {
            if(_loc_2.getProductId() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
      
      public function getCCCharmList() : Vector.<CCCharm>
      {
         return this._ccCharms;
      }
      
      public function getCCCharms(param1:String, param2:String, param3:Boolean = true) : Vector.<CCCharm>
      {
         var _loc_5:CCCharm = null;
         var _loc_6:Boolean = false;
         var _loc_4:* = new Vector.<CCCharm>();
         for each(_loc_5 in this._ccCharms)
         {
            if(param3)
            {
               _loc_6 = _loc_5.getUnlocked();
               if(_loc_6)
               {
                  _loc_4.push(_loc_5);
               }
            }
         }
         return _loc_4;
      }
      
      public function getAvailableCharmAmount() : int
      {
         var _loc_2:CCBooster = null;
         var _loc_1:int = 0;
         for each(_loc_2 in this._ccCharms)
         {
            if(_loc_2.getUnlocked() == true)
            {
               _loc_1++;
            }
         }
         return _loc_1;
      }
      
      public function getItemAmount(param1:String) : int
      {
         var _loc_3:ItemInfo = null;
         var _loc_2:* = this._ccModel.getPlayerItems();
         for each(_loc_3 in _loc_2)
         {
            if(_loc_3.getType() == param1)
            {
               return _loc_3.getAmount();
            }
         }
         return 0;
      }
      
      private function getItemProduct(param1:String) : ItemProduct
      {
         var _loc_2:* = this._ccModel.getItemProductByType(param1);
         if(_loc_2 == null)
         {
            Console.println("Error: " + "couldn\'t find itemProduct: " + param1);
            return null;
         }
         return _loc_2;
      }
      
      public function correctMissedItemUnlocks() : void
      {
         var _loc_3:CCBooster = null;
         var _loc_4:CCCharm = null;
         var _loc_5:int = 0;
         var _loc_6:int = 0;
         var _loc_7:Boolean = false;
         if(this.itemUnlockCorrectionDone == true)
         {
            return;
         }
         this._itemTypesToUnlock.length = 0;
         var _loc_1:* = this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopEpisode();
         var _loc_2:* = this._ccModel.getUserProfile(this._ccModel.getCurrentUser().getUserId()).getTopLevel();
         for each(_loc_3 in this._ccBoosters)
         {
            _loc_5 = _loc_3.getUnlockEpisodeId();
            _loc_6 = _loc_3.getUnlockLevelId();
            if(!(_loc_3.getUnlocked() == true || _loc_5 == 0 || _loc_6 == 0))
            {
               _loc_7 = false;
               if(_loc_1 > _loc_5)
               {
                  _loc_7 = true;
               }
               else if(_loc_1 == _loc_5)
               {
                  if(_loc_2 >= _loc_6)
                  {
                     _loc_7 = true;
                  }
               }
               if(_loc_7)
               {
                  Console.println("Unlocks booster that has not been succesfully unlocked earlier. " + _loc_3.getType());
                  this._itemTypesToUnlock.push(_loc_3.getType());
                  this._ccModel.unlockItem(this,_loc_3.getType(),BalanceConstants.CATEGORY_BOOSTER);
               }
            }
         }
         for each(_loc_4 in this._ccCharms)
         {
            _loc_5 = _loc_4.getUnlockEpisodeId();
            _loc_6 = _loc_4.getUnlockLevelId();
            if(!(_loc_4.getUnlocked() == true || _loc_5 == 0 || _loc_6 == 0))
            {
               _loc_7 = false;
               if(_loc_1 > _loc_5)
               {
                  _loc_7 = true;
               }
               else if(_loc_1 == _loc_5)
               {
                  if(_loc_2 >= _loc_6)
                  {
                     _loc_7 = true;
                  }
               }
               if(_loc_7)
               {
                  Console.println("Unlocks charm that has not been succesfully unlocked earlier. " + _loc_4.getType());
                  this._itemTypesToUnlock.push(_loc_4.getType());
                  this._ccModel.unlockItem(this,_loc_4.getType(),BalanceConstants.CATEGORY_CHARM);
               }
            }
         }
         this.itemUnlockCorrectionDone = true;
      }
      
      private function handOutItemWinnings(param1:Vector.<String>, param2:Vector.<int>) : void
      {
         var _loc_5:Object = null;
         var _loc_6:ItemAmount = null;
         var _loc_4:int = 0;
         var _loc_3:* = new Vector.<ItemAmount>();
         while(_loc_4 < param1.length)
         {
            _loc_5 = new Object();
            _loc_5.type = param1[_loc_4];
            _loc_5.amount = param2[_loc_4];
            _loc_6 = new ItemAmount(_loc_5);
            _loc_3.push(_loc_6);
            _loc_4++;
         }
         this._ccModel.handOutItemWinnings(this,_loc_3,1,1);
      }
      
      public function processCommand(param1:String, param2:Array) : void
      {
         var _loc_3:String = null;
         var _loc_4:int = 0;
         var _loc_5:Object = null;
         var _loc_6:ItemAmount = null;
         var _loc_7:Vector.<ItemAmount> = null;
         switch(param1)
         {
            case "craft":
               _loc_3 = "CandyColorBomb";
               _loc_4 = 1;
               if(param2.length == 2)
               {
                  _loc_3 = param2[0];
                  _loc_4 = int(param2[1]);
               }
               _loc_5 = new Object();
               _loc_5.type = _loc_3;
               _loc_5.amount = _loc_4;
               _loc_6 = new ItemAmount(_loc_5);
               _loc_7 = new Vector.<ItemAmount>();
               _loc_7.push(_loc_6);
               this._ccModel.handOutItemWinnings(this,_loc_7,1,1);
         }
      }
      
      public function getCCCharmByType(param1:String) : CCCharm
      {
         var _loc_2:CCCharm = null;
         for each(_loc_2 in this._ccCharms)
         {
            if(_loc_2.getType() == param1)
            {
               return _loc_2;
            }
         }
         return null;
      }
   }
}

import flash.events.EventDispatcher;

