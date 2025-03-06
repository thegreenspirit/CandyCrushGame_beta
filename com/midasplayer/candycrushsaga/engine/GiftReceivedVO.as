package com.midasplayer.candycrushsaga.engine
{
   public class GiftReceivedVO
   {
      public static const GIFT_TYPE_LIFE:String = "giftTypeLife";
      
      public var type:String;
      
      public var friendUserId:Number = 0;
      
      public var friendName:String;
      
      public var numLives:int;
      
      public function GiftReceivedVO(param1:String, param2:Number, param3:String, param4:int)
      {
         super();
         this.type = param1;
         this.friendUserId = param2;
         this.friendName = param3;
         this.numLives = param4;
      }
   }
}

