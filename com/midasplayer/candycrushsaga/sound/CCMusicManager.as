package com.midasplayer.candycrushsaga.sound
{
   import sagaSound.CutsceneMusic;
   import sound.Music_MapView;
   
   public class CCMusicManager extends CCSoundManager
   {
      private static var _instance:CCMusicManager;
      
      public static const FADE_OUT_DELAY:int = 3000;
      
      public static const MUSIC_VOLUME:int = 1;
      
      public function CCMusicManager(param1:Number = 1)
      {
         super(param1);
      }
      
      public static function getInstance() : CCMusicManager
      {
         if(!_instance)
         {
            _instance = new CCMusicManager(MUSIC_VOLUME);
         }
         return _instance;
      }
      
      public function playMusicInLobby() : void
      {
         this.playLobbyMelody();
      }
      
      public function stopMusicInLobby() : void
      {
         this.stopIntroMelody();
         this.stopLobbyMelody();
      }
      
      public function playMusicInCutscene() : void
      {
         _loop(CutsceneMusic);
      }
      
      public function stopMusicInCutscene() : void
      {
         _stop(CutsceneMusic,FADE_OUT_DELAY);
      }
      
      public function playVictoryMusicAfterGame() : void
      {
         _play(SA_Music_outro,0.5);
      }
      
      public function stopVictoryMusicAfterGame() : void
      {
         _stop(SA_Music_outro,FADE_OUT_DELAY);
      }
      
      public function playLossMusicAfterGame() : void
      {
         _play(SA_Music_intro2,0.5);
      }
      
      public function stopLossMusicAfterGame() : void
      {
         _stop(SA_Music_intro2,FADE_OUT_DELAY);
      }
      
      private function playIntroMelody() : void
      {
      }
      
      private function playLobbyMelody() : void
      {
         _loop(Music_MapView,0.35);
      }
      
      private function stopLobbyMelody() : void
      {
         _stop(Music_MapView,FADE_OUT_DELAY);
      }
      
      private function stopIntroMelody() : void
      {
      }
   }
}

import com.midasplayer.sound.SoundManager;

