package com.king.saga.api.net
{
   import com.king.saga.api.crafting.*;
   import com.king.saga.api.listener.*;
   import com.midasplayer.debug.*;
   import com.midasplayer.util.*;
   import flash.external.*;
   import flash.system.*;
   
   public class SocialApi implements ISocialApi
   {
      private var _invitePopupCallback:Function;
      
      private var _inviteToTournamentPopupCallback:Function;
      
      private var _anyProductCallback:Function;
      
      private var _anyProductToCallback:Function;
      
      private var _levelUnlockProductCallback:Function;
      
      private var _goldProductCallback:Function;
      
      private var _lifeProductCallback:Function;
      
      private var _ingameProductCallback:Function;
      
      private var _earnFundsListener:IEarnFundsListener;
      
      private var _depositFundsListener:IDepositFundsListener;
      
      private var _recipeTopupProductCallback:Function;
      
      private var _getDoesLikeCallback:Function;
      
      public function SocialApi()
      {
         super();
         Security.allowDomain("*");
         ExternalInterface.addCallback("buyAnyProductCallback",this._buyAnyProductCallback);
         Eventer.getInstance().addEventListener(PayEvent.BUY_ITEM,this._buyAnyProductCallback2);
         Eventer.getInstance().addEventListener(PayEvent.BUY_LIFE,this._buyLifeProductCallback2);
         ExternalInterface.addCallback("buyAnyProductToCallback",this._buyAnyProductToCallback);
         ExternalInterface.addCallback("buyLevelUnlockProductCallback",this._buyLevelUnlockProductCallback);
         ExternalInterface.addCallback("buyGoldProductCallback",this._buyGoldProductCallback);
         ExternalInterface.addCallback("buyLifeProductCallback",this._buyLifeProductCallback);
         ExternalInterface.addCallback("buyIngameProductCallback",this._buyIngameProductCallback);
         ExternalInterface.addCallback("depositFundsCallback",this._depositFundsCallback);
         ExternalInterface.addCallback("earnFundsCallback",this._earnFundsCallback);
         ExternalInterface.addCallback("buyRecipeTopupProductCallback",this._buyRecipeTopupProductCallback);
         ExternalInterface.addCallback("invitePopupClosed",this._invitePopupClosedCallback);
         ExternalInterface.addCallback("setVar",this._setDoesLike);
      }
      
      public static function isAvailable() : Boolean
      {
         return ExternalInterface.available;
      }
      
      public function reload() : void
      {
         ExternalInterface.call("Saga.reload");
      }
      
      public function buyLevelUnlockProduct(param1:Function, param2:int, param3:int, param4:int) : void
      {
         this._levelUnlockProductCallback = param1;
         ExternalInterface.call("Saga.buyLevelUnlockProduct",param2,param3,param4);
      }
      
      public function buyGoldProduct(param1:Function, param2:int) : void
      {
         this._goldProductCallback = param1;
         ExternalInterface.call("Saga.buyGoldProduct",param2);
      }
      
      public function buyLifeProduct(param1:Function, param2:int) : void
      {
         this._lifeProductCallback = param1;
         ExternalInterface.call("Saga.buyLifeProduct",param2);
      }
      
      public function buyIngameProduct(param1:Function, param2:int) : void
      {
         this._ingameProductCallback = param1;
         ExternalInterface.call("Saga.buyIngameProduct",param2);
      }
      
      public function buyAnyProduct(param1:Function, param2:int, param3:int) : void
      {
         this._anyProductCallback = param1;
         ExternalInterface.call("Saga.buyAnyProduct",param2,param3);
      }
      
      public function buyRecipeTopupProduct(param1:Function, param2:Vector.<ItemAmount>, param3:String) : void
      {
         var _loc_5:ItemAmount = null;
         var _loc_6:Object = null;
         var _loc_4:* = new Array();
         for each(_loc_5 in param2)
         {
            _loc_4.push(_loc_5.toObject());
         }
         _loc_6 = new Object();
         this._recipeTopupProductCallback = param1;
         ExternalInterface.call("Saga.buyRecipeTopupProduct",_loc_4,param3);
      }
      
      public function buyAnyProductTo(param1:Function, param2:int, param3:int, param4:Number) : void
      {
         this._anyProductToCallback = param1;
         ExternalInterface.call("Saga.buyAnyProductTo",param2,param3,param4);
      }
      
      public function openInviteCollaborationFriendsDialog(param1:String, param2:String, param3:int, param4:int, param5:String = "") : void
      {
         ExternalInterface.call("Saga.requestLevelUnlock",param1,param2,param3,param4,param5);
      }
      
      public function openAskForLifeRequest(param1:String, param2:String, param3:String = null, param4:String = "") : void
      {
         if(param3 != null)
         {
            ExternalInterface.call("Saga.requestLifeFromUser",param1,param2,param3,param4);
         }
         else
         {
            ExternalInterface.call("Saga.requestLife",param1,param2,param4);
         }
      }
      
      public function openGiveLifeRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         ExternalInterface.call("Saga.giveLifeToUser",param1,param2,param3,param4);
      }
      
      public function openGiveLifeToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
         var _loc_6:String = null;
         var _loc_5:* = new Array();
         for each(_loc_6 in param3)
         {
            _loc_5.push(_loc_6);
         }
         ExternalInterface.call("Saga.giveLifeToMany",param1,param2,_loc_5,param4);
      }
      
      public function openGiveGoldToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
         var _loc_6:String = null;
         var _loc_5:* = new Array();
         for each(_loc_6 in param3)
         {
            _loc_5.push(_loc_6);
         }
         ExternalInterface.call("Saga.giveGoldToMany",param1,param2,_loc_5,param4);
      }
      
      public function openGiveHelpToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:String = "") : void
      {
         var _loc_8:String = null;
         var _loc_7:* = new Array();
         for each(_loc_8 in param3)
         {
            _loc_7.push(_loc_8);
         }
         ExternalInterface.call("Saga.acceptLevelUnlockToMany",param1,param2,_loc_7,param4,param5,param6);
      }
      
      public function openAskForItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String = null, param5:String = "") : void
      {
         var _loc_6:* = param3.toObject();
         if(param4 != null)
         {
            ExternalInterface.call("Saga.requestItemFromUser",param1,param2,_loc_6,param4,param5);
         }
         else
         {
            ExternalInterface.call("Saga.requestItem",param1,param2,_loc_6,param5);
         }
      }
      
      public function openGiveItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String, param5:String = "") : void
      {
         var _loc_6:* = param3.toObject();
         ExternalInterface.call("Saga.giveItemToUser",param1,param2,_loc_6,param4,param5);
      }
      
      public function openGiveGoldRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         ExternalInterface.call("Saga.giveGoldToUser",param1,param2,param3,param4);
      }
      
      public function openAcceptLevelUnlockRequest(param1:String, param2:String, param3:String, param4:int, param5:int, param6:String = "") : void
      {
         ExternalInterface.call("Saga.acceptLevelUnlock",param1,param2,param3,param4,param5,param6);
      }
      
      public function notifyProductGiftToUser(param1:String, param2:String, param3:int, param4:int, param5:String, param6:String = "") : void
      {
         ExternalInterface.call("Saga.notifyProductGiftToUser",param1,param2,param3,param4,param5,param6);
      }
      
      public function openLikeDialog(param1:Function = null) : void
      {
         this._getDoesLikeCallback = param1;
         ExternalInterface.call("Saga.openFanDialog");
      }
      
      public function openRateDialog() : void
      {
         ExternalInterface.call("Saga.openRateDialog");
      }
      
      public function setDoneLoading() : void
      {
         ExternalInterface.call("Saga.setDoneLoading");
      }
      
      public function openInviteDialog(param1:String, param2:String, param3:Function = null, param4:String = "") : void
      {
         this._invitePopupCallback = param3;
         ExternalInterface.call("Saga.inviteFriends",param1,param2,param4);
      }
      
      public function openShareGoldDialog(param1:String, param2:String, param3:String, param4:String, param5:int, param6:String = null) : void
      {
         if(param6 == null)
         {
            ExternalInterface.call("Saga.shareGold",param1,param2,param3,param4,param5);
         }
         else
         {
            ExternalInterface.call("Saga.shareGoldToUser",param1,param2,param3,param4,param5,param6);
         }
      }
      
      public function openShareItemDialog(param1:String, param2:String, param3:String, param4:String, param5:ItemAmount, param6:String = null) : void
      {
         var _loc_7:* = param5.toObject();
         if(param6 == null)
         {
            ExternalInterface.call("Saga.shareItem",param1,param2,param3,param4,_loc_7);
         }
         else
         {
            ExternalInterface.call("Saga.shareItemToUser",param1,param2,param3,param4,_loc_7,param6);
         }
      }
      
      public function shareLevelComplete(param1:int, param2:int, param3:int) : void
      {
         ExternalInterface.call("Saga.shareLevelComplete",param1,param2,param3);
      }
      
      public function earnFunds(param1:IEarnFundsListener) : void
      {
         Debug.assert(param1 != null,"EarnFundsListener is null");
         this._earnFundsListener = param1;
         ExternalInterface.call("Saga.earnFunds");
      }
      
      public function depositFunds(param1:IDepositFundsListener) : void
      {
         Debug.assert(param1 != null,"DepositFundsListener is null");
         this._depositFundsListener = param1;
         ExternalInterface.call("Saga.depositFunds");
      }
      
      public function hasEarnFunds(param1:IEarnFundsListener) : void
      {
         Debug.assert(param1 != null,"EarnFundsListener is null");
         var _loc_2:* = ExternalInterface.call("Saga.hasEarnFunds");
         param1.onHasEarnFunds(_loc_2);
      }
      
      public function hasDepositFunds(param1:IDepositFundsListener) : void
      {
         Debug.assert(param1 != null,"DepositFundsListener is null");
         var _loc_2:* = ExternalInterface.call("Saga.hasDepositFunds");
         param1.onHasDepositFunds(_loc_2);
      }
      
      public function getDoesLike(param1:Function) : void
      {
         this._getDoesLikeCallback = param1;
         ExternalInterface.call("Saga.getDoesLike");
      }
      
      public function performOpenGraphAction(param1:String, param2:String, param3:int) : void
      {
         ExternalInterface.call("Saga.performOpenGraphAction",param1,param2,param3);
      }
      
      public function notificationToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
         var _loc_5:String = null;
         var _loc_4:* = new Array();
         for each(_loc_5 in param3)
         {
            _loc_4.push(_loc_5);
         }
         ExternalInterface.call("Saga.notificationToMany",param1,param2,_loc_4);
      }
      
      public function sendMapFriendPassedToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
         var _loc_5:String = null;
         var _loc_4:* = new Array();
         for each(_loc_5 in param3)
         {
            _loc_4.push(_loc_5);
         }
         ExternalInterface.call("Saga.sendMapFriendPassedToMany",param1,param2,_loc_4);
      }
      
      public function sendToplistFriendBeatenToMany(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:int) : void
      {
         var _loc_8:String = null;
         var _loc_7:* = new Array();
         for each(_loc_8 in param3)
         {
            _loc_7.push(_loc_8);
         }
         ExternalInterface.call("Saga.sendToplistFriendBeatenToMany",param1,param2,_loc_7,param4,param5,param6);
      }
      
      private function _buyAnyProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._anyProductCallback != null,"Trying to buy any product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._anyProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("categoryId"),_loc_2.getAsInt("productId"));
         this._anyProductCallback = null;
      }
      
      private function _buyAnyProductToCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._anyProductToCallback != null,"Trying to buy any product to without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._anyProductToCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("categoryId"),_loc_2.getAsInt("productId"),_loc_2.getAsIntNumber("receiverId"));
         this._anyProductToCallback = null;
      }
      
      private function _buyLevelUnlockProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._levelUnlockProductCallback != null,"Trying to buy level unlock product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._levelUnlockProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("productId"));
         this._levelUnlockProductCallback = null;
      }
      
      private function _buyGoldProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._goldProductCallback != null,"Trying to buy gold product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._goldProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("productId"));
         this._goldProductCallback = null;
      }
      
      private function _buyLifeProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._lifeProductCallback != null,"Trying to buy life product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._lifeProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("productId"));
         this._lifeProductCallback = null;
      }
      
      private function _buyLifeProductCallback2(e:PayEvent) : void
      {
         var _loc_2:Object = null;
         Debug.assert(this._lifeProductCallback != null,"Trying to buy life product without callback.");
         _loc_2 = e.data;
         this._lifeProductCallback(_loc_2.status,"",_loc_2.productId);
         this._lifeProductCallback = null;
      }
      
      private function _buyAnyProductCallback2(e:PayEvent) : void
      {
         var _loc_2:Object = null;
         _loc_2 = e.data;
         this._anyProductCallback(_loc_2.status,"",_loc_2.categoryId,_loc_2.productId);
         this._anyProductCallback = null;
      }
      
      private function _buyIngameProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._ingameProductCallback != null,"Trying to buy ingame product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         this._ingameProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_2.getAsInt("productId"));
         this._ingameProductCallback = null;
      }
      
      private function _buyRecipeTopupProductCallback(param1:Object) : void
      {
         var _loc_2:TypedKeyVal = null;
         Debug.assert(this._recipeTopupProductCallback != null,"Trying to buy recipe topup product without callback.");
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.has("message") ? _loc_2.getAsString("message") : "";
         var _loc_4:* = _loc_2.getAsString("recipe");
         this._recipeTopupProductCallback(_loc_2.getAsString("status"),_loc_3,_loc_4);
         this._recipeTopupProductCallback = null;
      }
      
      private function _earnFundsCallback(param1:String) : void
      {
         this._earnFundsListener.onEarnFunds(param1);
      }
      
      private function _depositFundsCallback(param1:String) : void
      {
         this._depositFundsListener.onDepositFunds(param1);
      }
      
      private function _invitePopupClosedCallback() : void
      {
         if(this._invitePopupCallback != null)
         {
            this._invitePopupCallback();
         }
         this._invitePopupCallback = null;
      }
      
      private function _setDoesLike(param1:String, param2:Boolean) : void
      {
         if(this._getDoesLikeCallback != null)
         {
            this._getDoesLikeCallback(param2);
         }
         this._getDoesLikeCallback = null;
      }
   }
}

