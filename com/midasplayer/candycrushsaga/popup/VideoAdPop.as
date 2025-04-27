package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import com.midasplayer.candycrushsaga.popup.buttons.ButtonViewVideoAds;
   import com.midasplayer.text.*;
   import flash.events.*;
   import popup.*;
   
   public class VideoAdPop extends Popup
   {
      private var _videoButton:ButtonViewVideoAds;
      
      private var viewVideoCb:Function;
      
      private var closeFn:Function;
      
      public function VideoAdPop(param1:Function, param2:Function)
      {
         super(null,new VideoAdContent());
         popId = "VideoAdPop";
         this.closeFn = param2;
         this.viewVideoCb = param1;
         _popGfx.text_header.text = I18n.getString("popup_videoad_header");
         _popGfx.text_header.setTextFormat(LocalConstants.FORMAT("PT Banana Split"));
         _popGfx.text_header.embedFonts = false;
         _popGfx.text_message.text = I18n.getString("popup_videoad_message");
         _popGfx.text_message.setTextFormat(LocalConstants.FORMAT());
         _popGfx.text_message.embedFonts = false;
         this._videoButton = new ButtonViewVideoAds(I18n.getString("popup_videoad_btn_view"),String(1),this.videoButtonDown,_popGfx.button_view);
      }
      
      override public function triggerCommand() : void
      {
         super.triggerCommand();
      }
      
      private function videoButtonDown() : void
      {
         this.viewVideoCb();
         dispatchEvent(new Event(CCConstants.DEACTIVATE_QUEUE_ELEMENT));
      }
      
      override protected function closeHook() : void
      {
         if(this.closeFn != null)
         {
            this.closeFn();
         }
      }
      
      override public function destruct() : void
      {
         super.destruct();
         this._videoButton.destruct();
         this._videoButton = null;
         this.viewVideoCb = null;
         this.closeFn = null;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

