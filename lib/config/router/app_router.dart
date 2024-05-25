import 'package:auto_route/auto_route.dart';

import '../../feature/home/presentation/page/home_page.dart';
import '../../feature/detail/presentation/page/pokemon_detail_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/',
        ),
        AutoRoute(
          page: PokemonDetailRoute.page,
          path: '/detail/:id',
        ),
      ];
}
