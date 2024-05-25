import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/core.dart';

abstract class DetailRemoteDataSource {
  Future<Pokemon> getPokemon(int id);
  Future<PokemonSpecies> getPokemonSpecies(int id);
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
    return pokedex.pokemonSpecies.get(id: id);
  }
}
