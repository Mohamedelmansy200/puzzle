import 'package:flutter/material.dart';

class GameViewBackground extends StatelessWidget {
  const GameViewBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/game_background',
      fit: BoxFit.cover,
    );
  }
}
