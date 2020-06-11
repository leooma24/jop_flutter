import 'package:flutter/material.dart';
import 'package:jop/src/core/consts.dart';
import 'package:jop/src/models/favorite_place_model.dart';
import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:jop/src/providers/place_provider.dart';
import 'package:provider/provider.dart';

class FavoriteBtn extends StatelessWidget {
  final Place place;
  const FavoriteBtn({Key key, this.place}) : super(key: key);
    @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    final PlaceProvider placeProvider = PlaceProvider(); 
    final favoritePlaceModel = Provider.of<FavoritePlaceModel>(context);
    if(place.favorite == 1) {
      favoritePlaceModel.add(place.id);
    }
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: favoritePlaceModel.items.contains(place.id) ? AppColors.accent : Colors.grey,
        borderRadius: BorderRadius.circular(100)
      ),
      child: IconButton(
        iconSize: 14,
        color: Colors.white,
        icon: Icon( Icons.favorite),
        onPressed: () {         
          if(prefs.isLogged) {
            placeProvider.changeFavorite(place);
            favoritePlaceModel.toggleFavorite(place);
          } else {
            print('Necesita estar logueado');
          }
        },
      ),
    );
  }
}