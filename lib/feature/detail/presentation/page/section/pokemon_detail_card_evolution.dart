part of '../pokemon_detail_page.dart';

class _PokemonBall extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonBall(this.pokemon);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final pokeballSize = screenHeight * 0.1;
    final pokemonSize = pokeballSize * 0.85;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AppImages.pokeball,
              width: pokeballSize,
              height: pokeballSize,
              color: AppColors.lightGrey,
            ),
            PokemonImage(
              pokemon: pokemon,
              size: Size.square(pokemonSize),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(pokemon.name.capitalize()),
      ],
    );
  }
}

class _PokemonEvolution extends StatefulWidget {
  final PokemonDetailDataView pokemonDetail;

  const _PokemonEvolution(this.pokemonDetail);

  @override
  _PokemonEvolutionState createState() => _PokemonEvolutionState();
}

class _PokemonEvolutionState extends State<_PokemonEvolution> {
  Pokemon get pokemon => widget.pokemonDetail.pokemon;
  List<EvolutionDataView> get evolutions => widget.pokemonDetail.evolutions;

  Widget _buildRow({
    required Pokemon current,
    required Pokemon next,
    required String reason,
    required String? details,
  }) {
    return Row(
      children: <Widget>[
        Expanded(child: _PokemonBall(current)),
        Expanded(
          child: Column(
            children: <Widget>[
              const Icon(Icons.arrow_forward, color: AppColors.lightGrey),
              const SizedBox(height: 7),
              Text(reason, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              if (!details.isNullOrEmpty) ...{
                Text(
                  details ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              },
            ],
          ),
        ),
        Expanded(child: _PokemonBall(next)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final slideController = PokemonInfoStateProvider.of(context).slideController;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 31, horizontal: 28),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Evolution Chain',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 0.8,
            ),
          ),
          const SizedBox(height: 28),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const Divider(height: 58),
            itemCount: evolutions.length - 1,
            itemBuilder: (_, index) => _buildRow(
              current: evolutions[index].pokemon,
              next: evolutions[index + 1].pokemon,
              reason: evolutions[index + 1].cause,
              details: evolutions[index + 1].details,
            ),
          ),
        ],
      ),
    );
  }
}
