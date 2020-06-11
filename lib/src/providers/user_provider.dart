import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/user_model.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';

class UserProvider {
  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
  };

  Future<dynamic> login( UserModel user ) async{
    final url = Uri.http(Api.url, '/api/login');
    
    final response = await http.post(url, body: userModelToJson(user), headers: headers );
    
    final decodedData = json.decode(response.body);
    print(decodedData);
    if( decodedData is String) {      
      return decodedData;
    } else {
      if(decodedData['access_token'] == null) {
        if(decodedData['errors']['password'] != null)
          return decodedData['errors']['password'].join(' ');
        else 
          return decodedData['errors']['email'].join(' ');
      } else {
        final prefs = new PreferenciasUsuario();
        prefs.token = decodedData['access_token'];
        prefs.isLogged = true;
        return true;
      }
    }
  }
}