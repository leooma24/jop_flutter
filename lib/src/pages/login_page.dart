import 'package:flutter/material.dart';

import 'package:jop/src/animations/fade_animation.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/user_model.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:jop/src/providers/user_provider.dart';
import 'package:jop/src/utils/utils.dart' as utils;

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final key = new GlobalKey<ScaffoldState>();
  UserModel user = new UserModel();
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {    
    checkLogin(context);    
    return Scaffold(
      key: key,
      body:_pagina(context),
    );
  }

  void checkLogin(context) async {
    final prefs = new PreferenciasUsuario();
    if(prefs.isLogged) {
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
        child: Form(
          key: formKey,
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
              _campoEmail(),
              _campoPassword(),
              FadeAnimation(
                delay: 2.5,
                begin: 'right',
                child: _crearBoton()
              ),
            ],
          ),
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
          color: AppColors.primary.withAlpha(200)
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
          color: AppColors.terceary.withAlpha(200)
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

  Widget _campoEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),      
      child: TextFormField(
        initialValue: user.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Correo',
          prefixIcon: Icon( Icons.mail_outline ),
          fillColor:  Colors.white
        ),
        onSaved: (email) => user.email = email,
        validator: (value) {
          if(value.isEmpty) return 'El Campo correo es requerido.';
          if(!utils.validateEmail(value)) return 'No es un correo válido.';
          return null;
        },
      ),
    );
  }

  Widget _campoPassword() {
    return Container(
      margin: EdgeInsets.only(left: 30.0, top: 15.0, right: 30.0),
      child: TextFormField(
        initialValue: user.password,
        keyboardType: TextInputType.text,
        obscureText: true,
        onSaved: (password) => user.password = password,
        decoration: InputDecoration(
          labelText: 'Contraseña',
          prefixIcon: Icon( Icons.lock_open ),
        ),
        validator: (value) {
          if(value.isEmpty) return 'El Campo contraseña es requerido.';
          if(value.length <= 5) return 'El Campo contraseña debe tener al menos 6 letras.';
          return null;
        },
      ),
    );
  }

  Widget _crearBoton() {
    return Container(
      width: double.infinity,
      height: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: FlatButton(             
        color: AppColors.primary, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 20.0,)),
        onPressed: _submit,
      ),
    );
  }

  _submit() async{
    if( !formKey.currentState.validate() )  return;
    
    formKey.currentState.save();    
    final response = await userProvider.login(user);
    if(response == true) {
      Navigator.pushNamed(context, 'permisos');
    } else {
      key.currentState.showSnackBar(new SnackBar(
        content: new Text(response),
      ));
    }

  }
}