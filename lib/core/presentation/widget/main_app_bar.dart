import 'package:flutter/material.dart';

const double mainAppearPadding = 28;

class MainAppBar extends AppBar {
  MainAppBar({Widget? title, required BuildContext context})
      : super(
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: mainAppearPadding),
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );
}
