import 'package:flutter/material.dart';
import 'package:jop/src/animations/fade_animation.dart';
import 'package:jop/src/core/consts.dart';
  
class StartPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          _pagina1(),
          _pagina2(context),
        ],
      ),
    );
  }

  Widget _pagina2(context) {
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
              delay: 1.0,
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
              delay: 1,
              begin: 'right',
              child: Container(
                width: 240,
                child: FlatButton(             
                  color: AppColors.primary, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),                
                  ),
                  child: Text('Identificarse', style: TextStyle(color: Colors.white, fontSize: 20.0,)),
                  onPressed: () {},
                ),
              ),
            ),
            FadeAnimation(
              delay: 1.5,
              begin: 'left',
              child: Container(
                width: 240,
                child: FlatButton(             
                  color: AppColors.terceary, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),                
                  ),
                  child: Text('Registrarse', style: TextStyle(color: Colors.white, fontSize: 20.0,)),
                  onPressed: () {},
                ),
              ),
            ),
            FadeAnimation(
              delay: 2.0,
              begin: 'bottom',
              child: Container(
                width: 240,
                child: FlatButton(
                  child: Text('Entrar como invitado', style: TextStyle(color: AppColors.primary, fontSize: 20.0,)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'permisos');
                  },
                ),
              ),
            )
          ],
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

   Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _fondoAplicacion(),
        _topCirculo(-200.0, -200.0),
        _bottomCirculo(-250.0, -200.0),
        _contenidoBienvenida(),
      ],
    );
  }

  Widget _contenidoBienvenida() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FadeAnimation(
              delay: 1.0,
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
              delay: 1.5,
              begin: 'left',
              child: Text('El sitio perfecto', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),)),            
            FadeAnimation(
              delay: 2.0,
              begin: 'right',
              child: Text('para encontrar lo que se te antoje.', 
                style: TextStyle(fontSize: 22.0), textAlign: TextAlign.center,)
            )
          ],
        ),
      ),
    );
  }
}