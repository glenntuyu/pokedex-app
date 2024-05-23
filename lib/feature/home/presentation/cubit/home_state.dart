part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetListPokemonLoading extends HomeState {}

final class GetListPokemonLoaded extends HomeState {
  final BaseListDataView<PokemonCardDataView> result;

  const GetListPokemonLoaded({
    required this.result
  });
}

final class GetListPokemonError extends HomeState {
  final String message;

  const GetListPokemonError({
    required this.message,
  });
}