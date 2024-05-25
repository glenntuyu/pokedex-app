import 'package:pokedex/pokedex.dart';

class PokemonDetailDataView {
  const PokemonDetailDataView({
    required this.pokemon,
    required this.pokemonSpecies,
  });

  final Pokemon pokemon;
  final PokemonSpecies pokemonSpecies;
}
