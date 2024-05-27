import 'package:flutter/material.dart';
import 'package:pokedex_app/config/colors.dart';
import 'package:pokedex_app/core/domain/entity/pokemon_types.dart';
import 'package:pokedex_app/feature/home/presentation/widget/spacer.dart';

class PokemonTypeWidget extends StatelessWidget {
  const PokemonTypeWidget(
    this.type, {
    Key? key,
    this.large = false,
    this.colored = false,
    this.extra = '',
  }) : super(key: key);

  final PokemonTypes type;
  final String extra;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
          left: large ? 19 : 12,
          top: large ? 8 : 6,
          right: large ? 19 : 8,
          bottom: large ? 6 : 4,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: (colored ? type.color : AppColors.whiteGrey).withOpacity(0.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.value,
              textScaleFactor: 1,
              style: TextStyle(
                  fontSize: large ? 12 : 9,
                  height: 0.8,
                  fontWeight: large ? FontWeight.bold : FontWeight.normal,
                  color: colored ? type.color : AppColors.whiteGrey),
              textAlign: TextAlign.center,
            ),
            HSpacer(5),
            Text(
              extra,
              textScaleFactor: 1,
              style: TextStyle(
                fontSize: large ? 12 : 9,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: colored ? type.color : AppColors.whiteGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
