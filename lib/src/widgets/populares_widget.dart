import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/favorite_place_model.dart';
import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/providers/place_provider.dart';
import 'package:jop/src/widgets/tarjeta_tipo_1.dart';
import 'package:provider/provider.dart';

class Populares extends StatelessWidget {
  const Populares({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final placeProvider = PlaceProvider();    
    print('popular list');
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text('Populares', style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold
              ))
            ),
            Container(
              margin: EdgeInsets.only(right: 16.0, top: 16.0),
              child: Text('Ver más', style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12.0,
                ),
                
              ),
            )
          ],
        ),
        FutureBuilder(
          future: placeProvider.getPopulares(),          
          builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
            if(snapshot.hasData) {
              final places = snapshot.data;
              return Container(
                margin: EdgeInsets.only(left: 4.0),
                height: 260.0,
                child: Swiper(
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {                    
                    return TarjetaTipo1(place: places[index]);
                  },
                  viewportFraction: 0.85,
                  scale: 0.9,
                  itemHeight: 250.0,                
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
          
        ),
      ],
    );
  }
}