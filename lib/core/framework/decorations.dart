import 'package:flutter/material.dart';
import 'package:slide_puzzle_game/core/framework/colors.dart';

BoxDecoration missionCompleteDialogDecoration = BoxDecoration(
  border: Border.all(width: 5, color: const Color.fromARGB(255, 105, 92, 7)),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      offset: Offset(0, 10),
    ),
  ],
  gradient: LinearGradient(
    colors: [
      const Color.fromARGB(255, 129, 123, 15),
      const Color.fromARGB(255, 252, 247, 94).withOpacity(0.5),
      const Color(0x00FFFFFF),
    ],
    stops: const [0, 1, 0.502],
    begin: const Alignment(0.5, 0.263),
    end: const Alignment(0.511, 1.213),
  ),
);

BoxDecoration spaceContainerDecoration = BoxDecoration(
  color: background.withOpacity(0.5),
  border: Border.all(width: 3, color: border),
);

BoxDecoration alienButtonDecoration = BoxDecoration(
  color: Colors.yellow,
  border: Border.all(width: 3, color: border),
  boxShadow: const [BoxShadow(offset: Offset(0, 10))],
  gradient: spaceGradient,
);

BoxDecoration playButtonDecoration = BoxDecoration(
  shape: BoxShape.circle,
  border: Border.all(width: 3, color: border),
  boxShadow: const [BoxShadow(offset: Offset(0, 6))],
  gradient: spaceGradient,
);

const spaceGradient = LinearGradient(
  colors: [secondary, primary],
  begin: Alignment(-0.5, -1),
  end: Alignment(0.5, 3.5),
);
