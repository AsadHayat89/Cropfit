import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<NavigatorState> appNavigationKey = GlobalKey<NavigatorState>();
double? screenWidth =
    MediaQuery.of(appNavigationKey.currentContext!).size.width;
double? screenHeight =
    MediaQuery.of(appNavigationKey.currentContext!).size.height;
ThemeData appTheme = Theme.of(appNavigationKey.currentContext!);
final db = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance.ref();
final storageProfilePics = storage.child("profile_pics");
final storageCnicPics = storage.child("cnic_pics");
final storageCoverPics = storage.child("cover_pics");


///     TOP LEVEL FUNCTIONS
showToast(String msg) {
  ScaffoldMessenger.of(appNavigationKey.currentContext!).showSnackBar(SnackBar(
    content: Text(msg),
  ));
}
class TopVariable {
  static switchScreenAndRemoveAll(String screenName) {
    Navigator.of(appNavigationKey.currentContext!)
        .pushNamedAndRemoveUntil(screenName, (Route<dynamic> route) => false);
  }
  static switchScreen(String screenName) {
    Navigator.of(appNavigationKey.currentContext!).pushNamed(screenName);
  }
}