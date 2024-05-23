import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/data/model/base_item_model.dart';

import '../../../../core/data/data.dart';
import '../../data/datasource/datasource.dart';
import '../param/param.dart';

abstract class HomeRepository {
  Future<Either<Failure, BaseListModel<BaseItemModel>>> getPokedex(
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
  Future<Either<Failure, BaseListModel<BaseItemModel>>> getPokedex(
    PokedexPaginationParam param,
  ) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        final response = await remoteDataSource.getPokedex(
          param,
        );
        return response;
      },
    );
  }
}