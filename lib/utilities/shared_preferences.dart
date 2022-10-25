import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data models/admin.dart';
import '../data models/user.dart';
import 'constants.dart';

late SharedPreferences prefs;
initializePreferences() async{
  prefs = await SharedPreferences.getInstance();
}
class UserPreferences {
  static User get user => User.fromJson(jsonDecode(prefs.getString(Constants.keyUser,) ?? '{}'));
  static set user(User user){
    prefs.setString(Constants.keyUser,jsonEncode(user.toJson()));
  }
  static bool get userSignedIn => prefs.getBool(Constants.keySignedIn,) ?? false;
  static set userSignedIn(bool userSignedIn){
    prefs.setBool(Constants.keySignedIn,userSignedIn);
  }

  static clear() {
    prefs.clear();
  }
}

class AdminPreferences {
  static Admin get admin => Admin.fromJson(jsonDecode(prefs.getString(Constants.keyAdmin,) ?? '{}'));
  static set admin(Admin admin){
    prefs.setString(Constants.keyAdmin,jsonEncode(admin.toJson()));
  }
  static bool get adminSignedIn => prefs.getBool(Constants.keySignedIn,) ?? false;
  static set adminSignedIn(bool adminSignedIn){
    prefs.setBool(Constants.keySignedIn,adminSignedIn);
  }
}