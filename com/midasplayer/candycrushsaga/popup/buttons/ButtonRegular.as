package com.midasplayer.candycrushsaga.popup.buttons
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   
   public class ButtonRegular extends MCButton
   {
      protected var _clip:MovieClip;
      
      protected var _text:String;
      
      public function ButtonRegular(param1:MovieClip, param2:String, param3:Function)
      {
         var _loc_4:* = param1;
         this._clip = param1;
         super(_loc_4,param3);
         this._text = param2;
         this._setText(param2);
      }
      
      override protected function _onUp() : void
      {
         super._onUp();
         this._setText(this._text);
      }
      
      override protected function _onDown() : void
      {
         super._onDown();
         this._setText(this._text);
      }
      
      override protected function _onOver() : void
      {
         super._onOver();
         this._setText(this._text);
      }
      
      override protected function _onOut() : void
      {
         super._onOut();
         this._setText(this._text);
      }
      
      private function _setText(param1:String) : void
      {
         if(Boolean(this._clip.text))
         {
            this._clip.text.text = param1;
            this._clip.text.embedFonts = false;
            TextUtil.scaleToFit(this._clip.text);
         }
      }
   }
}

