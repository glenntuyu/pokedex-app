import 'package:pokedex_app/core/core.dart';

extension IntExtension on int {
  int getPage() {
    return this ~/ ApiConstant.limit + 1;
  }
}
