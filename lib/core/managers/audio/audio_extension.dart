import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';

extension AudioPlayerExtension on AudioPlayer {
  Future<void> replay(BuildContext context) async {
    if (!context.read<AudioCubit>().state.isSoundEffectsMuted) {
      if (state == PlayerState.playing) await stop();
      if (source != null) unawaited(play(source!));
    }
  }
}
