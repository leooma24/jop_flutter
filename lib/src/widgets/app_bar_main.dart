import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';

class AppBarMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    return Row(
      children: <Widget>[        
        Expanded(      
          child: Container(  
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[                
                Container(
                  width: double.infinity,
                  child: Text('Mi Ubicación:', style: TextStyle(
                      color: AppColors.secondary, fontSize: 11.0
                    )
                  )
                ),                
                Container(
                  width: 200.0,
                  child: Text(prefs.address, style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11.0
                    )
                  )
                ),
              ],
            ),
          ),
        ),        
        Container(
          height: 35.0,
          width: 35.0,                           
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),            
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage('https://api.jop.cool/storage/profile/profile-1.jpg'),
              fit: BoxFit.cover              
            ),       
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ]     
          ),                    
        )
      ],
    );
  }
}