import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/screens/splash_screen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:get/get.dart';
import '../utilities/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';

import 'FarmerSide/farmer_splash.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initial Selected Value
  bool isProgressing = false;
  bool _obsecureText=true;
  final formKey = GlobalKey<FormState>();
  String? email, pw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 137, 8, 1),
          title: const Text('Login Screen'),
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            children: [
              Image.asset(
                Assets.logo.path,
                // width: 7,
                height: 300,
                fit: BoxFit.cover,
              ),
              TextFormField(
                validator: null,
                initialValue: '',
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'Email:',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: 'Enter Your Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  value='';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: null,
                initialValue: '',
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'Password:',
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                  suffixIcon: GestureDetector(onTap: (){
                    setState((){
                      _obsecureText=!_obsecureText;
                    });
                  },
                    child: Icon(_obsecureText?Icons.visibility_off:Icons.visibility),),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: 'Enter Your Password',
                ),
                keyboardType: TextInputType.text,
                obscureText:_obsecureText,
                onChanged: (value) {
                  pw = value;
                  value='';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              isProgressing
               ? Center(child: const CircularProgressIndicator())
               : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                  child: Text('    LOGIN    '),
                  onPressed: () async {
                  setState(() {
                    isProgressing = true;
                  });
                  await db.collection("users").doc(email).get().then((userEntry) {
                    if (userEntry.exists) {
                      User user = User.fromJson(userEntry.data()!);
                      if(pw==user.password) {
                        UserPreferences.user = user;
                        UserPreferences.userSignedIn = true;
                        print(user.type);
                        TopVariable.switchScreenAndRemoveAll( user.type == 'Farmer' ? farmerdashboardPath : user.type == 'Admin'? adminDashboardPath:investordashboardPath);
                      } else{
                        setState(() {
                          isProgressing = false;
                        });
                        MotionToast.error(
                          title:  Text("Error",style: TextStyle(fontWeight: FontWeight.bold),),
                          description:  Text("Please enter correct password"),
                        ).show(context);
                      }
                    } else {
                      setState(() {
                        isProgressing = false;
                      });
                      MotionToast.error(
                        title:  Text("User does not exist",style: TextStyle(fontWeight: FontWeight.bold),),
                        description:  Text("Please signup!"),
                      ).show(context);
                      // print('user does not exist\nPlease signup!');
                    }
                  });
                  setState(() {
                    isProgressing = false;
                  });
                  //  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in ...')));
                  // TopVariable.switchScreen(farmerdashboardPath);
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't remember Password "),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () => {
                          TopVariable.switchScreen(forgotPasswordScreenPath),
                        },
                        child: Text('Forgot Password ?'))
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account? "),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () => {
                          TopVariable.switchScreen(signupScreenPath),
                        },
                        child: Text('Signup'))
                  ],
                ),
              ),
              Center(
                 child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () => {
                        TopVariable.switchScreen(adminLoginScreenPath),
                      },
                      child: Text('GoTo Admin Account')),
              ),
            ],
          ),
        ));
  }
}