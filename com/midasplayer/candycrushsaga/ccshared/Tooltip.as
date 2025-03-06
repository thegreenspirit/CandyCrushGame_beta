package com.midasplayer.candycrushsaga.ccshared
{
   import com.greensock.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   import flash.text.*;
   
   public class Tooltip
   {
      private var _type:String;
      
      private var _clip:MovieClip;
      
      private var _tweensOut:Boolean;
      
      private var _currentTween:TweenLite;
      
      private var _displayBase:MovieClip;
      
      private var _listener:MovieClip;
      
      private var _message:String;
      
      private var _offsetPoint:Point;
      
      public function Tooltip(param1:MovieClip, param2:Function, param3:MovieClip, param4:String, param5:String, param6:Point = null)
      {
         super();
         this._displayBase = param1;
         this._clip = param2();
         this._listener = param3;
         this._message = param4;
         this._type = param5;
         this._offsetPoint = param6;
         this._tweensOut = false;
         this._clip.mouseEnabled = false;
         this._clip.mouseChildren = false;
         this._listener.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._listener.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._listener.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._clip.alpha = 0;
      }
      
      private function onMouseMove(event:MouseEvent) : void
      {
         this.setPosition();
      }
      
      private function onMouseOver(event:MouseEvent) : void
      {
         if(this._currentTween != null)
         {
            this._currentTween.kill();
         }
         if(this._clip.parent == null || this._tweensOut == true)
         {
            this._tweensOut = false;
            this._clip.tTooltip.text = this._message;
            TextUtil.scaleToFit(this._clip.tTooltip);
            this._displayBase.addChild(this._clip);
            this.resize();
            this.setPosition();
            this._currentTween = TweenLite.to(this._clip,0.5,{"alpha":1});
         }
      }
      
      private function resize() : void
      {
         this._clip.tTooltip.autoSize = TextFieldAutoSize.CENTER;
         this._clip.iBG.height = this._clip.tTooltip.height + 10;
         if(this._clip.tTooltip.textWidth < 190)
         {
            this._clip.iBG.width = this._clip.tTooltip.textWidth + 20;
         }
         this._clip.tTooltip.y = this._clip.iBG.height / 2 - this._clip.tTooltip.height / 2;
         this._clip.tTooltip.x = this._clip.iBG.width / 2 - this._clip.tTooltip.width / 2 + 1;
      }
      
      private function setPosition() : void
      {
         this._clip.x = Math.max(0,this._displayBase.mouseX - this._clip.iBG.width / 2);
         if(this._clip.x + this._clip.width / 2 > CCConstants.STAGE_WIDTH)
         {
            this._clip.x = CCConstants.STAGE_WIDTH - this._clip.width / 2;
         }
         this._clip.y = Math.max(0,this._displayBase.mouseY - this._clip.iBG.height - 10);
      }
      
      private function onMouseOut(event:MouseEvent) : void
      {
         if(this._currentTween != null)
         {
            this._currentTween.kill();
         }
         if(this._clip.parent != null)
         {
            this._currentTween = TweenLite.to(this._clip,0.5,{
               "alpha":0,
               "onComplete":this.removeTooltip
            });
            this._tweensOut = true;
         }
      }
      
      private function removeTooltip() : void
      {
         if(Boolean(this._clip))
         {
            if(this._clip.parent != null)
            {
               this._clip.parent.removeChild(this._clip);
               this._tweensOut = false;
            }
         }
      }
      
      public function getType() : String
      {
         return this._type;
      }
      
      public function destruct() : void
      {
         this._listener.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         this._listener.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         this._listener.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         if(Boolean(this._clip))
         {
            if(this._clip.parent != null)
            {
               this._clip.parent.removeChild(this._clip);
            }
            this._clip = null;
         }
      }
   }
}

