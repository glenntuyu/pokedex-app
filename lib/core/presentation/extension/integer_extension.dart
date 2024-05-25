import 'package:intl/intl.dart';
import 'package:pokedex_app/core/core.dart';

extension IntExtension on int {
  int getPage() {
    return this ~/ ApiConstant.limit + 1;
  }

  String getDexId() {
    NumberFormat formatter = NumberFormat('#,000');
    return "#${formatter.format(this)}";
  }

  String dmToCm() {
    int centimeters = this * 10;
    return '$centimeters cm';
  }

  String dmToMeter() {
    double meters = this / 10.0;
    return '$meters m';
  }

  String hgToKg() {
    double kilograms = this / 10.0;
    return '$kilograms kg';
  }
  
  double get femaleRate => (this / 8.0) * 100.0;
  double get maleRate => 100.0 - femaleRate;
}