// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:pokedex/pokedex.dart' as _i3;

import '../../core/core.dart' as _i7;
import '../../core/data/network/api_client.dart' as _i4;
import '../../core/domain/entity/evolution_mapper.dart' as _i5;
import '../../feature/detail/data/datasource/datasource.dart' as _i10;
import '../../feature/detail/data/datasource/detail_remote_datasource.dart'
    as _i8;
import '../../feature/detail/domain/repository/detail_repository.dart' as _i9;
import '../../feature/detail/domain/repository/repository.dart' as _i14;
import '../../feature/detail/domain/usecase/get_pokemon_detail_use_case.dart'
    as _i13;
import '../../feature/detail/domain/usecase/usecase.dart' as _i19;
import '../../feature/detail/presentation/cubit/pokemon_detail_cubit.dart'
    as _i18;
import '../../feature/feature.dart' as _i16;
import '../../feature/home/data/datasource/datasource.dart' as _i12;
import '../../feature/home/data/datasource/home_remote_datasource.dart' as _i6;
import '../../feature/home/domain/repository/home_repository.dart' as _i11;
import '../../feature/home/domain/usecase/get_pokedex_use_case.dart' as _i15;
import '../../feature/home/presentation/cubit/home_cubit.dart' as _i17;
import 'core.injection.dart' as _i20;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreInjectionModule = _$CoreInjectionModule();
    gh.singleton<_i3.Pokedex>(() => coreInjectionModule.pokedex);
    gh.lazySingleton<_i4.ApiClient>(() => coreInjectionModule.apiClient);
    gh.factory<_i5.EvolutionMapper>(() => _i5.EvolutionMapperImpl());
    gh.lazySingleton<_i6.HomeRemoteDataSource>(
        () => _i6.HomeRemoteDataSourceImpl(
              client: gh<_i7.ApiClient>(),
              pokedex: gh<_i3.Pokedex>(),
            ));
    gh.lazySingleton<_i8.DetailRemoteDataSource>(
        () => _i8.HomeRemoteDataSourceImpl(
              client: gh<_i7.ApiClient>(),
              pokedex: gh<_i3.Pokedex>(),
            ));
    gh.lazySingleton<_i9.PokemonDetailRepository>(
        () => _i9.PokemonDetailRepositoryImpl(
              remoteDataSource: gh<_i10.DetailRemoteDataSource>(),
              evolutionMapper: gh<_i5.EvolutionMapper>(),
            ));
    gh.lazySingleton<_i11.HomeRepository>(() => _i11.HomeRepositoryImpl(
        remoteDataSource: gh<_i12.HomeRemoteDataSource>()));
    gh.lazySingleton<_i13.GetPokemonDetailUseCase>(
        () => _i13.GetPokemonDetailUseCase(gh<_i14.PokemonDetailRepository>()));
    gh.lazySingleton<_i15.GetPokedexUseCase>(
        () => _i15.GetPokedexUseCase(gh<_i16.HomeRepository>()));
    gh.factory<_i17.HomeCubit>(
        () => _i17.HomeCubit(gh<_i16.GetPokedexUseCase>()));
    gh.factory<_i18.PokemonDetailCubit>(
        () => _i18.PokemonDetailCubit(gh<_i19.GetPokemonDetailUseCase>()));
    return this;
  }
}

class _$CoreInjectionModule extends _i20.CoreInjectionModule {}
