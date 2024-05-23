import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/base_list_data_view.dart';
import 'package:pokedex_app/core/domain/entity/source_to_entity_mapper.dart';
import 'package:pokedex_app/feature/feature.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetPokedexUseCase _getPokedexUseCase;

  HomeCubit(
    this._getPokedexUseCase,
  ) : super(HomeInitial());


  void getPokedex({int page = 0}) async  {
    emit(GetPokedexLoading());

    _getPokedexUseCase(
      PokedexPaginationParam(
        page: page,
      )
    ).then((result) { 
      result.fold(
        (failure) => emit(GetPokedexError(message: failure.message)),
        (response) => emit(GetPokedexLoaded(data: response.toBaseListDataView())),
      );
    });
  }
}
