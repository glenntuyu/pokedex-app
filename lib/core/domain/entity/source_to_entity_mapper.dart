import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/data/model/base_item_model.dart';
import 'package:pokedex_app/core/domain/entity/base_list_data_view.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_card_data_view.dart';

extension XBaseItemModel on BaseItemModel {
  PokemonCardDataView toPokemonCardDataView() => PokemonCardDataView(
        number: '',
        name: name ?? '',
        image: '',
      );
}

extension XBaseListModel on BaseListModel<BaseItemModel> {
  BaseListDataView<PokemonCardDataView> toBaseListDataView({List<BaseItemModel> results = const []}) => BaseListDataView<PokemonCardDataView>(
      count: count,
      next: next,
      previous: previous,
      results: results.map((e) => e.toPokemonCardDataView()).toList()
    );
}
