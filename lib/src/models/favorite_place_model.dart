import 'package:flutter/cupertino.dart';
import 'package:jop/src/models/place_model.dart';

class FavoritePlaceModel extends ChangeNotifier {
  final List<int> _items = [];

  void toggleFavorite(Place place) {
    if( _items.contains(place.id) ) {
      _items.removeWhere((element) => element == place.id);
    } else {
      _items.add(place.id);
    }
    notifyListeners();
  }

  List<int> get items => _items;

  void add(int id) {
    if( !_items.contains(id) ) {
      _items.add(id);
    }
  }
}