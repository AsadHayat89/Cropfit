import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'location_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String country = '';
  String locality = '';
  String street = '';
  String subLocality = '';

  @override
  void initState() {
    super.initState();
    getLocation();
  }


  Future<void> getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

    print(placemark[0].country);
    print(placemark[0].locality);
    print(placemark[0].street);
    print(placemark[0].subLocality);

    setState(() {
      country = placemark[0].country!;
      locality= placemark[0].locality!;
      street = placemark[0].street!;
      subLocality =  placemark[0].subLocality!;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$street "+"$subLocality "+ "$locality, "+ "$country"),
          ],
        ),
      ),
    );
  }
}