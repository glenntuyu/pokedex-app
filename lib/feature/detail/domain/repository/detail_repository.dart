import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_detail_data_view.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';

import '../../../../core/data/data.dart';
import '../../data/datasource/datasource.dart';

abstract class PokemonDetailRepository {
  Future<Either<Failure, PokemonDetailDataView>> getPokemonDetail(int id);
}

@LazySingleton(as: PokemonDetailRepository)
class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  const PokemonDetailRepositoryImpl({
    required this.remoteDataSource,
  });
  
  @override
  Future<Either<Failure, PokemonDetailDataView>> getPokemonDetail(int id) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        Pokemon pokemon = await remoteDataSource.getPokemon(id);
        PokemonSpecies pokemonSpecies = await remoteDataSource.getPokemonSpecies(id);

        return PokemonDetailDataView(
          pokemon: pokemon, 
          pokemonSpecies: pokemonSpecies,
          types: pokemon.types.map((e) => PokemonTypesX.parse(e.type.name)).toList(),
        );
      },
    );
  }
}
