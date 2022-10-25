import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/db_paths.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../gen/assets.gen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Text("Recover Password"),
      ),
      body: Column(
        children: [
         /* Container(
            margin: EdgeInsets.symmetric(horizontal: 20,),
            child:  Image.asset(
              Assets.forgotPass.path,
              // width: 7,
              height: 400,
            ),
          ),*/

          Lottie.asset('assets/forgotpassword.json',
            height: 300.0,
            repeat: true,
            reverse: true,
            animate: true,),
          Text(
            'Recover Password',
            style: TextStyle(fontSize:25, fontWeight: FontWeight.bold,color: Colors.amber),
          ),
         SizedBox(height: 20,),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 30),
           child:Text(
             'Recovered password will be sent to your Email ID !',
             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
           ),
         ),
          Expanded(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2.0),
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
                          onChanged: (value) {
                            userEmail = value;
                          },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      margin: EdgeInsets.only(left: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              if(userEmail.isNotEmpty){
                                db.collection(DbPaths.users).doc(userEmail).get().then((value) {
                                  User user = User.fromJson(value.data() as Map<String, dynamic>);
                                  sendEmail(user.name??'', user.email, user.password).then((status) {
                                    print(status);
                                    if(status==200){
                                      showToast('Email sent successfully!');
                                    }
                                  });
                                });
                              }
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.green,
                              ),
                              onPressed: () => {
                                    TopVariable.switchScreen(loginScreenPath),
                                  },
                              child: Text('Login'))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account? "),
                          TextButton(
                              onPressed: () => {
                                    TopVariable.switchScreen(signupScreenPath),
                                  },
                              child: Text(
                                'Signup',
                                style: TextStyle(color: Colors.green),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future sendEmail(String name, String email, String password) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_yr7datw';
    const templateId = 'template_pt8wdrs';
    const userId = 'XVGyLPkZDDrKqQ8q4';
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},//This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': 'ZN-GlH7aj6QTdt_cSfJ6h',
          'template_params': {
            'from_name': 'Cropfit',
            'to_name': name,
            'message': password,
            'reply_to': email
          }
        }));
    print(response.body);
    return response.statusCode;
  }
}
