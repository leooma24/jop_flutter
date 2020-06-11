
import 'dart:convert';

String userModelToJson( UserModel data) => json.encode( data.toJson() );

class UserModel {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.password
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "password": password,
  };

}