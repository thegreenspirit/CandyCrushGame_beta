package com.midasplayer.candycrushsaga.popup
{
   import com.king.saga.api.user.UserProfile;
   import com.midasplayer.candycrushsaga.engine.CCModel;
   import com.midasplayer.candycrushsaga.main.CCMain;
   import com.midasplayer.candycrushsaga.popup.buttons.ExtendButton;
   import com.midasplayer.text.I18n;
   import flash.external.ExternalInterface;
   
   public class InviteFriendLevelPop extends Popup
   {
      private var btna:ExtendButton;
      
      private var btnb:ExtendButton;
      
      private var btnc:ExtendButton;
      
      private var btnd:ExtendButton;
      
      private var btne:ExtendButton;
      
      private var invitedFriends:Array;
      
      private var ccmain:CCMain;
      
      private var numa:int = 0;
      
      private var numb:int = 0;
      
      private var numc:int = 0;
      
      private var numd:int = 0;
      
      private var usersa:Array;
      
      private var usersb:Array;
      
      private var usersc:Array;
      
      private var usersd:Array;
      
      public function InviteFriendLevelPop(param1:Array, param2:CCMain)
      {
         this.usersa = [];
         this.usersb = [];
         this.usersc = [];
         this.usersd = [];
         this.invitedFriends = param1;
         this.ccmain = param2;
         super(null,new LevelAwardMC());
         this.initdata();
      }
      
      private function initdata() : void
      {
         var user:UserProfile = null;
         var funca:Function = null;
         var funcb:Function = null;
         var funcc:Function = null;
         var funcd:Function = null;
         var param1:int = 0;
         funca = function():void
         {
            getAward(usersa.shift(),5);
         };
         funcb = function():void
         {
            getAward(usersb.shift(),11);
         };
         funcc = function():void
         {
            getAward(usersc.shift(),21);
         };
         funcd = function():void
         {
            getAward(usersd.shift(),31);
         };
         this.btna = new ExtendButton(_popGfx.btna,I18n.getString("InviteFriendNumsPop_invite"),this.invite);
         this.btnb = new ExtendButton(_popGfx.btnb,I18n.getString("InviteFriendNumsPop_get"),funca);
         this.btnc = new ExtendButton(_popGfx.btnc,I18n.getString("InviteFriendNumsPop_get"),funcb);
         this.btnd = new ExtendButton(_popGfx.btnd,I18n.getString("InviteFriendNumsPop_get"),funcc);
         this.btne = new ExtendButton(_popGfx.btne,I18n.getString("InviteFriendNumsPop_get"),funcd);
         _popGfx.title.text = I18n.getString("InviteFriendNumsPop_title");
         _popGfx.descrition.text = I18n.getString("InviteFriendLevelPop_des");
         _popGfx.invitelevel.text = I18n.getString("InviteFriendLevelPop_level");
         _popGfx.invitenum.text = I18n.getString("InviteFriendNumsPop_invitenum");
         _popGfx.inviteitems.text = I18n.getString("InviteFriendNumsPop_inviteitems");
         this.btnb.deactivate();
         this.btnc.deactivate();
         this.btnd.deactivate();
         this.btne.deactivate();
         _popGfx.numa.text = 0;
         _popGfx.numb.text = 0;
         _popGfx.numc.text = 0;
         _popGfx.numd.text = 0;
         if(!this.invitedFriends || this.invitedFriends.length < 1)
         {
            return;
         }
         for each(user in this.invitedFriends)
         {
            param1 = CCModel.getUserLevels(user.getTopEpisode(),user.getTopLevel());
            if(param1 >= 5 && param1 <= 11)
            {
               if(this.CheckIsActive(user,5))
               {
                  this.btnb.activate();
                  this.usersa.push(user);
               }
               ++this.numa;
            }
            if(param1 >= 11 && param1 <= 21)
            {
               if(this.CheckIsActive(user,11))
               {
                  this.btnc.activate();
                  this.usersb.push(user);
               }
               ++this.numb;
            }
            if(param1 >= 21 && param1 <= 31)
            {
               if(this.CheckIsActive(user,21))
               {
                  this.btnd.activate();
                  this.usersc.push(user);
               }
               ++this.numc;
            }
            if(param1 >= 31)
            {
               if(this.CheckIsActive(user,31))
               {
                  this.btne.activate();
                  this.usersd.push(user);
               }
               ++this.numd;
            }
         }
         _popGfx.numa.text = this.numa;
         _popGfx.numb.text = this.numb;
         _popGfx.numc.text = this.numc;
         _popGfx.numd.text = this.numd;
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
      
      private function getAward(user:UserProfile, level:int) : void
      {
         this.ccmain.ccModel.candyApi.getGiftInviteLevel(user.getExternalUserId(),level);
         quitButtonDown(null);
         this.ccmain.getTopNav().doPoll();
         this.ccmain.getInventory().getBalance();
      }
      
      private function CheckIsActive(user:UserProfile, level:int) : Boolean
      {
         var str:String = null;
         if(!user.getMasteraward() || user.getMasteraward() == "")
         {
         }
         var temp:Array = user.getMasteraward().split(",");
         for each(str in temp)
         {
            if(int(str) == level)
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

