import 'package:intl/intl.dart';

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
}

String removeTrailingZero(double n) {
  final formatter = NumberFormat()
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 2;

  return formatter.format(n);
}

String getEnumValue(e) => e.toString().split('.').last;
