import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/feature/home/domain/param/pokedex_pagination_param.dart';


abstract class HomeRemoteDataSource {
  Future<BaseListModel<BaseItemModel>> getPokedex(PokedexPaginationParam param);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  const HomeRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<BaseListModel<BaseItemModel>> getPokedex(PokedexPaginationParam param) {
    return client.get(
      ApiConstant.pokemon,
      queryParameters: {
        'limit': param.limit,
        'offset': param.getOffset(),
      },
      converter: (e) => BaseListModel.fromJson(
        e,
        (e) => BaseItemModel.fromJson(e),
      ),
    );
  }
}
