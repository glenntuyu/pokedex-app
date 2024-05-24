import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/presentation/extension/integer_extension.dart';
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
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: _sectionTitle('Pokedex'),
      centerTitle: true,
      leadingWidth: 40,
      automaticallyImplyLeading: false,
    );
  }

  Widget _body() {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        _onBlocStateChange(state);
      },
      child: CustomScrollView(
        slivers: [
          MultiSliver(
            children: [
              const Gap(16),
              ..._pokedex(),
            ],
          ),
        ],
      ),
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

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Text(
        text,
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _navigateToDetail(PokemonCardDataView post) {
    
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