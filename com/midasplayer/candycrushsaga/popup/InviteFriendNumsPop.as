package com.midasplayer.candycrushsaga.popup
{
   import com.midasplayer.candycrushsaga.engine.CCModel;
   import com.midasplayer.candycrushsaga.popup.buttons.ExtendButton;
   import com.midasplayer.text.I18n;
   import flash.external.ExternalInterface;
   
   public class InviteFriendNumsPop extends Popup
   {
      private var btna:ExtendButton;
      
      private var btnb:ExtendButton;
      
      private var btnc:ExtendButton;
      
      private var btnd:ExtendButton;
      
      private var btne:ExtendButton;
      
      private var btnf:ExtendButton;
      
      private var ivtotal:int = 0;
      
      private var inverward:Array;
      
      private var ccmain:CCMain;
      
      public function InviteFriendNumsPop(param1:int, param2:Array, param3:CCMain)
      {
         this.ivtotal = param1;
         this.inverward = param2;
         this.ccmain = param3;
         super(null,new AmoutAwardMC());
         this.initdata(param1);
      }
      
      private function initdata(param1:int) : void
      {
         var funcb:Function = null;
         var funcc:Function = null;
         var funcd:Function = null;
         var funce:Function = null;
         var funcf:Function = null;
         funcb = function():void
         {
            getAward(2);
         };
         funcc = function():void
         {
            getAward(50);
         };
         funcd = function():void
         {
            getAward(10);
         };
         funce = function():void
         {
            getAward(20);
         };
         funcf = function():void
         {
            getAward(30);
         };
         this.btna = new ExtendButton(_popGfx.btna,I18n.getString("InviteFriendNumsPop_invite"),this.invite);
         this.btnb = new ExtendButton(_popGfx.btnb,I18n.getString("InviteFriendNumsPop_get"),funcb);
         this.btnc = new ExtendButton(_popGfx.btnc,I18n.getString("InviteFriendNumsPop_get"),funcc);
         this.btnd = new ExtendButton(_popGfx.btnd,I18n.getString("InviteFriendNumsPop_get"),funcd);
         this.btne = new ExtendButton(_popGfx.btne,I18n.getString("InviteFriendNumsPop_get"),funce);
         this.btnf = new ExtendButton(_popGfx.btnf,I18n.getString("InviteFriendNumsPop_get"),funcf);
         _popGfx.title.text = I18n.getString("InviteFriendNumsPop_title");
         _popGfx.invitenum.text = I18n.getString("InviteFriendNumsPop_invitenum");
         _popGfx.inviteitems.text = I18n.getString("InviteFriendNumsPop_inviteitems");
         this.btnb.deactivate();
         this.btnc.deactivate();
         this.btnd.deactivate();
         this.btne.deactivate();
         this.btnf.deactivate();
         _popGfx.percent.text = this.calcPercent().toString() + "%";
         if(param1 >= 2 && this.checkIsNotGet(2))
         {
            this.btnb.activate();
         }
         else if(param1 >= 5 && this.checkIsNotGet(5))
         {
            this.btnc.activate();
         }
         else if(param1 >= 10 && this.checkIsNotGet(10))
         {
            this.btnd.activate();
         }
         else if(param1 >= 20 && this.checkIsNotGet(20))
         {
            this.btne.activate();
         }
         else if(param1 >= 30 && this.checkIsNotGet(30))
         {
            this.btnf.activate();
         }
      }
      
      private function getAward(num:int) : void
      {
         this.ccmain.ccModel.candyApi.getGiftInviteNum(num);
         quitButtonDown(null);
         this.ccmain.getTopNav().doPoll();
         this.ccmain.getInventory().getBalance();
      }
      
      private function calcPercent() : int
      {
         if(this.ivtotal <= 2)
         {
            return Math.ceil(this.ivtotal / 2 * 100);
         }
         if(this.ivtotal > 2 && this.ivtotal <= 5)
         {
            return Math.ceil(this.ivtotal / 5 * 100);
         }
         if(this.ivtotal > 5 && this.ivtotal <= 10)
         {
            return Math.ceil(this.ivtotal / 10 * 100);
         }
         if(this.ivtotal > 10 && this.ivtotal <= 20)
         {
            return Math.ceil(this.ivtotal / 20 * 100);
         }
         if(this.ivtotal > 20 && this.ivtotal <= 30)
         {
            return Math.ceil(this.ivtotal / 30 * 100);
         }
         return 100;
      }
      
      private function invite() : void
      {
         var _loc_2:* = undefined;
         var _loc_3:* = undefined;
         if(ExternalInterface.available)
         {
            _loc_2 = I18n.getString("social_share_invite_title");
            _loc_3 = I18n.getString("social_share_invite_message");
            CCModel.gameModel.openInviteDialog(_loc_2,_loc_3);
         }
         quitButtonDown(null);
      }
      
      private function checkIsNotGet(num:int) : Boolean
      {
         var t:String = null;
         if(!this.inverward || this.inverward.length < 1)
         {
            return true;
         }
         for each(t in this.inverward)
         {
            if(int(t) == num)
            {
               return false;
            }
         }
         return true;
      }
   }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.EventDispatcher;

