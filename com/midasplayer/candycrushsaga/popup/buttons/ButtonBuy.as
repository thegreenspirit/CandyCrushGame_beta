package com.midasplayer.candycrushsaga.popup.buttons
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   
   public class ButtonBuy extends MCButton
   {
      protected var _clip:MovieClip;
      
      protected var _text:String;
      
      protected var _value:String;
      
      public function ButtonBuy(param1:MovieClip, param2:String, param3:String, param4:Function)
      {
         var _loc_5:* = param1;
         this._clip = param1;
         super(_loc_5,param4);
         this._text = param2;
         this._value = param3;
         this._setText(param2,param3);
      }
      
      override protected function _onUp() : void
      {
         super._onUp();
         this._setText(this._text,this._value);
      }
      
      override protected function _onDown() : void
      {
         super._onDown();
         this._setText(this._text,this._value);
      }
      
      override protected function _onOver() : void
      {
         super._onOver();
         this._setText(this._text,this._value);
      }
      
      override protected function _onOut() : void
      {
         super._onOut();
         this._setText(this._text,this._value);
      }
      
      private function _setText(param1:String, param2:String) : void
      {
         if(Boolean(this._clip.text))
         {
            this._clip.text.text = param1;
            TextUtil.scaleToFit(this._clip.text);
         }
         if(Boolean(this._clip.value))
         {
            this._clip.value.text = param2;
            TextUtil.scaleToFit(this._clip.value);
         }
      }
   }
}

