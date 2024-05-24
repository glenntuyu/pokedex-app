import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';

import '../../../../core/data/data.dart';
import '../../data/datasource/datasource.dart';
import '../param/param.dart';

abstract class HomeRepository {
  Future<Either<Failure, BaseListModel<Pokemon>>> getPokedex(
    PokedexPaginationParam param,
  );
}

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, BaseListModel<Pokemon>>> getPokedex(
    PokedexPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getPokedex(
          param,
        );

        final pokedex = await Future.wait(response.results
            .map((e) => remoteDataSource.getPokemonByUrl(e.url ?? '')));

        return BaseListModel(
          count: response.count, 
          next: response.next, 
          previous: response.previous, 
          results: pokedex,
        );
      },
    );
  }
}