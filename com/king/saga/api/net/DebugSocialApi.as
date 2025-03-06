package com.king.saga.api.net
{
   import com.king.saga.api.crafting.ItemAmount;
   import com.king.saga.api.listener.IDepositFundsListener;
   import com.king.saga.api.listener.IEarnFundsListener;
   import flash.utils.setTimeout;
   
   public class DebugSocialApi implements ISocialApi
   {
      public function DebugSocialApi()
      {
         super();
      }
      
      public function reload() : void
      {
      }
      
      public function buyAnyProduct(param1:Function, param2:int, param3:int) : void
      {
         param1("ok","",param2,param3);
      }
      
      public function buyAnyProductTo(param1:Function, param2:int, param3:int, param4:Number) : void
      {
         param1("ok","",param2,param3,param4);
      }
      
      public function buyLifeProduct(param1:Function, param2:int) : void
      {
         this._randomBuyCallback(param1,param2);
      }
      
      public function buyLevelUnlockProduct(param1:Function, param2:int, param3:int, param4:int) : void
      {
         this._randomBuyCallback(param1,param2);
      }
      
      public function buyGoldProduct(param1:Function, param2:int) : void
      {
         this._randomBuyCallback(param1,param2);
      }
      
      public function buyIngameProduct(param1:Function, param2:int) : void
      {
         this._randomBuyCallback(param1,param2);
      }
      
      public function openInviteCollaborationFriendsDialog(param1:String, param2:String, param3:int, param4:int, param5:String = "") : void
      {
      }
      
      public function openShareGoldDialog(param1:String, param2:String, param3:String, param4:String, param5:int, param6:String = null) : void
      {
      }
      
      public function openGiveGoldRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
      }
      
      public function openGiveLifeRequest(param1:String, param2:String, param3:String, param4:String = "") : void
      {
      }
      
      public function openAskForLifeRequest(param1:String, param2:String, param3:String = null, param4:String = "") : void
      {
      }
      
      public function openAcceptLevelUnlockRequest(param1:String, param2:String, param3:String, param4:int, param5:int, param6:String = "") : void
      {
      }
      
      public function notifyProductGiftToUser(param1:String, param2:String, param3:int, param4:int, param5:String, param6:String = "") : void
      {
      }
      
      public function openLikeDialog(param1:Function = null) : void
      {
      }
      
      public function openRateDialog() : void
      {
      }
      
      public function openInviteDialog(param1:String, param2:String, param3:Function = null, param4:String = "") : void
      {
      }
      
      public function openPublishStreamDialog(param1:String, param2:String, param3:String, param4:String) : void
      {
      }
      
      public function openPublishToWallDialog(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String = null) : void
      {
      }
      
      public function earnFunds(param1:IEarnFundsListener) : void
      {
      }
      
      public function depositFunds(param1:IDepositFundsListener) : void
      {
      }
      
      public function hasEarnFunds(param1:IEarnFundsListener) : void
      {
      }
      
      public function hasDepositFunds(param1:IDepositFundsListener) : void
      {
      }
      
      private function _randomBuyCallback(param1:Function, param2:int) : void
      {
         var _loc_3:* = Math.random();
         if(_loc_3 < 0.1)
         {
            param1("ok","",param2);
         }
         else
         {
            setTimeout(param1,10000 * _loc_3,"ok","",param2);
         }
      }
      
      public function buyRecipeTopupProduct(param1:Function, param2:Vector.<ItemAmount>, param3:String) : void
      {
      }
      
      public function openShareItemDialog(param1:String, param2:String, param3:String, param4:String, param5:ItemAmount, param6:String = null) : void
      {
      }
      
      public function shareLevelComplete(param1:int, param2:int, param3:int) : void
      {
      }
      
      public function openGiveItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String, param5:String = "") : void
      {
      }
      
      public function openAskForItemRequest(param1:String, param2:String, param3:ItemAmount, param4:String = null, param5:String = "") : void
      {
      }
      
      public function getDoesLike(param1:Function) : void
      {
      }
      
      public function openGiveLifeToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
      }
      
      public function openGiveGoldToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:String = "") : void
      {
      }
      
      public function openGiveHelpToManyRequest(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:String = "") : void
      {
      }
      
      public function performOpenGraphAction(param1:String, param2:String, param3:int) : void
      {
      }
      
      public function notificationToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
      }
      
      public function sendMapFriendPassedToMany(param1:String, param2:String, param3:Vector.<String>) : void
      {
      }
      
      public function sendToplistFriendBeatenToMany(param1:String, param2:String, param3:Vector.<String>, param4:int, param5:int, param6:int) : void
      {
      }
   }
}

