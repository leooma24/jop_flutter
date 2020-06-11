import 'package:flutter/cupertino.dart';

class Places {
  List<Place> items = new List();

  Places();

  Places.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for( var item in jsonList ) {
      final place = new Place.fromJsonMap(item);
      items.add( place );
    }
  }
}

class Place {
  int id;
  String name;
  String phone;
  String postalCode;
  String description;
  double latitude;
  double longitude;
  String banner;
  String address;
  double rating;
  double ratingUsers;
  int checkIn;
  int views;
  int homeService;
  double distance;
  double time;
  int favorite;
  int openNow;

  Map<dynamic, dynamic> daySchedule;

  Place({
    this.id,
    this.name,
    this.phone,
    this.postalCode,
    this.description,
    this.latitude,
    this.longitude,
    this.banner,
    this.address,
    this.rating,
    this.ratingUsers,
    this.checkIn,
    this.views,
    this.homeService,
    this.distance,
    this.time,
    this.favorite,
    this.openNow,

    this.daySchedule
  });

  Place.fromJsonMap( Map<String, dynamic> json ) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    postalCode = json['postal_code'];
    description = json['description'];
    latitude = json['latitude'] / 1;
    longitude = json['longitude'] / 1;
    banner = json['banner'];
    address = json['address'];
    rating = json['rating'] / 1;
    ratingUsers = json['rating_users'] / 1;
    checkIn = json['check_in'];
    views = json['views'];
    homeService = json['home_service'];
    distance = json['distance'] != null ? json['distance'] / 1 : 0.0;
    time = json['time'] / 1;
    favorite = json['favorite'];    
    openNow = json['open_now'];

    daySchedule = json['day_schedule'] != null ? json['day_schedule'] : null;
    
  }

  getBanner() {
    if(banner == null || banner.isEmpty)
     return AssetImage('assets/img/default-restaurant.jpg');
    return NetworkImage('$banner');
  }

  getPlaceholderImage() {
    return 'assets/img/default-restaurant.jpg';
  }

  toggleFavoriteStatus() {
    favorite = favorite == 1 ? 0 : 1;
  }

  String get getScheduleDay {    
    if(daySchedule != null) {
      return daySchedule['day'] + ' ' + recortarTiempo(daySchedule['begin_time']) + '-'  + recortarTiempo(daySchedule['end_time']);
    }
    return '';
  }

  String get getOpenNow {
    return openNow == 1 ? 'Abierto' : 'Cerrado';
  }

  String recortarTiempo(String time ) {
    return time.substring(0, 5);
  }
}