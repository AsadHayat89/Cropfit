import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../utilities/top_level_variables.dart';
class InvestorSubmissionSplash extends StatelessWidget {
  const InvestorSubmissionSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InvestorSubmissionSplashScreen(),
    );
  }
}

class InvestorSubmissionSplashScreen extends StatelessWidget {
  const InvestorSubmissionSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/submission.json',),
          Text('Form Submitted',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
        ],) ,
      backgroundColor:Colors.black,
      //const Color.fromARGB(255, 16, 30, 2),
      nextScreen: InvestorDashboard(),
      splashIconSize: 500,
      duration: 1000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: Duration(seconds: 1),
    );
  }
}
