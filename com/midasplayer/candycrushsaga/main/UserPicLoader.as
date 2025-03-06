package com.midasplayer.candycrushsaga.main
{
   import com.king.saga.api.user.*;
   import com.midasplayer.candycrushsaga.ccshared.*;
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import main.*;
   
   public class UserPicLoader
   {
      private static const _PIC_W_BIG:int = 50;
      
      private static const _PIC_H_BIG:int = 50;
      
      private static const _PIC_W_SMALL:int = 38;
      
      private static const _PIC_H_SMALL:int = 38;
      
      private var _userProfiles:UserProfiles;
      
      public function UserPicLoader(param1:UserProfiles)
      {
         super();
         this._userProfiles = param1;
      }
      
      public function getSmallUserPicById(param1:Number, param2:int = 38, param3:int = 38) : MovieClip
      {
         return this.loadPic(param1,param2,param3);
      }
      
      public function getBigUserPicById(param1:Number, param2:Number = 50, param3:Number = 50) : MovieClip
      {
         return this.loadPic(param1,param2,param3);
      }
      
      private function loadPic(param1:Number, param2:int, param3:int) : MovieClip
      {
         var userPic:MovieClip = null;
         var url:String = null;
         var pic:Loader = null;
         var context:LoaderContext = null;
         var width:* = undefined;
         var height:* = undefined;
         width = undefined;
         height = undefined;
         var userId:* = param1;
         width = param2;
         height = param3;
         userPic = new MovieClip();
         var defaultPic:* = new DefaultUserPic();
         defaultPic.width = 50;
         defaultPic.height = 50;
         userPic.addChild(defaultPic);
         defaultPic.x = -10;
         defaultPic.y = -15;
         if(this._userProfiles.exists(userId))
         {
            if(Boolean(this._userProfiles.getUserProfile(userId).getName()))
            {
               userPic.name = this._userProfiles.getUserProfile(userId).getName();
            }
            else
            {
               userPic.name = "神秘人";
            }
            url = this._userProfiles.getUserProfile(userId).getPicSquareUrl();
            if(Boolean(url))
            {
               pic = new Loader();
               try
               {
                  pic.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void
                  {
                     ;
                     pic.width = width;
                     pic.height = height;
                     try
                     {
                        Bitmap(pic.content).smoothing = true;
                     }
                     catch(e:SecurityError)
                     {
                        Console.println("UserPicObjectHandler -> SecurityError: " + e.message);
                     }
                     userPic.removeChild(defaultPic);
                     userPic.addChild(pic);
                  });
                  pic.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void
                  {
                     Console.println("UserPicObjectHandler -> IOErrorEvent: " + event.toString());
                  });
                  context = new LoaderContext();
                  context.checkPolicyFile = true;
                  pic.load(new URLRequest(url),context);
               }
               catch(e:Error)
               {
                  Console.println("UserPicObjectHandler -> Error: " + e.message);
                  return userPic;
               }
            }
         }
         return userPic;
      }
   }
}

