part of '../pokemon_detail_page.dart';

class _PokemonInfoCard extends StatefulWidget {
  static const double minCardHeightFraction = 0.54;

  final PokemonDetailDataView pokemonDetail;

  const _PokemonInfoCard({
    required this.pokemonDetail,
  });

  @override
  State<_PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<_PokemonInfoCard> {
  AnimationController get slideController => PokemonInfoStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeArea = MediaQuery.of(context).padding;
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * _PokemonInfoCard.minCardHeightFraction;
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
            // MainTabData(
            //   label: 'Evolution',
            //   child: _PokemonEvolution(widget.pokemonDetail),
            // ),
            // const MainTabData(
            //   label: 'Moves',
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: Text('Under development'),
            //   ),
            // ),
          ],
        ),
    );
  }
}
