import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jop/src/animations/fade_animation.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';

class PermisosPage extends StatelessWidget {
  const PermisosPage({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    checkPermisos(context);    
    return Scaffold(
      body:_pagina(context),
    );
  }

  void checkPermisos(context) async {
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    if(geolocationStatus == GeolocationStatus.granted) {
      Navigator.pushNamed(context, 'main');
    }
  }

  Widget _pagina(context) {
    return Stack(
      children: <Widget>[
        _fondoAplicacion(),
        _topCirculo(-200.0, 200.0),
        _bottomCirculo(-250.0,200.0),
        _contenido(context),
      ],
    );
  }

  Widget _contenido(context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              delay: .5,
              begin: 'top',
              child: Image(
                image: AssetImage('assets/img/logo-fondo-claro.png'),
                height: 160,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0,),
            FadeAnimation(
              delay: 2.5,
              begin: 'right',
              child: Container(
                width: 240,
                child: FlatButton(             
                  color: AppColors.primary, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),                
                  ),
                  child: Text('Permisos', style: TextStyle(color: Colors.white, fontSize: 20.0,)),
                  onPressed: () async {
                    final prefs = new PreferenciasUsuario();
                    final Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    final coordinates = new Coordinates(position.latitude, position.longitude);
                    final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);    
                    final first = addresses.first;
                    prefs.address = first.addressLine;
                    Navigator.pushNamed(context, 'main');       
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topCirculo(top, left) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 400,
        height: 400,      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          color: AppColors.primary
        ),
      ),
    );
  }

  Widget _bottomCirculo(bottom, right) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: Container(
        width: 400,
        height: 400,      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          color: AppColors.terceary
        ),
      ),
    );
  }
  
  Widget _fondoAplicacion() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.secondary,
    );
  }

}