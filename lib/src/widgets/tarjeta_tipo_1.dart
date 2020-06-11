import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/widgets/favorite_btn.dart';

import 'crear_chip.dart';

class TarjetaTipo1 extends StatelessWidget {
  final Place place; 
  const TarjetaTipo1({Key key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {       
    final _size = MediaQuery.of(context).size;
    print('nuevo');    
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: place);
      },
      child: Card(    
        clipBehavior: Clip.antiAlias,
        elevation: 1,      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: _size.width * .9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: place.id,
                      child: Container(
                        padding: EdgeInsets.all(10.0),                                                
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: FadeInImage (
                          height: 160.0,
                          width: double.infinity,
                          image: place.getBanner(),
                          placeholder: AssetImage(place.getPlaceholderImage()),
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(milliseconds: 1000),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 15,            
                      child: FavoriteBtn(place: place),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: 
                  Text(place.name, 
                    style: AppFontStyles.titulo, 
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: 
                  Text(place.address,
                    style: AppFontStyles.subtitulo, 
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
              ),
              SizedBox(height: 2.0,),
              Container(              
                padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                child: Row(                                    
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon( Icons.star, color: AppColors.accent, size: 20.0, ),
                          Text(place.rating.toString(), style: TextStyle(fontWeight: FontWeight.bold,),),
                          Text('(${place.ratingUsers}) Reseñas', style: TextStyle(color: Colors.grey, fontSize: 10.0),),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          CrearChip(
                            width: 60.0,
                            icon: Icons.location_on,
                            texto: '${place.distance}k'),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Container(
                      child: Row(
                        children: <Widget>[
                          CrearChip(
                            width: 60.0,
                            icon: Icons.access_time,
                            texto: "${place.time}'")
                        ],
                      ),
                    ),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}