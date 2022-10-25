import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data models/user.dart';
import '../../utilities/constants.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class InvestorProfileSettings extends StatefulWidget {
  const InvestorProfileSettings({Key? key}) : super(key: key);

  @override
  State<InvestorProfileSettings> createState() => _InvestorProfileSettingsState();
}

class _InvestorProfileSettingsState extends State<InvestorProfileSettings> {
  User user = UserPreferences.user;
  final Uri _url = Uri.parse('https://drive.google.com/file/d/18m23kcGwD65hkzm_ZPlz0mYyYGyBmTxx/view?usp=sharing');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Settings'),),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Edit Profile'),
            trailing:IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                TopVariable.switchScreen(InvesProfilePath);

              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text('Change Password'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                TopVariable.switchScreen(changedPasswordPath);
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Delete Account'),
            trailing:IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                Warning();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text('Deactivate Account'),
            trailing:IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening Editor ...')));

              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text('Policy'),
            trailing:IconButton(
              icon: Icon(Icons.security),
              onPressed: () async {
                _launchUrl();
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            trailing: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Logging out'),
                        content: Text('Are you sure?'),

                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: Text('No'),
                              onPressed: () async {
                                Navigator.pop(context);
                              }),
                          SizedBox(width: 15),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: Text('Yes'),
                              onPressed: () async {
                                // user.email='';
                                // value='';
                                UserPreferences.userSignedIn = false;
                                TopVariable.switchScreenAndRemoveAll(loginScreenPath);

                              }),

                        ],
                      );
                      //   Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.green,),
                      //   child: AlertDialog(
                      //     title: Text('Logging out'),
                      //     content: Text('Are you sure?'),
                      //
                      //     actions: [
                      //       ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             primary: Colors.green,
                      //           ),
                      //           child: Text('No'),
                      //           onPressed: () async {
                      //             Navigator.pop(context);
                      //           }),
                      //       SizedBox(width: 15),
                      //       ElevatedButton(
                      //           style: ElevatedButton.styleFrom(
                      //             primary: Colors.green,
                      //           ),
                      //           child: Text('Yes'),
                      //           onPressed: () async {
                      //           // user.email='';
                      //            // value='';
                      //             UserPreferences.userSignedIn = false;
                      //             TopVariable.switchScreenAndRemoveAll(loginScreenPath);
                      //
                      //           }),
                      //
                      //     ],
                      //   ),
                      // );
                    });
                //TopVariable.switchScreenAndRemoveAll(loginScreenPath);
                /* ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening Editor ...')));*/
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  Warning()
  {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Are you sure you want to delete your Account ? ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(

                    children: [
                      const SizedBox(
                        width: 80,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          DeleteAccount(user);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,),
                        icon: const Icon(Icons.delete),
                        label: const Text("Yes"),
                      ),

                      const SizedBox(
                        width: 80,
                      ),

                      ElevatedButton.icon(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,),
                        icon: const Icon(Icons.close),
                        label: const Text("NO"),
                      ),


                    ],
                  )
                ],

              ),


            ),


          ),
        ), ),
    );
  }
  DeleteAccount(User user)
  {
    db.collection("users").doc(user.email).delete().then((value) {
      print('user deleted');
      TopVariable.switchScreenAndRemoveAll(signupScreenPath);
    }).onError((e, _) {});
  }
}
