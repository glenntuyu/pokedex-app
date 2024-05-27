part of '../pokemon_detail_page.dart';

class _Label extends Text {
  _Label(super.text, bool isDarkMode)
      : super(
          style: TextStyle(
            color: isDarkMode ? AppColors.whiteGrey.withOpacity(0.6) : AppColors.black.withOpacity(0.6),
            height: 0.8,
          ),
        );
}

class _ContentSection extends StatelessWidget {
  final String label;
  final List<Widget>? children;

  const _ContentSection({
    required this.label,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(height: 0.8, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 22),
        if (children != null) ...children!
      ],
    );
  }
}

class _TextIcon extends StatelessWidget {
  final ImageProvider icon;
  final String text;

  const _TextIcon(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: icon, width: 12, height: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(height: 0.8)),
      ],
    );
  }
}

class _PokemonAbout extends StatelessWidget {
  final PokemonDetailDataView pokemonDetail;

  const _PokemonAbout(this.pokemonDetail);

  @override
  Widget build(BuildContext context) {
    final slideController = PokemonDetailStateProvider.of(context).slideController;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Pokemon pokemon = pokemonDetail.pokemon;
    PokemonSpecies species = pokemonDetail.pokemonSpecies;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          _buildAbout(pokemon, isDarkMode),
          const SizedBox(height: 10),
          _buildBreeding(species.genderRate, species.eggGroups, isDarkMode),
          const SizedBox(height: 30),
          _buildTraining(pokemon.baseExperience ?? -1, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildAbout(Pokemon pokemon, bool isDarkMode) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(child: _Label('Height', isDarkMode)),
            Expanded(
              flex: 3,
              child: Text(
                pokemon.height.dmToCm(),
                style: const TextStyle(height: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(child: _Label('Weight', isDarkMode)),
            Expanded(
              flex: 3,
              child: Text(
                pokemon.weight.hgToKg(),
                style: const TextStyle(height: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(child: _Label('Abilities', isDarkMode)),
            Expanded(
              flex: 3,
              child: Text(
                pokemon.abilities
                    .map((e) => e.ability.name.capitalize().capitalizeKebabCase())
                    .join(', '),
                style: const TextStyle(height: 0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildHeightWeight(String height, String weight, BuildContext context, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            offset: const Offset(0, 8),
            blurRadius: 23,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Height', isDarkMode),
                const SizedBox(height: 11),
                Text(
                  height,
                  style: const TextStyle(
                    height: 0.8,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Label('Weight', isDarkMode),
                const SizedBox(height: 11),
                Text(weight,
                    style: const TextStyle(
                      height: 0.8,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreeding(int genderRate, List<NamedAPIResource> eggGroups, bool isDarkMode) {
    String maleRate = genderRate.maleRate.toString();
    String femaleRate = genderRate.femaleRate.toString();

    return _ContentSection(
      label: 'Breeding',
      children: [
        Row(
          children: <Widget>[
            Expanded(child: _Label('Gender', isDarkMode)),
            if (genderRate == -1)
              const Expanded(
                flex: 3,
                child: Text('Genderless', style: TextStyle(height: 0.8)),
              )
            else ...[
              Expanded(
                child: _TextIcon(AppImages.male, '$maleRate%'),
              ),
              Expanded(
                flex: 2,
                child: _TextIcon(AppImages.female, '$femaleRate%'),
              ),
            ],
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Expanded(child: _Label('Egg Groups', isDarkMode)),
            Expanded(
              flex: 2,
              child: Text(
                eggGroups.map((e) => e.name.capitalize().capitalizeKebabCase()).join(', '),
                style: const TextStyle(height: 0.8),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ],
    );
  }

  Widget _buildLocation() {
    return _ContentSection(
      label: 'Location',
      children: [
        AspectRatio(
          aspectRatio: 2.2,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTraining(int baseExp, bool isDarkMode) {
    return _ContentSection(
      label: 'Training',
      children: [
        Row(
          children: <Widget>[
            Expanded(flex: 1, child: _Label('Base EXP', isDarkMode)),
            Expanded(flex: 3, child: Text(baseExp.toString())),
          ],
        ),
      ],
    );
  }
}
