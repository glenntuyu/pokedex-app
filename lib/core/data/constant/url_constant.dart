import 'package:intl/intl.dart';

class UrlConstant {
  static const imageUrl = 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/';
  static const imageUrl2 = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';
}

extension UrlExtension on int {
  String get getSprite{
    NumberFormat formatter = NumberFormat('#,000');
    return '${UrlConstant.imageUrl}${formatter.format(this)}.png';
  }

  String get getSprite2 {
    return '${UrlConstant.imageUrl2}$this.png';
  }
}