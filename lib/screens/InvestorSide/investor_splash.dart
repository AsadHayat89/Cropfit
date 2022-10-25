import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class InSplash extends StatelessWidget {
  const InSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InvestorSplashScreen(),
    );
  }
}

class InvestorSplashScreen extends StatelessWidget {
  const InvestorSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/success.json'),
          // Lottie.asset('assets/handwritten-welcome.json'),
          Text('Login Successful',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        ],) ,
      backgroundColor: Colors.green,
      nextScreen: InvestorDashboard(),
      splashIconSize: 500,
      duration: 3000,
      splashTransition: SplashTransition.decoratedBoxTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: Duration(seconds: 1),
    );
  }
}
