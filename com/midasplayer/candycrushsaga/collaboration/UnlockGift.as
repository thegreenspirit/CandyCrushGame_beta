package com.midasplayer.candycrushsaga.collaboration
{
   public class UnlockGift
   {
      public var episodeId:int;
      
      protected var _fromUserId:Number = 0;
      
      public function UnlockGift(param1:Number, param2:int)
      {
         super();
         this._fromUserId = param1;
         this.episodeId = param2;
      }
      
      public function fromUserId() : Number
      {
         return this._fromUserId;
      }
      
      public function toString() : String
      {
         return "[UnlockGift _fromUserId=" + this._fromUserId + "]";
      }
   }
}

