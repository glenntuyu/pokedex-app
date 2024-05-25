import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/evolution_data_view.dart';
import 'package:pokedex_app/core/domain/entity/evolution_mapper.dart';
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
  final EvolutionMapper evolutionMapper;

  const PokemonDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.evolutionMapper,
  });
  
  @override
  Future<Either<Failure, PokemonDetailDataView>> getPokemonDetail(int id) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        Pokemon pokemon = await remoteDataSource.getPokemon(id);
        PokemonSpecies pokemonSpecies = await remoteDataSource.getPokemonSpecies(id);
        EvolutionChain evolutionChain = await remoteDataSource
          .getEvolutionChain(pokemonSpecies.evolutionChain?.url ?? '');
        List<EvolutionDataView> evolutions = await getEvolutions(evolutionChain.chain);


        return PokemonDetailDataView(
          pokemon: pokemon, 
          pokemonSpecies: pokemonSpecies,
          evolutions: evolutions,
          types: pokemon.types.map((e) => PokemonTypesX.parse(e.type.name)).toList(),
        );
      },
    );
  }

  Future<List<EvolutionDataView>> getEvolutions(ChainLink node) async {
    Queue<ChainLink> queue = Queue();
    Set<ChainLink> visited = {};
    List<EvolutionDataView> evolutions = [];
    queue.add(node);
    
    int firstId = node.species.url.getNumberFromPokemonUrl();
    Pokemon firstPokemon = await remoteDataSource.getPokemon(firstId);
    evolutions.add(evolutionMapper.toEntity(firstPokemon, node));

    while (queue.isNotEmpty) {
      ChainLink current = queue.removeFirst();

      for (ChainLink neighbor in current.evolvesTo) {
        if (!visited.contains(neighbor)) {
          queue.add(neighbor);
          visited.add(neighbor);
          
          int evolutionId = neighbor.species.url.getNumberFromPokemonUrl();
          Pokemon evolution = await remoteDataSource.getPokemon(evolutionId);
          evolutions.add(evolutionMapper.toEntity(evolution, neighbor));
        }
      }
    }
    return evolutions;
  }
}
