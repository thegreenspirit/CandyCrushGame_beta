package com.king.saga.api.product
{
   import com.midasplayer.util.*;
   
   public class CollaborationProduct extends SagaProduct
   {
      private var _noOfInvites:int;
      
      private var _episodeId:int;
      
      public function CollaborationProduct(param1:Object)
      {
         var _loc_2:* = new TypedKeyVal(param1);
         super(_loc_2);
         this._noOfInvites = _loc_2.getAsInt("noOfInvites");
         this._episodeId = _loc_2.getAsInt("episodeId");
      }
      
      public function getNoOfInvites() : int
      {
         return this._noOfInvites;
      }
      
      public function getEpisodeId() : int
      {
         return this._episodeId;
      }
   }
}

