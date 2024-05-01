import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/managers/audio/audio_extension.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';
import 'package:window_manager/window_manager.dart';

class SpaceBar extends StatefulWidget {
  const SpaceBar({
    Key? key,
    this.color = Colors.white,
    this.onPressed,
    this.showBackButton = true,
    this.showCloseButton = false,
  }) : super(key: key);

  final Color color;
  final Function()? onPressed;
  final bool showBackButton;
  final bool showCloseButton;

  @override
  State<SpaceBar> createState() => _SpaceBarState();
}

class _SpaceBarState extends State<SpaceBar> {
  Function()? get onPressed => widget.onPressed;
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setSource(AssetSource('audio/back_button.mp3'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    return SizedBox(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: isDesktopPlatform ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
        children: [
          if (isDesktopPlatform && (widget.showBackButton || widget.showCloseButton))
            TextButton(
              onPressed: () {
                if (widget.showBackButton) {
                  player.replay(context);
                  Navigator.of(context).pop();
                  onPressed?.call();
                } else {
                  windowManager.close();
                }
              },
              child: Text(
                widget.showBackButton ? AppLocalizations.of(context).backButton : AppLocalizations.of(context).closeButton,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: widget.color),
              ),
            ),
          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      player.replay(context);
                      context.read<AudioCubit>().toogleSoudEffects();
                    },
                    icon: Icon(
                      state.isSoundEffectsMuted ? Icons.music_off_rounded : Icons.music_note_rounded,
                      color: widget.color,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.replay(context);
                      context.read<AudioCubit>().toogleMusic();
                    },
                    icon: Icon(
                      state.isAmbientMusicMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                      color: widget.color,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
