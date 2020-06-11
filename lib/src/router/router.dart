import 'package:flutter/material.dart';

import 'package:jop/src/pages/detalle_page.dart';
import 'package:jop/src/pages/login_page.dart';
import 'package:jop/src/pages/main_page.dart';
import 'package:jop/src/pages/permisos_page.dart';
import 'package:jop/src/pages/start_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return {
    '/' : ( BuildContext context ) => StartPage(),
    'main' : ( BuildContext context ) => MainPage(),
    'permisos' : ( BuildContext context ) => PermisosPage(),
    'detalle' : ( BuildContext context ) => DetallePage(),
    'login' : ( BuildContext context ) => LoginPage(),
  };
}