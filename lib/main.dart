import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(PokedexApp());
}

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex App',
      theme: FlexThemeData.light(
        scheme: FlexScheme.blueM3, 
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blueM3,
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
