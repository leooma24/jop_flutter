import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';

class PlaceProvider {
  static final PlaceProvider _instancia = new PlaceProvider._internal();
  final _prefs = new PreferenciasUsuario();

  factory PlaceProvider() {    
    return _instancia;
  }
  PlaceProvider._internal();

  Map<String,String> headers = {
    'Content-type' : 'application/x-www-form-urlencoded', 
    'Accept': 'application/json',
  };
  bool isLoading = false;
  
  Future<List<Place>> getPopulares() async {        
    if(isLoading == true) return [];    
    print('populars');
    isLoading = true;    
    final url = Uri.http(Api.url, '/api/place/searchByType' + (_prefs.isLogged ? '' : '/guest') );
    final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);    
    final first = addresses.first;
    _prefs.address = first.addressLine;    
    if(_prefs.isLogged) {
      headers['Authorization'] = 'Bearer ${_prefs.token}';
    }    
    try {
      final response = await http.post(url, body: {      
          'option': 'populars',
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'distance': Api.distance.toString()
        },
        headers: headers
      );

      final decodedData = json.decode(response.body);
      final places = new Places.fromJsonList(decodedData['result']);
      isLoading = false;
      return places.items;
      
    }catch(e) {
      print('error');
      print(e.toString());
      isLoading = false;
      return [];
    }
  }

  Future<bool> changeFavorite(Place place) async {
    final url = Uri.http(Api.url, '/api/place/favorite/${place.id}');
    headers['Authorization'] = 'Bearer ${_prefs.token}';    
    try {
      final response = await http.get(
        url,
        headers: headers
      );
      
      isLoading = false;

      return true;
    } catch( e) {
      print('error');
      print(e.toString());
      isLoading = false;
      return false;
    }
  }

  Future<Place> getPlaceById(int id) async {
    final isLogged = _prefs.isLogged ? '' : 'guest/';
    final url = Uri.http(Api.url, '/api/place/view/$isLogged$id');
    headers['Authorization'] = 'Bearer ${_prefs.token}';  
    final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);  
    try {
      final response = await http.post(
        url,
        body: {      
          'option': 'populars',
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'distance': Api.distance.toString()
        },
        headers: headers
      );

      final decodedData = json.decode(response.body);      
      final place = Place.fromJsonMap(decodedData['result']);
      isLoading = false;

      return place;
    } catch( e) {
      print('error');
      print(e.toString());
      isLoading = false;
      return null;
    }
  }
}
