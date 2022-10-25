import 'dart:async';
import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/gen/assets.gen.dart';

import 'SplashTwo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() =>_SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState(){
    //ToDO: Implement initState
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SplashScreenTwo()));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: 800,

          // set the width of this Container to 100% screen width
          width: double.infinity,


          child: Column(
            // Vertically center the widget inside the column
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                child:Image.asset('assets/splash1.png'),
              ),
              const Text("Login Successful",
                style:TextStyle(fontSize:25,fontWeight:FontWeight.bold),),

            ],
          ),
        ));
  }
}