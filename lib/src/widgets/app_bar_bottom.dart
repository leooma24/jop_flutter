import 'package:flutter/material.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';

class AppBarBottom extends StatelessWidget {
  const AppBarBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    return BottomAppBar(
      shape: CircularNotchedRectangle(),        
      child: Container(
        height: 60.0,
        child: BottomNavigationBar(    
          type: BottomNavigationBarType.fixed,               
          items: <BottomNavigationBarItem>[
            _crearOption(Icons.search, 'Explorar'),
            _crearOption(Icons.local_offer, 'Promociones'),
            _crearOption(Icons.favorite, 'Favoritos'),
            _crearOption(Icons.timeline, 'Actividad'),
            _crearOption(Icons.account_circle, 'Cuenta'),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.amber[800],
          onTap: (value) {
            if(value == 3 ) {
              if(!prefs.isLogged) {
                Navigator.pushNamed(context, 'login');
              }
            }
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _crearOption(IconData icon, String texto) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 20.0,),
      title: Text(texto)
    );
  }
}