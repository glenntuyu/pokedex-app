part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetPokedexLoading extends HomeState {}

final class GetPokedexLoaded extends HomeState {
  final BaseListDataView<PokemonCardDataView> data;

  const GetPokedexLoaded({
    required this.data
  });
}

final class GetPokedexError extends HomeState {
  final String message;

  const GetPokedexError({
    required this.message,
  });
}