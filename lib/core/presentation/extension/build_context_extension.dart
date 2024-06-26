import 'package:flutter/material.dart';

extension XTextTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get displayLarge => textTheme.displayLarge;
  TextStyle? get displayMedium => textTheme.displayMedium;
  TextStyle? get displaySmall => textTheme.displaySmall;
  TextStyle? get headlineLarge => textTheme.headlineLarge;
  TextStyle? get headlineMedium => textTheme.headlineMedium;
  TextStyle? get headlineSmall => textTheme.headlineSmall;
  TextStyle? get titleLarge => textTheme.titleLarge;
  TextStyle? get titleMedium => textTheme.titleMedium;
  TextStyle? get titleSmall => textTheme.titleSmall;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get bodyMedium => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get labelLarge => textTheme.labelLarge;
  TextStyle? get labelMedium => textTheme.labelMedium;
  TextStyle? get labelSmall => textTheme.labelSmall;
}

extension XSize on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension XSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
      ),
    );
  }
}

extension XString on String {
  String capitalize() {
    if (length > 0) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return this;
  }

  String capitalizeKebabCase() =>
      split('-').map((e) => e.capitalize()).join(' ');

  double parseDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }

  int getNumberFromPokemonUrl() {
    try {
      final regex = RegExp(r'^https://pokeapi.co/api/v2/.*?/([0-9]+)/$');
      final match = regex.firstMatch(this);
      final number = int.parse(match?.group(1) ?? '0');
      return number;
    } catch (_) {
      return 0;
    }
  }
}