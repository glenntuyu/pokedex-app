import 'package:intl/intl.dart';
import 'package:pokedex_app/core/core.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this == '';
  }
}

extension StringExtension2 on String {
  String getParam(String param) {
    Uri uri = Uri.dataFromString(this);
    return uri.queryParameters[param] ?? '';
  }

  String replaceGenderSuffixes() {
    String name = replaceAll(RegExp(r'-(male|m)'), ' \u2642');
    name = name.replaceAll(RegExp(r'-(female|f)'), ' \u2640');
    return name;
  }

  String toStatName() {
    if (this == 'hp') {
      return 'HP';
    } else if (this == 'special-attack') {
      return 'Sp. Atk';
    } else if (this == 'special-defense') {
      return 'Sp. Def';
    } else {
      return capitalize();
    }
  }
}

String removeTrailingZero(double n) {
  final formatter = NumberFormat()
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 2;

  return formatter.format(n);
}

String getEnumValue(e) => e.toString().split('.').last;
