import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/screens/splash_screen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../data models/admin.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // Initial Selected Value
  bool _obsecureText=true;
  final formKey = GlobalKey<FormState>();
  String? email, pw;
  Admin admin = Admin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 137, 8, 1),
          title: const Text('Admin Login Screen'),
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            children: [
              Image.asset(
                Assets.logo.path,
                // width: 7,
                height: 400,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('    LOGIN    '),
                onPressed: () async {

                },
              ),
            ],
          ),
        ));
  }
}