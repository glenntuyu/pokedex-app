import 'package:equatable/equatable.dart';
import 'package:pokedex_app/core/data/data.dart';

class PokedexPaginationParam extends Equatable {
  final int limit = ApiConstant.limit;
  
  final int page;

  const PokedexPaginationParam({
    this.page = 1,
  });

  int getOffset() {
    return (page - 1) * limit;
  }

  @override
  List<Object?> get props => [
        limit,
      ];
}