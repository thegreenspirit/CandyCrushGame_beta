package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.popup.buttons.*;
   import com.midasplayer.text.*;
   import flash.display.*;
   import flash.events.*;
   import popup.*;
   import popup.episodeComplete.*;
   
   public class EpisodeCompletedPop extends Popup
   {
      private var _continueButton:ButtonRegular;
      
      private var _clbContinueFunc:Function;
      
      private var _episodeId:int = 0;
      
      public function EpisodeCompletedPop(param1:Function, param2:Function, param3:int)
      {
         popId = "EpisodeCompletedPop";
         super(null,new EpisodeCompleteContent());
         this._clbContinueFunc = param2;
         this._episodeId = param3;
         _popGfx.tTitle.text = I18n.getString("popup_episode_complete_header",param3);
         _popGfx.tMessage.text = I18n.getString("popup_episode_complete_message");
         var _loc_4:* = I18n.getString("popup_episode_complete_button_share");
         this._continueButton = new ButtonRegular(_popGfx.iButtonContinue,_loc_4,this.continueButtonDown);
         this._continueButton.setClickSound(SoundInterface.CLICK_WRAPPED);
         TextUtil.scaleToFit(_popGfx.tTitle);
         TextUtil.scaleToFit(_popGfx.tMessage);
         var _loc_5:* = this.getCompleteGfxForEpisode(param3);
         _popGfx.iEpisodeGfx.iPicContainer.addChild(_loc_5);
      }
      
      private function getCompleteGfxForEpisode(param1:int) : MovieClip
      {
         switch(param1)
         {
            case 1:
               return new TrainEpisodeCompleteGfx();
            case 2:
               return new BoatEpisodeCompleteGfx();
            case 3:
               return new PlaneEpisodeCompleteGfx();
            case 4:
               return new TrainEpisodeCompleteGfx();
            case 5:
               return new TrainEpisodeCompleteGfx();
            case 6:
               return new BoatEpisodeCompleteGfx();
            case 7:
               return new TrainEpisodeCompleteGfx();
            default:
               throw new Error("No episode complete gfx for episode=" + param1);
         }
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      override protected function closeHook() : void
      {
      }
      
      private function continueButtonDown() : void
      {
         if(this._clbContinueFunc != null)
         {
            this._clbContinueFunc(this._episodeId);
         }
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._continueButton.destruct();
         this._continueButton = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

