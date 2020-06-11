import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';

class CrearChip extends StatelessWidget {
  final double width;
  final IconData icon;
  final String texto;
  const CrearChip({Key key, this.width, this.icon, this.texto }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,                          
        children: <Widget>[
          Icon( icon, 
            color: AppColors.accent, 
            size: 14.0
          ),
          Text(texto, 
            style: TextStyle( 
              color: AppColors.accent,
              fontSize: 12.0
            ),
          ),
        ],
      ),
    );
  }
}