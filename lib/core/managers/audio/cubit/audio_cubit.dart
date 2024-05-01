import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit(AudioPlayer ambientPlayer, AudioPlayer soundEffectsPlayer)
      : super(
          AudioState(
            ambientPlayer: ambientPlayer,
            soundEffectsPlayer: soundEffectsPlayer,
            isAmbientMusicMuted: false,
            isSoundEffectsMuted: false,
          ),
        );

  AudioPlayer get ambientPlayer => state.ambientPlayer;
  AudioPlayer get soundEffectsPlayer => state.soundEffectsPlayer;

  void playMenuMusic() {
    ambientPlayer.play(
      AssetSource('audio/dorothy.mp3'),
      mode: PlayerMode.mediaPlayer,
      volume: state.isAmbientMusicMuted ? 0.0 : 0.2,
    );
  }

  void playGameMusic() {
    ambientPlayer.play(
      AssetSource('audio/happy_jose.mp3'),
      mode: PlayerMode.mediaPlayer,
      volume: state.isAmbientMusicMuted ? 0.0 : 0.2,
    );
  }

  void stop() => ambientPlayer.stop();

  Future<void> win() async {
    unawaited(
      soundEffectsPlayer.play(
        AssetSource('audio/winning_notification.mp3'),
        mode: PlayerMode.mediaPlayer,
        volume: state.isAmbientMusicMuted ? 0.0 : 0.2,
      ),
    );
  }

  void toogleSoudEffects() {
    if (state.isSoundEffectsMuted) {
      emit(
        AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: false,
        ),
      );
    } else {
      emit(
        AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: state.isAmbientMusicMuted,
          isSoundEffectsMuted: true,
        ),
      );
    }
  }

  void toogleMusic() {
    if (ambientPlayer.volume > 0) {
      ambientPlayer.setVolume(0);
      emit(
        AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: true,
          isSoundEffectsMuted: state.isSoundEffectsMuted,
        ),
      );
    } else {
      ambientPlayer.setVolume(0.2);
      emit(
        AudioState(
          ambientPlayer: ambientPlayer,
          soundEffectsPlayer: soundEffectsPlayer,
          isAmbientMusicMuted: false,
          isSoundEffectsMuted: state.isSoundEffectsMuted,
        ),
      );
    }
  }
}
