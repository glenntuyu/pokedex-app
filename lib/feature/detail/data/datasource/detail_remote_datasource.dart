import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/core.dart';

abstract class DetailRemoteDataSource {
  Future<Pokemon> getPokemon(int id);
  Future<PokemonSpecies> getPokemonSpecies(int id);
  Future<EvolutionChain> getEvolutionChain(String url);
}

@LazySingleton(as: DetailRemoteDataSource)
class HomeRemoteDataSourceImpl implements DetailRemoteDataSource {
  final ApiClient client;
  final Pokedex pokedex;

  const HomeRemoteDataSourceImpl({
    required this.client,
    required this.pokedex,
  });

  @override
  Future<Pokemon> getPokemon(int id) {
    return client.get(
      '${ApiConstant.pokemon}/$id',
      converter: (e) => Pokemon.fromJson(e),
    );
  }

  @override
  Future<PokemonSpecies> getPokemonSpecies(int id) {
    return client.get(
      '${ApiConstant.pokemonSpecies}/$id',
      converter: (e) => PokemonSpecies.fromJson(e),
    );
  }

  @override
  Future<EvolutionChain> getEvolutionChain(String url) {
    return pokedex.evolutionChains.getByUrl(url);
  }
}
