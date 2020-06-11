

import 'dart:async';

import 'package:jop/src/models/place_model.dart';
import 'package:jop/src/providers/place_provider.dart';

class PlaceBlock {
  static final PlaceBlock _singleton = new PlaceBlock._internal();
  final _placeProvider = PlaceProvider();
  Place place;
  factory PlaceBlock() {
    return _singleton;
  }
  PlaceBlock._internal() {

  }

  final _placeController = StreamController<Place>.broadcast();

  dispose() {
    _placeController?.close();
  }

  Stream<Place> get placeStream => _placeController.stream;

  setPlace( int id ) async {
    place = await _placeProvider.getPlaceById(id);
    _placeController.sink.add(place);
  }


}