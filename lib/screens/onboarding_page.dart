import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../data models/user.dart';
import '../utilities/constants.dart';
import '../utilities/shared_preferences.dart';
import '../utilities/top_level_variables.dart';
import '../widgets/build_images.dart';
import 'InvestorSide/home.dart';

class PageOnBorarding extends StatelessWidget {
  User user = UserPreferences.user;

  PageOnBorarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome',
            body:
            'CropFit! Caring Fields,Caring Life ',
            image: const BuildImages(image: 'assets/organic.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Investment Platform',
            body:
            'Investing in agriculture means putting your money behind food and crop production, processing, and distribution',
            image: const BuildImages(image: 'assets/ip.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Healthy Crops',
            body:
            'A healthy soil produces healthy crops with minimal amounts of external inputs and few to no adverse ecological effects.',
            image: const BuildImages(image: 'assets/healthy.PNG'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Lets Get Started',
            body:
            '',
            image: const BuildImages(image: 'assets/started.PNG'),
           // footer: ElevatedButton(
             // onPressed: () => goToHome(context),
              //child: const Text('Home'),
            //),
          )
        ],
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: const Text('Skip'),
        // onSkip: () => print('skip'),
        // showBackButton: true,
        // back: const Icon(Icons.arrow_back),
        dotsDecorator: getDotDecoration(),
        nextFlex: 0,
        skipOrBackFlex: 0,
        animationDuration: 500,
        isProgressTap: true,
        isProgress: true,
        // freeze: false,
        onChange: (index) => print(index),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(24),
      titlePadding: EdgeInsets.zero,
      bodyPadding: EdgeInsets.all(20),
      pageColor: Colors.white,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: const Color(0xFFBDBDBD),
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: Colors.orange,
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }

  void goToHome(context) {
    print("here aya ha");
    user.type == 'Farmer' ? TopVariable.switchScreenAndRemoveAll(farmerdashboardPath) : user.type == 'Admin'?TopVariable.switchScreenAndRemoveAll(farmerdashboardPath):TopVariable.switchScreenAndRemoveAll(investordashboardPath);
   // Navigator.pushReplacement(
     // context,
      //MaterialPageRoute(builder: (context) => const InvestorHome()),
    //);
  }
}