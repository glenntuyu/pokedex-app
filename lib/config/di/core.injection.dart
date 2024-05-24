import 'package:injectable/injectable.dart';
import 'package:pokedex/pokedex.dart';

import '../../core/data/network/api_client.dart';

@module
abstract class CoreInjectionModule {
  @lazySingleton
  ApiClient get apiClient => ApiClient();

  @singleton
  Pokedex get pokedex => Pokedex();
}