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
}