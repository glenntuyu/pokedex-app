import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/core/core.dart';
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
      _fetchTopRatedData(page: page);
    });
  }

  void _fetchTopRatedData({
    required int page,
  }) {
    context.read<HomeCubit>().getListPokemon(page: page);
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
      title: Text(
        'LaMov',
        style: context.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leadingWidth: 40,
      automaticallyImplyLeading: false,
      actions: [
        _notificationIcon(),
      ],
      leading: _profileAvatar(),
    );
  }

  Widget _notificationIcon() {
    return Container(
      height: 26,
      width: 26,
      margin: const EdgeInsets.only(right: 16),
      child: SvgPicture.asset(
        'assets/icon/notification.svg',
        fit: BoxFit.fitWidth,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _profileAvatar() {
    return Transform.translate(
      offset: const Offset(16, 0),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(
          'assets/avatar/profile.svg',
          height: 32,
          width: 32,
        ),
      ),
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
      SliverToBoxAdapter(
        child: _sectionTitle('Pokedex'),
      ),
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
    if (state is GetListPokemonLoaded) {
      _onListPokemonLoaded(state);
    } else if (state is GetListPokemonError) {
      _showSnackbarError(state.message);
    }
  }

  void _onListPokemonLoaded(GetListPokemonLoaded state) {
    final isLastPage = state.result.next.isNullOrEmpty;

    if (isLastPage) {
      _pagingController.appendLastPage(state.result.results);
    } else {
        final nextPageKey = 1 + 1;
        _pagingController.appendPage(state.result.results, nextPageKey);
    }
  }

  int getPage(int total, int limit, int offset) {
    return offset >= total ? -1 : (offset ~/ limit) + 1;
  }

  void _showSnackbarError(String message) {
    context.showSnackBar(message: message);
  }
}