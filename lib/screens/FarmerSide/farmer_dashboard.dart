import 'package:crop_fit/screens/FarmerSide/home.dart';
import 'package:crop_fit/screens/FarmerSide/profile.dart';
import 'package:crop_fit/screens/FarmerSide/setting.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../../data models/user.dart';
import '../onboarding_page.dart';


class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({Key? key}) : super(key: key);

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();

}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int selectedpage = 0;
  final _pageOption = [FarmerHome(),FarmerProfile(), FarmerProfileSettings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pageOption[selectedpage ],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
          items: [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.person, title: 'Profile'),
            TabItem(icon: Icons.settings, title: 'Settings'),
          ],
      initialActiveIndex: selectedpage,
      onTap: (int index)
        {
          setState((){
            selectedpage=index;
          });
        },

      ),
    );
  }
}
