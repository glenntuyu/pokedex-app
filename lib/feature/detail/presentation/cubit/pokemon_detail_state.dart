part of 'pokemon_detail_cubit.dart';

sealed class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object> get props => [];
}

final class PokemonDetailInitial extends PokemonDetailState {}

final class GetPokemonDetailLoading extends PokemonDetailState {}

final class GetPokemonDetailLoaded extends PokemonDetailState {
  final PokemonDetailDataView data;

  const GetPokemonDetailLoaded({
    required this.data
  });
}

final class GetPokemonDetailError extends PokemonDetailState {
  final String message;

  const GetPokemonDetailError({
    required this.message,
  });
}