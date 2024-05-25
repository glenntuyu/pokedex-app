import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/base_list_data_view.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';
import 'package:pokedex_app/core/presentation/extension/integer_extension.dart';

extension XPokemon on Pokemon {
  PokemonCardDataView toPokemonCardDataView() => PokemonCardDataView(
        id: id,
        number: id.getDexId(),
        name: name.capitalize().replaceGenderSuffixes(),
        image: sprites.frontDefault ?? '',
        types: types.map((e) => PokemonTypesX.parse(e.type.name)).toList(),
      );
}

extension XBaseListModel on BaseListModel<Pokemon> {
  BaseListDataView<PokemonCardDataView> toBaseListDataView() => BaseListDataView<PokemonCardDataView>(
      count: count,
      next: next,
      previous: previous,
      results: results.map((e) => e.toPokemonCardDataView()).toList()
    );
}
