package com.midasplayer.candycrushsaga.balance
{
   import com.midasplayer.candycrushsaga.ccshared.*;
   import com.midasplayer.candycrushsaga.ccshared.gameconf.*;
   
   public class PowerUpTipster
   {
      private static const _MAX_FAILS:int = 4;
      
      private static const _POINTS_SWEDISH_FISH:Array = [4,0,0,0,1,1,1,1,1,1];
      
      private static const _POINTS_COCONUT_WHEEL:Array = [0,4,0,0,1,1,0.5,1,0.1,0.1];
      
      private static const _POINTS_COLOR_BOMB:Array = [2,1,1,1,0.1,1,1,1,1,1];
      
      private static const _POINTS_CHARM_OF_STRIPED:Array = [2,2,1,1,1,1,1,1,0.1,0.1];
      
      private static const _POINTS_CHARM_OF_LIFE:Array = [0.5,0.5,0.5,0.5,1,1,1,1,1,1];
      
      private static const _POINTS_LOLLIPOP_HAMMER:Array = [2,2,2,0,0.7,1,0.7,1,0.7,0.7];
      
      private static const _POINTS_EXTRA_MOVES:Array = [0.25,0.25,0.25,0,1,1,1,1,1,1];
      
      private var _powerUpTips:Array;
      
      private var _failedLevels:Vector.<FailedLevel>;
      
      public function PowerUpTipster()
      {
         super();
      }
      
      public function pickPowerUpToRecommend(param1:int, param2:int, param3:Inventory, param4:Function, param5:int) : CCPowerUp
      {
         var _loc_12:* = undefined;
         var _loc_13:* = undefined;
         var _loc_6:FailedLevel = null;
         var _loc_7:FailedLevel = null;
         var _loc_8:CCPowerUp = null;
         var _loc_9:LevelInfoVO = null;
         if(!this._failedLevels)
         {
            this._failedLevels = new Vector.<FailedLevel>();
         }
         for each(_loc_7 in this._failedLevels)
         {
            if(_loc_7.episode == param1 && _loc_7.level == param2)
            {
               _loc_12 = _loc_7;
               _loc_13 = _loc_7.failures + 1;
               _loc_12.failures = _loc_13;
               _loc_6 = _loc_7;
               break;
            }
         }
         if(_loc_6 == null)
         {
            _loc_6 = new FailedLevel(param1,param2);
            this._failedLevels.push(_loc_6);
         }
         if(_loc_6.failures >= _MAX_FAILS)
         {
            this._powerUpTips = new Array();
            this._powerUpTips.push(new PowerUpTip(_POINTS_SWEDISH_FISH,BalanceConstants.BOOSTER_SWEDISH_FISH));
            this._powerUpTips.push(new PowerUpTip(_POINTS_COCONUT_WHEEL,BalanceConstants.BOOSTER_COCONUT_LIQUORICE));
            this._powerUpTips.push(new PowerUpTip(_POINTS_COLOR_BOMB,BalanceConstants.BOOSTER_COLORBOMB));
            this._powerUpTips.push(new PowerUpTip(_POINTS_CHARM_OF_STRIPED,BalanceConstants.CHARM_STRIPED_CANDY));
            this._powerUpTips.push(new PowerUpTip(_POINTS_CHARM_OF_LIFE,BalanceConstants.CHARM_OF_LIFE));
            this._powerUpTips.push(new PowerUpTip(_POINTS_LOLLIPOP_HAMMER,BalanceConstants.BOOSTER_HAMMER));
            this._powerUpTips.push(new PowerUpTip(_POINTS_EXTRA_MOVES,BalanceConstants.BOOSTER_EXTRA_MOVES));
            _loc_9 = param4(_loc_6.episode,_loc_6.level);
            _loc_8 = this.pickPowerUp(_loc_9,param3,param5);
            _loc_6.failures = 0;
         }
         if(Boolean(_loc_8))
         {
            return _loc_8;
         }
         return null;
      }
      
      private function pickPowerUp(param1:LevelInfoVO, param2:Inventory, param3:int) : CCPowerUp
      {
         var _loc_4:PowerUpTip = null;
         var _loc_6:PowerUpTip = null;
         var _loc_7:int = 0;
         var _loc_8:PowerUpTip = null;
         var _loc_5:Number = NaN;
         for each(_loc_4 in this._powerUpTips)
         {
            _loc_4.calcPoints(param1);
         }
         this._powerUpTips = this.removePowerUpsAlreadyBought(this._powerUpTips,param2,param3);
         this._powerUpTips.sortOn("pointSum",Array.DESCENDING);
         _loc_5 = 0;
         for each(_loc_6 in this._powerUpTips)
         {
            _loc_5 += _loc_6.pointSum;
         }
         for each(_loc_6 in this._powerUpTips)
         {
            _loc_6.calPercent(_loc_5);
         }
         _loc_7 = Math.round(Math.random() * 100);
         _loc_5 = 0;
         for each(_loc_6 in this._powerUpTips)
         {
            _loc_5 += _loc_6.pointPercent;
            if(_loc_7 <= _loc_5)
            {
               _loc_8 = _loc_6;
               break;
            }
         }
         if(Boolean(_loc_8))
         {
            return param2.getCCPowerUpByType(_loc_8.id);
         }
         return null;
      }
      
      private function removePowerUpsAlreadyBought(param1:Array, param2:Inventory, param3:int) : Array
      {
         var _loc_5:PowerUpTip = null;
         var _loc_6:Boolean = false;
         var _loc_4:int = 0;
         while(_loc_4 < param1.length)
         {
            _loc_5 = param1[_loc_4];
            _loc_6 = false;
            if(param2.getCCPowerUpByType(_loc_5.id).getUnlocked() == false)
            {
               _loc_6 = true;
            }
            if(param2.getItemAmount(_loc_5.id) > 0)
            {
               _loc_6 = true;
            }
            if(_loc_5.id == BalanceConstants.CHARM_OF_LIFE && param3 <= 0)
            {
               Console.println("Powerup removed " + _loc_5.id + "Ugly fix. Player will get a NoMoreLife-popup regardless.");
               _loc_6 = true;
            }
            if(_loc_6)
            {
               param1.splice(_loc_4,1);
               _loc_4 -= 1;
               _loc_5 = null;
            }
            _loc_4++;
         }
         return param1;
      }
      
      private function cleanUp() : void
      {
         while(this._powerUpTips.length > 0)
         {
            this._powerUpTips[0] = null;
            this._powerUpTips.splice(0,1);
         }
         this._powerUpTips = null;
      }
      
      public function traceValues(param1:Vector.<LevelInfoVO>, param2:int, param3:int) : void
      {
         var _loc_4:int = 0;
         var _loc_5:LevelInfoVO = null;
         var _loc_6:Boolean = false;
         var _loc_7:Array = null;
         var _loc_8:PowerUpTip = null;
         var _loc_10:String = null;
         var _loc_9:Number = NaN;
         Console.println("POWERUP TIP VALUES ---------------------------------------------");
         if(!param2 == 0)
         {
            _loc_4 = 0;
            while(_loc_4 < param1.length)
            {
               _loc_5 = param1[_loc_4];
               _loc_6 = false;
               if(_loc_5.episodId != param2)
               {
                  _loc_6 = true;
               }
               else if(param3 != 0 && _loc_5.levelId != param3)
               {
                  _loc_6 = true;
               }
               if(_loc_6)
               {
                  param1.splice(_loc_4,1);
                  _loc_4 -= 1;
                  _loc_5 = null;
               }
               _loc_4++;
            }
         }
         for each(_loc_5 in param1)
         {
            _loc_7 = new Array();
            _loc_7.push(new PowerUpTip(_POINTS_SWEDISH_FISH,BalanceConstants.BOOSTER_SWEDISH_FISH));
            _loc_7.push(new PowerUpTip(_POINTS_COCONUT_WHEEL,BalanceConstants.BOOSTER_COCONUT_LIQUORICE));
            _loc_7.push(new PowerUpTip(_POINTS_COLOR_BOMB,BalanceConstants.BOOSTER_COLORBOMB));
            _loc_7.push(new PowerUpTip(_POINTS_CHARM_OF_STRIPED,BalanceConstants.CHARM_STRIPED_CANDY));
            _loc_7.push(new PowerUpTip(_POINTS_CHARM_OF_LIFE,BalanceConstants.CHARM_OF_LIFE));
            _loc_7.push(new PowerUpTip(_POINTS_LOLLIPOP_HAMMER,BalanceConstants.BOOSTER_HAMMER));
            _loc_7.push(new PowerUpTip(_POINTS_EXTRA_MOVES,BalanceConstants.BOOSTER_EXTRA_MOVES));
            for each(_loc_8 in _loc_7)
            {
               _loc_8.calcPoints(_loc_5);
            }
            _loc_7.sortOn("pointSum",Array.DESCENDING);
            _loc_9 = 0;
            for each(_loc_8 in _loc_7)
            {
               _loc_8.calcPoints(_loc_5);
               _loc_9 += _loc_8.pointSum;
            }
            for each(_loc_8 in _loc_7)
            {
               _loc_8.calPercent(_loc_9);
            }
            Console.println("-------------------------------------------------------------------------");
            Console.println("Episode: " + _loc_5.episodId + " Level: " + _loc_5.levelId);
            for each(_loc_8 in _loc_7)
            {
               _loc_10 = "   ";
               if(_loc_8.pointPercent > 9)
               {
                  _loc_10 = "  ";
               }
               else if(_loc_8.pointPercent > 99)
               {
                  _loc_10 = "";
               }
               Console.println(_loc_8.pointPercent + _loc_10 + "% " + _loc_8.id);
            }
         }
      }
   }
}

class FailedLevel
{
   public var episode:int;
   
   public var level:int;
   
   public var failures:int = 0;
   
   public function FailedLevel(param1:int, param2:int)
   {
      super();
      this.episode = param1;
      this.level = param2;
      this.failures = 1;
   }
}

import com.midasplayer.candycrushsaga.ccshared.gameconf.LevelInfoVO;

class PowerUpTip
{
   public var pointMap:Array;
   
   public var pointSum:Number;
   
   public var pointPercent:int;
   
   public var id:String;
   
   public function PowerUpTip(param1:Array, param2:String)
   {
      super();
      this.pointMap = param1;
      this.id = param2;
      this.pointSum = 1;
   }
   
   public function calcPoints(param1:LevelInfoVO) : void
   {
      if(param1.isLightUpMode)
      {
         this.pointSum *= this.pointMap[0];
      }
      else if(param1.isDropDownMode)
      {
         this.pointSum *= this.pointMap[1];
      }
      else if(param1.isClassicMovesMode)
      {
         this.pointSum *= this.pointMap[2];
      }
      else if(param1.isTimeMode)
      {
         this.pointSum *= this.pointMap[3];
      }
      if(param1.hasFrosting)
      {
         this.pointSum *= this.pointMap[4];
      }
      if(param1.hasLiqLock)
      {
         this.pointSum *= this.pointMap[5];
      }
      if(param1.hasChocolate)
      {
         this.pointSum *= this.pointMap[6];
      }
      if(param1.hasVisibleTeleporter)
      {
         this.pointSum *= this.pointMap[7];
      }
      if(param1.hasLiqSquare)
      {
         this.pointSum *= this.pointMap[8];
      }
      if(param1.hasPepperCandy)
      {
         this.pointSum *= this.pointMap[9];
      }
   }
   
   public function calPercent(param1:Number) : void
   {
      this.pointPercent = Math.round(this.pointSum / param1 * 100);
   }
}

