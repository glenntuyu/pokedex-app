import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/feature/feature.dart';


@lazySingleton
class GetPokedexUseCase
    implements UseCase<BaseListModel<BaseItemModel>, PokedexPaginationParam> {
  final HomeRepository repository;

  const GetPokedexUseCase(this.repository);

  @override
  Future<Either<Failure, BaseListModel<BaseItemModel>>> call(
      PokedexPaginationParam param,
  ) {
    return repository.getPokedex(param);
  }
}