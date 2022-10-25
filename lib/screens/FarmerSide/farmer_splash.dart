import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/top_level_variables.dart';
import 'farmer_dashboard.dart';

class FamSplash extends StatelessWidget {
  const FamSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FarmerSplashScreen(),
    );
  }
}

class FarmerSplashScreen extends StatelessWidget {
  const FarmerSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/loginsuccess.json'),
          // Lottie.asset('assets/handwritten-welcome.json'),
          Text('Login Successful',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        ],) ,
      backgroundColor: Colors.black,
      nextScreen: FarmerDashboard(),
      splashIconSize: 500,
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: Duration(seconds: 1),
    );
  }
}
