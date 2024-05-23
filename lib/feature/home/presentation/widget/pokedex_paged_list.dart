import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/feature/home/presentation/presentation.dart';

import '../../../../core/core.dart';

class PokedexPagedList extends StatelessWidget {
  final OnCardTap onTap;
  final PagingController<int, PokemonCardDataView> pagingController;

  const PokedexPagedList({
    super.key,
    required this.onTap,
    required this.pagingController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: PagedSliverMasonryGrid.count(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<PokemonCardDataView>(
          itemBuilder: (context, pokemon, index) {
            return PokemonCard(
              pokemon: pokemon,
              onTap: onTap,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return _loadingWidget();
          },
          firstPageProgressIndicatorBuilder: (context) {
            return _loadingWidget();
          },
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
    );
  }

  Widget _loadingWidget() {
    return const LoadingWidget();
  }
}