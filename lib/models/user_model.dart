
import 'dart:convert';

import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/app_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  final String name;
  final String password;
  final String image;

  UserProfile({this.name, this.password,this.image});

  UserProfile.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'image': image,
        'email': password,
      };
  static String encodeUserProfiles(UserProfile userProfile) {
    var json = jsonEncode(userProfile.toJson());
    return json;
  }
  static setUser(String userName) async{
    SharedPreferences spref = await SharedPreferences.getInstance();
    spref.setString(AppConstants.KEY_STORED_USER, userName);
  }
  static dynamic getUser() async{
    SharedPreferences spref = await SharedPreferences.getInstance();
    String userName =  spref.getString(AppConstants.KEY_STORED_USER);
    if(userName != null) {return userName;} else {return null;}
  }
}