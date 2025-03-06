package com.king.saga.api.event
{
   import com.king.platform.util.KJSON;
   import com.midasplayer.util.TypedKeyVal;
   
   public class EventFactory implements IEventFactory
   {
      public function EventFactory()
      {
         super();
      }
      
      public function create(param1:Object) : SagaEvent
      {
         var _loc_2:TypedKeyVal = null;
         _loc_2 = new TypedKeyVal(param1);
         var _loc_3:* = _loc_2.getAsString("type");
         var _loc_4:* = _loc_2.getAsString("data");
         if(_loc_3 == LevelGoldRewardEvent.Type)
         {
            return new LevelGoldRewardEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == EpisodeGoldRewardEvent.Type)
         {
            return new EpisodeGoldRewardEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == LevelUnlockedEvent.Type)
         {
            return new LevelUnlockedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == EpisodeCompletedEvent.Type)
         {
            return new EpisodeCompletedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == StarAchievementItemUnlockedEvent.Type)
         {
            return new StarAchievementItemUnlockedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ItemGoldRewardEvent.Type)
         {
            return new ItemGoldRewardEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == GameCompletedEvent.Type)
         {
            return new GameCompletedEvent(param1);
         }
         if(_loc_3 == InvalidLevelEvent.Type)
         {
            return new InvalidLevelEvent(param1);
         }
         if(_loc_3 == LevelLockedEvent.Type)
         {
            return new LevelLockedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ToplistFriendBeatenEvent.Type)
         {
            return new ToplistFriendBeatenEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == MapFriendPassedEvent.Type)
         {
            return new MapFriendPassedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == LifeGiftEvent.Type)
         {
            return new LifeGiftEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == LifeRequestEvent.Type)
         {
            return new LifeRequestEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == GoldGiftEvent.Type)
         {
            return new GoldGiftEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ItemGiftEvent.Type)
         {
            return new ItemGiftEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ItemRequestEvent.Type)
         {
            return new ItemRequestEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == MapFriendPassedGoldEvent.Type)
         {
            return new MapFriendPassedGoldEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ToplistFriendBeatenGoldEvent.Type)
         {
            return new ToplistFriendBeatenGoldEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == LevelUnlockRequestEvent.Type)
         {
            return new LevelUnlockRequestEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == UnlockHelpAcceptedEvent.Type)
         {
            return new UnlockHelpAcceptedEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == ProductGiftEvent.Type)
         {
            return new ProductGiftEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == AlternativeGiftEvent.Type)
         {
            return new AlternativeGiftEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == NewFriendPlayingEvent.Type)
         {
            return new NewFriendPlayingEvent(param1,KJSON.parse(_loc_4));
         }
         if(_loc_3 == GeneralEvent.Type)
         {
            return new GeneralEvent(param1,KJSON.parse(_loc_4));
         }
         return null;
      }
   }
}

