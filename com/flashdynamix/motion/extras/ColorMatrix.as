package com.flashdynamix.motion.extras
{
   public dynamic class ColorMatrix extends Array
   {
      public static const identity:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      private static const LUMA_R:Number = 0.212671;
      
      private static const LUMA_G:Number = 0.71516;
      
      private static const LUMA_B:Number = 0.072169;
      
      private var _colorize:Number;
      
      private var _colorizeAmount:Number = 1;
      
      private var _brightness:Number = 0;
      
      private var _threshold:Number = 0;
      
      private var _hueRotation:Number = 0;
      
      private var _saturation:Number = 0;
      
      private var _contrast:Number = 0;
      
      private var degreeRad:Number = 0.0174533;
      
      public function ColorMatrix(param1:Number = 0, param2:Number = 1, param3:Number = 1, param4:Number = 0, param5:Number = -1, param6:int = -1, param7:Number = -1)
      {
         var _loc_9:int = 0;
         var _loc_10:int = 0;
         var _loc_8:int = 0;
         super();
         _loc_10 = 0;
         while(_loc_10 < 4)
         {
            _loc_9 = 0;
            while(_loc_9 < 5)
            {
               this[_loc_8] = identity[_loc_8];
               _loc_8++;
               _loc_9++;
            }
            _loc_10++;
         }
         if(param6 >= 0)
         {
            this.colorize = param6;
         }
         if(param7 >= 0)
         {
            this.colorizeAmount = param7;
         }
         this.brightness = param1;
         this.saturation = param2;
         this.contrast = param3;
         this.hueRotation = param4;
         if(param5 >= 0)
         {
            this.threshold = param5;
         }
      }
      
      public function set colorize(param1:uint) : void
      {
         this._colorize = param1;
         this.applyColorize(this._colorize,this._colorizeAmount);
      }
      
      public function get colorize() : uint
      {
         return this._colorize;
      }
      
      public function set colorizeAmount(param1:Number) : void
      {
         this._colorizeAmount = param1;
         if(!isNaN(this.colorize))
         {
            this.applyColorize(this._colorize,this._colorizeAmount);
         }
      }
      
      public function get colorizeAmount() : Number
      {
         return this._colorizeAmount;
      }
      
      public function set brightness(param1:Number) : void
      {
         this._brightness = param1;
         this.applyBrightness(this._brightness);
      }
      
      public function get brightness() : Number
      {
         return this._brightness;
      }
      
      public function set threshold(param1:Number) : void
      {
         this._threshold = param1;
         this.applyThreshold(this._threshold);
      }
      
      public function get threshold() : Number
      {
         return this._threshold;
      }
      
      public function set hueRotation(param1:Number) : void
      {
         this._hueRotation = param1;
         this.applyHueRotation(this._hueRotation);
      }
      
      public function get hueRotation() : Number
      {
         return this._hueRotation;
      }
      
      public function set saturation(param1:Number) : void
      {
         this._saturation = param1;
         this.applySaturation(this._saturation);
      }
      
      public function get saturation() : Number
      {
         return this._saturation;
      }
      
      public function set contrast(param1:Number) : void
      {
         this._contrast = param1;
         this.applyContrast(this._contrast);
      }
      
      public function get contrast() : Number
      {
         return this._contrast;
      }
      
      private function applyColorize(param1:uint, param2:Number = 1) : void
      {
         var _loc_3:* = (param1 >> 16 & 0xFF) / 255;
         var _loc_4:* = (param1 >> 8 & 0xFF) / 255;
         var _loc_5:* = (param1 & 0xFF) / 255;
         var _loc_6:* = 1 - param2;
         var _loc_7:* = param2 * _loc_3;
         var _loc_8:* = param2 * _loc_4;
         var _loc_9:* = param2 * _loc_5;
         var _loc_10:Array = [_loc_6 + _loc_7 * LUMA_R,_loc_7 * LUMA_G,_loc_7 * LUMA_B,0,0,_loc_8 * LUMA_R,_loc_6 + _loc_8 * LUMA_G,_loc_8 * LUMA_B,0,0,_loc_9 * LUMA_R,_loc_9 * LUMA_G,_loc_6 + _loc_9 * LUMA_B,0,0,0,0,0,1,0];
         this.apply(_loc_10);
      }
      
      private function applyThreshold(param1:Number) : void
      {
         var _loc_2:Array = [LUMA_R * 256,LUMA_G * 256,LUMA_B * 256,0,-256 * param1,LUMA_R * 256,LUMA_G * 256,LUMA_B * 256,0,-256 * param1,LUMA_R * 256,LUMA_G * 256,LUMA_B * 256,0,-256 * param1,0,0,0,1,0];
         this.apply(_loc_2);
      }
      
      private function applyHueRotation(param1:Number) : void
      {
         var _loc_2:* = param1 * this.degreeRad;
         var _loc_3:* = Math.cos(_loc_2);
         var _loc_4:* = Math.sin(_loc_2);
         var _loc_5:Array = [LUMA_R + _loc_3 * (1 - LUMA_R) + _loc_4 * -LUMA_R,LUMA_G + _loc_3 * -LUMA_G + _loc_4 * -LUMA_G,LUMA_B + _loc_3 * -LUMA_B + _loc_4 * (1 - LUMA_B),0,0,LUMA_R + _loc_3 * -LUMA_R + _loc_4 * 0.143,LUMA_G + _loc_3 * (1 - LUMA_G) + _loc_4 * 0.14,LUMA_B + _loc_3 * -LUMA_B + _loc_4 * -0.283,0,0,LUMA_R + _loc_3 * -LUMA_R + _loc_4 * -(1 - LUMA_R),LUMA_G + _loc_3 * -LUMA_G + _loc_4 * LUMA_G,LUMA_B + _loc_3 * (1 - LUMA_B) + _loc_4 * LUMA_B,0,0,0,0,0,1,0];
         this.apply(_loc_5);
      }
      
      private function applyBrightness(param1:Number) : void
      {
         param1 = (param1 + 1) * 255 - 255;
         var _loc_2:Array = [1,0,0,0,param1,0,1,0,0,param1,0,0,1,0,param1,0,0,0,1,0,0,0,0,0,1];
         this.apply(_loc_2);
      }
      
      private function applySaturation(param1:Number) : void
      {
         var _loc_2:* = 1 - param1;
         var _loc_3:* = _loc_2 * LUMA_R;
         var _loc_4:* = _loc_2 * LUMA_G;
         var _loc_5:* = _loc_2 * LUMA_B;
         var _loc_6:Array = [_loc_3 + param1,_loc_4,_loc_5,0,0,_loc_3,_loc_4 + param1,_loc_5,0,0,_loc_3,_loc_4,_loc_5 + param1,0,0,0,0,0,1,0];
         this.apply(_loc_6);
      }
      
      private function applyContrast(param1:Number) : void
      {
         var _loc_2:* = 1 - param1;
         var _loc_3:Array = [param1,0,0,0,128 * _loc_2,0,param1,0,0,128 * _loc_2,0,0,param1,0,128 * _loc_2,0,0,0,1,0];
         this.apply(_loc_3);
      }
      
      public function revert() : void
      {
         var _loc_2:int = 0;
         var _loc_3:int = 0;
         var _loc_1:int = 0;
         _loc_3 = 0;
         while(_loc_3 < 4)
         {
            _loc_2 = 0;
            while(_loc_2 < 5)
            {
               this[_loc_1] = identity[_loc_1];
               _loc_1++;
               _loc_2++;
            }
            _loc_3++;
         }
      }
      
      private function apply(param1:Array) : void
      {
         var _loc_4:int = 0;
         var _loc_5:int = 0;
         var _loc_3:int = 0;
         var _loc_6:int = 0;
         var _loc_2:Array = [];
         _loc_5 = 0;
         while(_loc_5 < 4)
         {
            _loc_4 = 0;
            while(_loc_4 < 5)
            {
               if(_loc_4 == 4)
               {
                  _loc_6 = int(param1[_loc_3 + 4]);
               }
               else
               {
                  _loc_6 = 0;
               }
               _loc_2[_loc_3 + _loc_4] = param1[_loc_3] * this[_loc_4] + param1[_loc_3 + 1] * this[_loc_4 + 5] + param1[_loc_3 + 2] * this[_loc_4 + 10] + param1[_loc_3 + 3] * this[_loc_4 + 15] + _loc_6;
               _loc_4++;
            }
            _loc_3 += 5;
            _loc_5++;
         }
         _loc_3 = 0;
         _loc_5 = 0;
         while(_loc_5 < 4)
         {
            _loc_4 = 0;
            while(_loc_4 < 5)
            {
               this[_loc_3] = _loc_2[_loc_3];
               _loc_3++;
               _loc_4++;
            }
            _loc_5++;
         }
      }
   }
}

