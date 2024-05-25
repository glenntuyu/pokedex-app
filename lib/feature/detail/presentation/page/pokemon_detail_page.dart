import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/pokedex.dart';
import 'package:pokedex_app/config/colors.dart';
import 'package:pokedex_app/config/image.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/core/domain/entity/evolution_data_view.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_detail_data_view.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';
import 'package:pokedex_app/core/presentation/extension/integer_extension.dart';
import 'package:pokedex_app/core/presentation/extension/iterable_extension.dart';
import 'package:pokedex_app/feature/detail/presentation/page/section/progress.dart';
import 'package:pokedex_app/feature/detail/presentation/page/state_provider.dart';
import 'package:pokedex_app/feature/detail/presentation/widget/animated_fade.dart';
import 'package:pokedex_app/feature/detail/presentation/widget/auto_slideup_panel.dart';
import 'package:pokedex_app/feature/detail/presentation/widget/main_tab_view.dart';
import 'package:pokedex_app/core/presentation/widget/pokemon_type_widget.dart';
import 'package:pokedex_app/feature/detail/presentation/widget/pokemon_image.dart';

import '../../../../config/di/injection.dart';
import '../cubit/pokemon_detail_cubit.dart';

part 'section/background_decoration.dart';
part 'section/pokemon_detail_card.dart';
part 'section/pokemon_detail_card_about.dart';
part 'section/pokemon_detail_card_basestats.dart';
part 'section/pokemon_detail_card_evolution.dart';

@RoutePage()
class PokemonDetailPage extends StatefulWidget implements AutoRouteWrapper {
  final int id;

  const PokemonDetailPage({
    @PathParam('id') required this.id,
  });

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PokemonDetailCubit>(),
      child: this,
    );
  }
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();

    _getPokemonDetail();

    super.initState();
  }

  void _getPokemonDetail() {
    context.read<PokemonDetailCubit>().getPokemonDetail(widget.id);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PokemonInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: Scaffold(
        body: BlocConsumer<PokemonDetailCubit, PokemonDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetPokemonDetailLoaded) {
              return Stack(
                children: <Widget>[
                  const _BackgroundDecoration(),
                  _PokemonInfoCard(pokemonDetail: state.data),
                  // _PokemonOverallInfo(),
                ],
              );
            }

            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}


