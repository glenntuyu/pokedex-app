import 'dart:ui';

import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';

class PokemonCardDataView {
  const PokemonCardDataView({
    required this.number,
    required this.name,
    required this.image,
    required this.types,
  });

  final String number;
  final String name;
  final String image;
  final List<PokemonTypes> types;
}

extension PokemonX on PokemonCardDataView {
  Color get color => types.first.color;
}
