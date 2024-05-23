import 'package:flutter/material.dart';
import 'package:pokedex_app/config/image.dart';

import '../../../../core/presentation/extension/extension.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      width: context.width,
      child: Center(
        child: _buildLoading(),
      ),
    );
  }
}

Widget _buildLoading() {
  return const Center(
    child: Image(image: AppImages.pikloader),
  );
}
