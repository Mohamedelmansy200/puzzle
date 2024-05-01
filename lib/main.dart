import 'dart:io';
import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/app/app.dart';
import 'package:slide_puzzle_game/injection_container.dart' as di;
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final isDesktopPlatform = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  if (isDesktopPlatform) {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      size: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(
      windowOptions,
      () async {
        await windowManager.show();
        await windowManager.focus();
        await windowManager.setFullScreen(true);
      },
    );
  }
  runApp(const App());
}
