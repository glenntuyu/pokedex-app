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

import '../../core/core.dart' as _i6;
import '../../core/data/network/api_client.dart' as _i4;
import '../../feature/detail/data/datasource/datasource.dart' as _i11;
import '../../feature/detail/data/datasource/detail_remote_datasource.dart'
    as _i7;
import '../../feature/detail/domain/repository/detail_repository.dart' as _i10;
import '../../feature/detail/domain/repository/repository.dart' as _i13;
import '../../feature/detail/domain/usecase/get_pokemon_detail_use_case.dart'
    as _i12;
import '../../feature/detail/domain/usecase/usecase.dart' as _i18;
import '../../feature/detail/presentation/cubit/pokemon_detail_cubit.dart'
    as _i17;
import '../../feature/feature.dart' as _i15;
import '../../feature/home/data/datasource/datasource.dart' as _i9;
import '../../feature/home/data/datasource/home_remote_datasource.dart' as _i5;
import '../../feature/home/domain/repository/home_repository.dart' as _i8;
import '../../feature/home/domain/usecase/get_pokedex_use_case.dart' as _i14;
import '../../feature/home/presentation/cubit/home_cubit.dart' as _i16;
import 'core.injection.dart' as _i19;

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
    gh.lazySingleton<_i5.HomeRemoteDataSource>(
        () => _i5.HomeRemoteDataSourceImpl(
              client: gh<_i6.ApiClient>(),
              pokedex: gh<_i3.Pokedex>(),
            ));
    gh.lazySingleton<_i7.DetailRemoteDataSource>(
        () => _i7.HomeRemoteDataSourceImpl(
              client: gh<_i6.ApiClient>(),
              pokedex: gh<_i3.Pokedex>(),
            ));
    gh.lazySingleton<_i8.HomeRepository>(() => _i8.HomeRepositoryImpl(
        remoteDataSource: gh<_i9.HomeRemoteDataSource>()));
    gh.lazySingleton<_i10.PokemonDetailRepository>(() =>
        _i10.PokemonDetailRepositoryImpl(
            remoteDataSource: gh<_i11.DetailRemoteDataSource>()));
    gh.lazySingleton<_i12.GetPokemonDetailUseCase>(
        () => _i12.GetPokemonDetailUseCase(gh<_i13.PokemonDetailRepository>()));
    gh.lazySingleton<_i14.GetPokedexUseCase>(
        () => _i14.GetPokedexUseCase(gh<_i15.HomeRepository>()));
    gh.factory<_i16.HomeCubit>(
        () => _i16.HomeCubit(gh<_i15.GetPokedexUseCase>()));
    gh.factory<_i17.PokemonDetailCubit>(
        () => _i17.PokemonDetailCubit(gh<_i18.GetPokemonDetailUseCase>()));
    return this;
  }
}

class _$CoreInjectionModule extends _i19.CoreInjectionModule {}
