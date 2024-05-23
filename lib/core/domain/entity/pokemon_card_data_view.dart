import 'dart:ui';

import 'package:pokedex_app/config/colors.dart';

class PokemonCardDataView {
  const PokemonCardDataView({
    required this.number,
    required this.name,
    required this.image,
  });

  final String number;
  final String name;
  final String image;
}

extension PokemonX on PokemonCardDataView {
  Color get color => AppColors.lightBlue;
}
