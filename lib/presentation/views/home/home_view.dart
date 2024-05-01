import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/presentation/views/difficulty_view.dart';
import 'package:slide_puzzle_game/presentation/views/home/play_button.dart';
import 'package:slide_puzzle_game/presentation/widgets/home_view_background.dart';
import 'package:slide_puzzle_game/presentation/widgets/space_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          HomeViewBackground(),
          HomeViewBody(),
        ],
      ),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<AudioCubit>().playMenuMusic();
  }

  @override
  Widget build(BuildContext context) {
    // const padding = EdgeInsets.symmetric(horizontal: 10);
    // const duration = 800;
    final size = MediaQuery.of(context).size;
    // final constraints = BoxConstraints(maxWidth: (size.width / 2).clamp(250, 300), minHeight: 60);

    final isMobile = size.width < 600;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpaceBar(showBackButton: false, showCloseButton: true),
          Expanded(
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (!isMobile)
                    const Image(
                      image: AssetImage('assets/img/logo.png'),
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  if (!isMobile) const SizedBox(height: 20),
                  if (isMobile) const Spacer(),
                  PlayButton(onPressed: () => _pushView(child: const DifficultyView())),
                  if (isMobile) const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pushView({required Widget child}) {
    Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
