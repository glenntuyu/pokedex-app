part of '../pokemon_detail_page.dart';

class _PokemonInfoCard extends StatefulWidget {
  final PokemonDetailDataView pokemonDetail;

  const _PokemonInfoCard({
    required this.pokemonDetail,
  });

  @override
  State<_PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<_PokemonInfoCard> {
  AnimationController get slideController => PokemonDetailStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;
    final orientation = MediaQuery.of(context).orientation;
    final double minCardHeightFraction = orientation == Orientation.portrait ? 0.54 : 0.35;

    final cardMinHeight = screenHeight * minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;

    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: MainTabView(
          paddingAnimation: slideController,
          tabs: [
            MainTabData(
              label: 'About',
              child: _PokemonAbout(widget.pokemonDetail),
            ),
            MainTabData(
              label: 'Base Stats',
              child: _PokemonBaseStats(widget.pokemonDetail),
            ),
            MainTabData(
              label: 'Evolution',
              child: _PokemonEvolution(widget.pokemonDetail),
            ),
          ],
        ),
    );
  }
}
