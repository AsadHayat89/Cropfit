import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../screens/FarmerSide/edit_profile.dart';
import 'location_service.dart';
import 'mainscreen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    locationService();
  }

  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if(_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if(_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });

    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  MainScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return FarmerEditProfile();

  }
}