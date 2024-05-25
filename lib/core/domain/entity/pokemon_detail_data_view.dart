import 'package:flutter/material.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';

class PokemonDetailDataView {
  final Pokemon pokemon;
  final PokemonSpecies pokemonSpecies;
  final List<PokemonTypes> types;

  const PokemonDetailDataView({
    required this.pokemon,
    required this.pokemonSpecies,
    required this.types,
  });
}

extension PokemonX on PokemonDetailDataView {
  Color get color => types.first.color;

  Map<PokemonTypes, double> get typeEffectiveness {
    final effectiveness = PokemonTypes.values
        .where((element) => element != PokemonTypes.unknown)
        .map(
          (type) => MapEntry(
            type,
            types
                .map((pokemonType) => pokemonType.effectiveness[type] ?? 1.0)
                .reduce((total, effectiveness) => total * effectiveness),
          ),
        );

    return Map.fromEntries(effectiveness);
  }
}
