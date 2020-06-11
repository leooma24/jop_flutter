import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {    
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;
  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get usuarioId {
    return _prefs.getInt('usuarioId');
  }

  set usuarioId( int usuarioId ) {
    _prefs.setInt('usuario', usuarioId);
  }

  get token {
    return _prefs.getString('token');
  }

  set token( String token ) {
    _prefs.setString('token', token);
  }

  get isLogged {
    return _prefs.getBool('isLogged') ?? false;
  }

  set isLogged( bool value) {
    _prefs.setBool('isLogged', value);
  }

  get address {
    return _prefs.getString('address') ?? '';
  }

  set address( String address ) {
    _prefs.setString('address', address);
  }
}