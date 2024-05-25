import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_detail_data_view.dart';
import 'package:pokedex_app/feature/detail/domain/usecase/usecase.dart';

part 'pokemon_detail_state.dart';

@injectable
class PokemonDetailCubit extends Cubit<PokemonDetailState> {
  final GetPokemonDetailUseCase _getPokemonDetailUseCase;

  PokemonDetailCubit(
    this._getPokemonDetailUseCase,
  ) : super(PokemonDetailInitial());


  void getPokemonDetail(int id) async  {
    emit(GetPokemonDetailLoading());

    _getPokemonDetailUseCase(id).then((result) {
      result.fold(
        (failure) => emit(GetPokemonDetailError(message: failure.message)),
        (response) => emit(GetPokemonDetailLoaded(data: response)),
      );
    });
  }
}
