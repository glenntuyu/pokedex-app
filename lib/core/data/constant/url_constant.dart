import 'package:intl/intl.dart';

class UrlConstant {
  static const imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/';
}

extension UrlExtension on int {
  String get getSprite{
    NumberFormat formatter = NumberFormat('#,000');
    return '${UrlConstant.imageUrl}${formatter.format(this)}.png';
  }
}