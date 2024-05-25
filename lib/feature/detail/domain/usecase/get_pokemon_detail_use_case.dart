import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_detail_data_view.dart';
import 'package:pokedex_app/feature/detail/domain/repository/repository.dart';


@lazySingleton
class GetPokemonDetailUseCase implements UseCase<PokemonDetailDataView, int> {
  final PokemonDetailRepository repository;

  const GetPokemonDetailUseCase(this.repository);

  @override
  Future<Either<Failure, PokemonDetailDataView>> call(int id) {
    return repository.getPokemonDetail(id);
  }
}