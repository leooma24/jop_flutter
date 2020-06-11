import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';

import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:jop/src/router/router.dart';
import 'package:provider/provider.dart';

import 'src/models/favorite_place_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new FavoritePlaceModel(),
      child: MaterialApp(
        title: 'Jop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: AppColors.primary
        ),
        initialRoute: 'main',
        routes: getApplicationRoutes(),
      )
    );
  }
}