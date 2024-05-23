import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this == '';
  }
}

String removeTrailingZero(double n) {
  final formatter = NumberFormat()
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 2;

  return formatter.format(n);
}