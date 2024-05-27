part of '../pokemon_detail_page.dart';

class _PokemonOverallDetail extends StatefulWidget {
  final PokemonDetailDataView pokemonDetail;

  const _PokemonOverallDetail({
    required this.pokemonDetail,
  });

  @override
  _PokemonOverallDetailState createState() => _PokemonOverallDetailState();
}

class _PokemonOverallDetailState extends State<_PokemonOverallDetail> with TickerProviderStateMixin {
  Pokemon get pokemon => widget.pokemonDetail.pokemon;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();

  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;

  AnimationController get slideController => PokemonDetailStateProvider.of(context).slideController;
  AnimationController get rotateController => PokemonDetailStateProvider.of(context).rotateController;

  Animation<double> get textFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(slideController);
  Animation<double> get sliderFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.ease),
      ));

  @override
  void initState() {

    super.initState();
  }

  void _calculatePokemonNamePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetTextBox = _targetTextKey.currentContext?.findRenderObject() as RenderBox?;
      final currentTextBox = _currentTextKey.currentContext?.findRenderObject() as RenderBox?;

      if (targetTextBox == null || currentTextBox == null) return;

      final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);
      final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      final newDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      final newDiffTop = targetTextPosition.dy - currentTextPosition.dy;

      if (newDiffLeft != textDiffLeft || newDiffTop != textDiffTop) {
        setState(() {
          textDiffLeft = newDiffLeft;
          textDiffTop = newDiffTop;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        const SizedBox(height: 9),
        _buildPokemonName(),
        const SizedBox(height: 9),
        _buildPokemonTypes(),
        const SizedBox(height: 25),
        _buildPokemonSlider(),
      ],
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(
      title: Builder(builder: (context) {
        _calculatePokemonNamePosition();
        return Text(
          pokemon.name.capitalize().replaceGenderSuffixes(),
          key: _targetTextKey,
          style: const TextStyle(
            color: Colors.transparent,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        );
      }),
      context: context,
    );
  }

  Widget _buildPokemonName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: slideController,
            builder: (_, __) {
              final value = slideController.value;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: HeroText(
                    pokemon.name.capitalize().replaceGenderSuffixes(),
                    textKey: _currentTextKey,
                    style: TextStyle(
                      color: AppColors.whiteGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 36 - (36 - 22) * value,
                    ),
                  ),
              );
            },
          ),
          AnimatedBuilder(
            animation: slideController,
            builder: (BuildContext context, Widget? child) { 
              return AnimatedFade(
                animation: textFadeAnimation,
                child: HeroText(
                    pokemon.id.getDexId(),
                    style: const TextStyle(
                      color: AppColors.whiteGrey,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
              );
             },
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonTypes() {
    return AnimatedFade(
      animation: textFadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: pokemon.types.take(3)
                    .map((e) => PokemonTypeWidget(
                        PokemonTypesX.parse(e.type.name), large: true
                      )
                    ).toList(),
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildPokemonSlider() {
    final screenSize = MediaQuery.of(context).size;
    final sliderHeight = screenSize.height * 0.24;
    final pokeballSize = screenSize.height * 0.24;
    final pokemonSize = screenSize.height * 0.3;

    return AnimatedFade(
      animation: sliderFadeAnimation,
      child: SizedBox(
        width: screenSize.width,
        height: sliderHeight,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: RotationTransition(
                turns: rotateController,
                child: Image(
                  image: AppImages.pokeball,
                  width: pokeballSize,
                  height: pokeballSize,
                  color: Colors.white12,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PokemonImage(
                pokemon: pokemon,
                size: Size.square(pokemonSize),
                useHero: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
