package com.midasplayer.candycrushsaga.popup.buttons
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.engine.LocalConstants;
   import flash.display.*;
   
   public class ButtonViewVideoAds extends MCButton
   {
      protected var _clip:MovieClip;
      
      protected var _text:String;
      
      protected var _amountStr:String;
      
      public function ButtonViewVideoAds(param1:String, param2:String, param3:Function, param4:MovieClip)
      {
         super(param4,param3);
         this._clip = param4;
         this._text = param1;
         this._amountStr = param2;
         this._setText();
         this._resizeBackground();
      }
      
      override protected function _onUp() : void
      {
         super._onUp();
         this._setText();
         this._resizeBackground();
      }
      
      override protected function _onOut() : void
      {
         super._onOut();
         this._setText();
         this._resizeBackground();
      }
      
      override protected function _onDown() : void
      {
         super._onDown();
         this._setText();
         this._resizeBackground();
      }
      
      override protected function _onOver() : void
      {
         super._onOver();
         this._setText();
         this._resizeBackground();
      }
      
      private function _setText() : void
      {
         if(Boolean(this._clip.text) && Boolean(this._clip.text_hearts))
         {
            this._clip.text.text = this._text;
            this._clip.text.setTextFormat(LocalConstants.FORMAT());
            this._clip.text.embedFonts = false;
            this._clip.text_hearts.text = this._amountStr;
            this._clip.text_hearts.setTextFormat(LocalConstants.FORMAT());
            this._clip.text_hearts.embedFonts = false;
            TextUtil.scaleToFit(this._clip.text);
         }
      }
      
      private function _resizeBackground() : void
      {
         var _loc_1:int = 0;
         if(Boolean(this._clip.background) && Boolean(this._clip.text) && Boolean(this._clip.heart) && Boolean(this._clip.text_hearts) && Boolean(this._clip.videoFrame))
         {
            _loc_1 = 20;
            this._clip.background.width = this._clip.videoFrame.x + this._clip.videoFrame.width - (this._clip.heart.x - this._clip.heart.width * 0.5) + _loc_1;
         }
      }
   }
}

