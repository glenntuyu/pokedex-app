import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/data/model/base_item_model.dart';
import 'package:pokedex_app/core/domain/entity/base_list_data_view.dart';
import 'package:pokedex_app/core/domain/entity/source_to_entity_mapper.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {

  BaseListDataView<PokemonCardDataView>? listPokemon;

  HomeCubit() : super(HomeInitial());


  void getListPokemon({int page = -1}) async {
    emit(GetListPokemonLoading());

    await Future.delayed(const Duration(seconds: 3));
    listPokemon = const BaseListModel(
      count: 1302, 
      next: "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30", 
      previous: null, 
      results: dummyPokemons,
    ).toBaseListDataView();

    emit(GetListPokemonLoaded(result: listPokemon ?? BaseListDataView(count: null, next: null, previous: null, results: List.empty())));
  }
}
