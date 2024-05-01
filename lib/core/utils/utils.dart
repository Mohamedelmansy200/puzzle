import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/presentation/widgets/custom_dialog.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_button.dart';

String readableTimer(int duration) {
  final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
  final secondsStr = (duration % 60).toString().padLeft(2, '0');
  return '$minutesStr:$secondsStr';
}

void showMissionCompleteDialog(BuildContext context,
    {required String title,
    required String timer,
    required String label,
    required String moves,
    required String button,
    required String album,
    required String share,
    required ScreenshotController controller,
    Function()? onPressed}) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return Screenshot(
        controller: controller,
        child: CustomDialog(
          image: 'assets/img/spongebob.png',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTimer(timer, context),
              const SizedBox(height: 20),
              _buildTotalMoves(label, context, moves),
              const SizedBox(height: 20),
              SpaceButton(
                animate: false,
                isShortButton: true,
                onPressed: () {
                  context.read<AudioCubit>().playMenuMusic();
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                title: button,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

Container _buildTotalMoves(String label, BuildContext context, String moves) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 155, 141, 17),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        width: 3,
        color: const Color.fromARGB(255, 193, 167, 22),
      ),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        Text(
          moves,
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Row _buildTimer(String timer, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.timer_rounded,
        color: Colors.white,
        size: 30,
      ),
      const SizedBox(width: 10),
      Text(
        timer,
        style: Theme.of(context).textTheme.displaySmall,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

void showCustomAlert(BuildContext context, {required String img, required String title, required String message, required String button, Function()? onPressed}) {
  showDialog<void>(
    context: context,
    builder: (context) => CustomDialog(
      image: img,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: SpaceButton(
              title: button,
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
