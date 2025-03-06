package com.king.saga.api.net
{
   import com.king.saga.api.crafting.ItemAmount;
   import com.king.saga.api.listener.IDepositFundsListener;
   import com.king.saga.api.listener.IEarnFundsListener;
   
   public interface ISocialApi
   {
      function buyLifeProduct(param1:Function, param2:int) : void;
      
      function buyLevelUnlockProduct(param1:Function, param2:int, param3:int, param4:int) : void;
      
      function buyGoldProduct(param1:Function, param2:int) : void;
      
      function buyIngameProduct(param1:Function, param2:int) : void;
      
      function buyAnyProduct(param1:Function, param2:int, param3:int) : void;
      
      function buyAnyProductTo(param1:Function, param2:int, param3:int, param4:Number) : void;
      
      function buyRecipeTopupProduct(param1:Function, param2:Vector.<ItemAmount>, param3:String) : void;
      
      function openInviteCollaborationFriendsDialog(param1:String, param2:String, param3:int, param4:int, param5:String = "") : void;
      
      function openShareGoldDialog(param1:String, param2:String, param3:String, param4:String, param5:int, param6:String = null) : void;
      
      function openShareItemDialog(param1:String, param2:String, param3:String, param4:String, param5:ItemAmount, param6:String = null) : void;
      
      function openGiveItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String, param5:String = "") : void;
      
      function openAskForItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String = null, param5:String = "") : void;
      
      function openGiveGoldRequest(param1:String, param2:String, param3:String, param4:String = "") : void;
      
      function openGiveLifeRequest(param1:String, param2:String, param3:String, param4:String = "") : void;
      
      function openAskForLifeRequest(param1:String, param2:String, param3:String = null, param4:String = "") : void;
      
      function openAcceptLevelUnlockRequest(param1:String, param2:String, param3:String, param4:int, param5:int, param6:String = "") : void;
      
      function notifyProductGiftToUser(param1:String, param2:String, param3:int, param4:int, param5:String, param6:String = "") : void;
      
      function openGiveLifeToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void;
      
      function openGiveGoldToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void;
      
      function openGiveHelpToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:String = "") : void;
      
      function performOpenGraphAction(param1:String, param2:String, param3:int) : void;
      
      function notificationToMany(param1:String, param2:String, param3:Vector.<String>) : void;
      
      function sendMapFriendPassedToMany(param1:String, param2:String, param3:Vector.<String>) : void;
      
      function sendToplistFriendBeatenToMany(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:int) : void;
      
      function shareLevelComplete(param1:int, param2:int, param3:int) : void;
      
      function openLikeDialog(param1:Function = null) : void;
      
      function openRateDialog() : void;
      
      function openInviteDialog(param1:String, param2:String, param3:Function = null, param4:String = "") : void;
      
      function earnFunds(param1:IEarnFundsListener) : void;
      
      function depositFunds(param1:IDepositFundsListener) : void;
      
      function hasEarnFunds(param1:IEarnFundsListener) : void;
      
      function hasDepositFunds(param1:IDepositFundsListener) : void;
      
      function getDoesLike(param1:Function) : void;
      
      function reload() : void;
   }
}

