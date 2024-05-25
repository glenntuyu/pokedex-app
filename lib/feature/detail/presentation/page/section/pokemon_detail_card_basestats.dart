part of '../pokemon_detail_page.dart';

class Stat extends StatelessWidget {
  final Animation animation;
  final String label;
  final double? progress;
  final num value;

  const Stat({
    required this.animation,
    required this.label,
    required this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              final currentProgress = progress ?? value / 100;

              return ProgressBar(
                progress: animation.value * currentProgress,
                color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
                enableAnimation: animation.value == 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PokemonBaseStats extends StatefulWidget {
  final PokemonDetailDataView pokemonDetail;

  const _PokemonBaseStats(this.pokemonDetail);

  @override
  State<_PokemonBaseStats> createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<_PokemonBaseStats> with SingleTickerProviderStateMixin {
  late Animation<double> _progressAnimation;
  late AnimationController _progressController;

  PokemonDetailDataView get pokemonDetail => widget.pokemonDetail;
  Pokemon get pokemon => pokemonDetail.pokemon;

  AnimationController get slideController => PokemonDetailStateProvider.of(context).slideController;

  @override
  void initState() {
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _progressController,
    ));

    _progressController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildStats(pokemon.stats),
          const SizedBox(height: 27),
          const Text(
            'Type defenses',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 0.8,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'The effectiveness of each type on ${pokemon.name.capitalize().replaceGenderSuffixes()}.',
            style: TextStyle(color: AppColors.black.withOpacity(0.6)),
          ),
          const SizedBox(height: 15),
          _buildEffectivenesses(pokemonDetail.typeEffectiveness),
        ],
      ),
    );
  }

  Widget buildStats(List<PokemonStat> stats) {
    int statTotal = stats.map((e) => e.baseStat).sum;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var data in stats) ...[
          Stat(animation: _progressAnimation, label: data.stat.name.toStatName(), value: data.baseStat),
          const SizedBox(height: 14),
        ],
        Stat(
          animation: _progressAnimation,
          label: 'Total',
          value: statTotal,
          progress: statTotal / 600,
        ),
      ],
    );
  }

  Widget _buildEffectivenesses(Map<PokemonTypes, double> typeEffectiveness) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: typeEffectiveness.keys
          .map(
            (type) => PokemonTypeWidget(
              type,
              large: true,
              colored: true,
              extra: 'x${removeTrailingZero(typeEffectiveness[type] ?? 1)}',
            ),
          )
          .toList(),
    );
  }
}
