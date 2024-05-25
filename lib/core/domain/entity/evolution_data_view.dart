import 'package:pokedex/pokedex.dart';

class EvolutionDataView {
  EvolutionDataView({
    required this.pokemon,
    required this.cause,
    required this.details,
  });

  final Pokemon pokemon;
  final String cause;
  final String details;
}
