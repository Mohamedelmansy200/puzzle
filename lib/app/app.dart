// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:slide_puzzle_game/core/framework/framework.dart';
import 'package:slide_puzzle_game/core/managers/audio/cubit/audio_cubit.dart';
import 'package:slide_puzzle_game/core/router/routing.dart';
import 'package:slide_puzzle_game/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AudioPlayer ambientPlayer;
  late AudioPlayer soundEffectsPlayer;

  @override
  void initState() {
    ambientPlayer = AudioPlayer();
    soundEffectsPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    ambientPlayer.dispose();
    soundEffectsPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AudioCubit(ambientPlayer, soundEffectsPlayer)),
      ],
      child: MaterialApp(
        title: 'Slide the Space',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Space-Mode',
          textTheme: const TextTheme(
            displaySmall: h3,
            headlineMedium: h4,
            headlineSmall: h5,
            labelLarge: button,
            bodySmall: caption,
          ),
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: 'home',
        routes: getApplicationRoutes(),
      ),
    );
  }
}
