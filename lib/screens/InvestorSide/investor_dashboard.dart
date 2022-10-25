import 'package:crop_fit/screens/InvestorSide/home.dart';
import 'package:crop_fit/screens/InvestorSide/profile.dart';
import 'package:crop_fit/screens/InvestorSide/setting.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class InvestorDashboard extends StatefulWidget {
  const InvestorDashboard({Key? key}) : super(key: key);

  @override
  State<InvestorDashboard> createState() => _InvestorSideState();
}

class _InvestorSideState extends State<InvestorDashboard> {
  int selectedpage = 0;
  final _pageOption = [InvestorHome(),InvestorProfile(),InvestorProfileSettings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pageOption[selectedpage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromRGBO(25, 137, 8, 1),
        items: const[
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
