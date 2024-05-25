import 'package:flutter/material.dart';

class PokemonDetailStateProvider extends InheritedWidget {
  final AnimationController slideController;
  final AnimationController rotateController;

  const PokemonDetailStateProvider({
    Key? key,
    required this.slideController,
    required this.rotateController,
    required Widget child,
  }) : super(child: child);

  static PokemonDetailStateProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<PokemonDetailStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant PokemonDetailStateProvider oldWidget) => false;
}
