import 'dart:convert';

import 'package:food_booking/models/user_model.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  static final SPref instance = SPref._internal();
  SPref._internal();

  Future set(String key, String value) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    await spref.setString(key, value);
  }

  dynamic get(String key) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    return spref.get(key);
  }

  dynamic getLocalDevice() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String json = spref.get(AppConstants.KEY_STORED_DEVICE_INFO);
    if(json != null && json != '') {
//      return LocalDevice.fromJson(jsonDecode(json));
    }
    return null;
  }
}

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}