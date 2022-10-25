import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utilities/constants.dart';
import '../utilities/top_level_variables.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 137, 8, 1),

          title: const Text('Welcome Screen'),
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Image.asset(
                Assets.logo.path,
                // width: 7,
                height: 400,
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,),
                child: Text('    SIGNUP    '),
                onPressed: () async{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in ...')));
                  TopVariable.switchScreen(signupScreenPath);
                },
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,),
                child: Text('    LOGIN    '),
                onPressed: () async{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in ...')));
                  TopVariable.switchScreen(loginScreenPath);
                },
              ),
            ],
          ),
        )
    );
  }
}