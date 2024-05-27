import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/config/image.dart';
import 'package:pokedex_app/config/router/app_router.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/presentation/extension/integer_extension.dart';
import 'package:pokedex_app/core/presentation/widget/main_app_bar.dart';
import 'package:pokedex_app/feature/home/presentation/widget/pokedex_paged_list.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../config/di/injection.dart';
import '../cubit/home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeCubit>(),
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, PokemonCardDataView> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final String pokedexTitle = 'Pok\u00e9dex';

  @override
  void initState() {
    _listenPagingController();

    super.initState();
  }

  void _listenPagingController() {
    _pagingController.addPageRequestListener((page) async {
      _fetchPokedex(page: page);
    });
  }

  void _fetchPokedex({
    required int page,
  }) {
    context.read<HomeCubit>().getPokedex(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _content(),
          _buildPokeballDecoration(height: 200),
        ],
      ),
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    return Positioned(
      top: -height * 0.24,
      right: -height * 0.3,
      child: Image(
        image: AppImages.pokeball,
        width: height,
        height: height,
        color: Colors.grey.withOpacity(0.14),
      ),
    );
  }

  Widget _content() {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        _onBlocStateChange(state);
      },
      child: CustomScrollView(slivers: [
        _buildAppBar(),
        _body(),
      ]),
    );
  }

  Widget _buildAppBar() {
    return Builder(builder: (context) {
      return MainSliverAppBar(
        context: context,
        title: pokedexTitle,
        surfaceTintColor: Colors.transparent,
      );
    });
  }

  Widget _body() {
    return MultiSliver(
      children: [
        const Gap(16),
        ..._pokedex(),
      ],
    );
  }

  List<Widget> _pokedex() {
    return [
      PokedexPagedList(
        onTap: _navigateToDetail,
        pagingController: _pagingController,
      ),
    ];
  }

  void _navigateToDetail(PokemonCardDataView data) {
    context.router.push(
      PokemonDetailRoute(id: data.id),
    );
  }

  void _onBlocStateChange(HomeState state) {
    if (state is GetPokedexLoaded) {
      _onPokedexLoaded(state);
    } else if (state is GetPokedexError) {
      _showSnackbarError(state.message);
    }
  }

  void _onPokedexLoaded(GetPokedexLoaded state) {
    final isLastPage = state.data.next.isNullOrEmpty;

    if (isLastPage) {
      _pagingController.appendLastPage(state.data.results);
    } else {
        final offset = int.tryParse(state.data.next?.getParam(ApiConstant.offset) ?? '');

        if (offset != null) {
          _pagingController.appendPage(state.data.results, offset.getPage());
        }
    }
  }

  int getPage(int total, int limit, int offset) {
    return offset >= total ? -1 : (offset ~/ limit) + 1;
  }

  void _showSnackbarError(String message) {
    context.showSnackBar(message: message);
  }
}