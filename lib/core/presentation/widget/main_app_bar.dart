import 'package:flutter/material.dart';
import 'package:pokedex_app/core/presentation/extension/size.dart';

const double mainAppBarPadding = 28;

class MainSliverAppBar extends SliverAppBar {
  static const TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: kToolbarHeight / 3,
    height: 1,
  );

  MainSliverAppBar({
    GlobalKey? appBarKey,
    String title = 'Pok\u00e9dex',
    double height = kToolbarHeight + mainAppBarPadding * 2,
    double expandedFontSize = 30,
    void Function()? onTrailingPress,
    required BuildContext context,
    Color? surfaceTintColor,
  }): super(
        centerTitle: true,
        expandedHeight: height,
        floating: false,
        pinned: true,
        elevation: 0,
        surfaceTintColor: surfaceTintColor,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: mainAppBarPadding),
            icon: Icon(Icons.menu,
                color: Theme.of(context).textTheme.bodyLarge!.color),
            onPressed: onTrailingPress,
          ),
        ],
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final safeAreaTop = MediaQuery.of(context).padding.top;
            final minHeight = safeAreaTop + kToolbarHeight;
            final maxHeight = height + safeAreaTop;

            final percent =
                (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
            final fontSize = _textStyle.fontSize ?? 16;
            final currentTextStyle = _textStyle.copyWith(
              fontSize: fontSize + (expandedFontSize - fontSize) * percent,
            );

            final textWidth = getTextSize(context, title, currentTextStyle).width;
            const startX = mainAppBarPadding;
            final endX = MediaQuery.of(context).size.width / 2 -
                textWidth / 2 -
                startX;
            final dx = startX + endX - endX * percent;

            return Container(
              // color: Theme.of(context).backgroundColor.withOpacity(0.8 - percent * 0.8),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: kToolbarHeight / 3),
                    child: Transform.translate(
                      offset: Offset(dx, constraints.maxHeight - kToolbarHeight),
                      child: Text(
                        title,
                        style: currentTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}

class MainAppBar extends AppBar {
  MainAppBar({
    Widget? title, 
    required BuildContext context,
    bool centerTitle = false,
    Color? surfaceTintColor,
  })
      : super(
          centerTitle: centerTitle,
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            padding: const EdgeInsets.symmetric(horizontal: mainAppBarPadding),
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          surfaceTintColor: surfaceTintColor,
        );
}
