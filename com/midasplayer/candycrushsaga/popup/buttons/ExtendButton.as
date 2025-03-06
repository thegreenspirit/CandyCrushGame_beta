package com.midasplayer.candycrushsaga.popup.buttons
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ExtendButton
   {
      private var clickSound:String;
      
      protected var _clbPressed:Function;
      
      protected var _buttonClip:MovieClip;
      
      protected var _isPressed:Boolean;
      
      protected var _isActivated:Boolean;
      
      protected var _inputEnabled:Boolean;
      
      public function ExtendButton(param1:MovieClip, txt:String, param2:Function)
      {
         super();
         this._buttonClip = param1;
         this._buttonClip.buttonMode = true;
         this._buttonClip.mouseChildren = false;
         if(Boolean(txt) && txt != "")
         {
            this._buttonClip.text.embedFonts = true;
            this._buttonClip.text.text = txt;
         }
         this._clbPressed = param2;
         this._inputEnabled = true;
         this._isPressed = false;
         this._buttonClip.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._buttonClip.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._buttonClip.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._buttonClip.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.activate();
      }
      
      public function activate() : void
      {
         this._isActivated = true;
         this._buttonClip.gotoAndStop(1);
         this._buttonClip.buttonMode = true;
      }
      
      public function setClickSound(param1:String) : void
      {
         this.clickSound = param1;
      }
      
      public function deactivate() : void
      {
         this._isActivated = false;
         this._buttonClip.gotoAndStop(4);
         this._buttonClip.buttonMode = false;
      }
      
      public function enableInput() : void
      {
         this._inputEnabled = true;
         this._buttonClip.buttonMode = true;
      }
      
      public function disableInput() : void
      {
         this._inputEnabled = false;
         this._buttonClip.buttonMode = false;
         this._onUp();
      }
      
      public function onMouseDown(event:MouseEvent) : void
      {
         if(this._inputEnabled && this._isActivated)
         {
            this._isPressed = true;
            this._onDown();
            if(this.clickSound != null)
            {
               SoundInterface.playSound(this.clickSound);
            }
            else
            {
               SoundInterface.playSound(SoundInterface.CLICK);
            }
         }
         else
         {
            this._isPressed = false;
         }
      }
      
      public function onMouseUp(event:MouseEvent) : void
      {
         if(this._inputEnabled && this._isActivated)
         {
            this._onOver();
            if(this._isPressed && this._clbPressed != null)
            {
               this._clbPressed();
            }
            this._isPressed = false;
         }
      }
      
      public function onMouseOver(event:MouseEvent) : void
      {
         if(!this._isActivated || !this._inputEnabled || this._isPressed)
         {
            return;
         }
         this._onOver();
      }
      
      public function onMouseOut(event:MouseEvent) : void
      {
         if(!this._isActivated || !this._inputEnabled)
         {
            return;
         }
         this._onOut();
      }
      
      protected function _onDown() : void
      {
         this._buttonClip.gotoAndStop(3);
      }
      
      protected function _onUp() : void
      {
         this._buttonClip.gotoAndStop(1);
      }
      
      protected function _onOver() : void
      {
         this._buttonClip.gotoAndStop(2);
      }
      
      protected function _onOut() : void
      {
         this._buttonClip.gotoAndStop(1);
      }
      
      public function isActivated() : Boolean
      {
         return this._isActivated;
      }
      
      public function getClip() : MovieClip
      {
         return this._buttonClip;
      }
      
      public function destruct() : void
      {
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this._buttonClip.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      }
   }
}

