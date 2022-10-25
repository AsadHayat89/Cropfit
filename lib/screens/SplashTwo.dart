import 'dart:async';
import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:crop_fit/gen/assets.gen.dart';
class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() =>_SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  @override

  void initState(){
    //ToDO: Implement initState
    super.initState();
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const InvestorDashboard()));
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
                height: 250,
                width: 250,
                child:Image.asset("assets/Splash2.png"),
              ),
              const Text("CropFit..",
                style:TextStyle(fontSize:30,fontWeight:FontWeight.bold),),
              const Text("Caring Field,Caring Life",
                style:TextStyle(fontSize:15,fontWeight:FontWeight.bold),),

            ],
          ),
        ));
  }
}