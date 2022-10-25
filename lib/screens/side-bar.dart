import 'dart:io';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data models/user.dart';
import '../utilities/constants.dart';
import '../utilities/top_level_variables.dart';
import 'Complain.dart';
import 'onboarding_page.dart';

final Uri _url = Uri.parse(
    'https://drive.google.com/file/d/18m23kcGwD65hkzm_ZPlz0mYyYGyBmTxx/view?usp=sharing');

class NavBar extends StatelessWidget {
  User user = UserPreferences.user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name.toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
            accountEmail: Wrap(
              children: [
                GestureDetector(
                  child: Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () async {
                    launch(
                        'mailto:iqraf908@gmai.com?subject=Complain or Give feedback about CropFit&body=Hi CroFit I want to tell you about');
                  },
                ),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              child: InkWell(
                child: ClipOval(
                  child: Image.asset(
                    'assets/investor.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Opening...')));
                  TopVariable.switchScreen(investorProfilePath);
                },
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/sidebarbg.png'),
                )),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('My Investments'),
            onTap: () async {
              TopVariable.switchScreen(MyCropPagePath);
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text('Complain'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Complain())),
          ),
          Divider(),
          ListTile(
            title: Text('Policy'),
            leading: Icon(Icons.policy),
            onTap: () async {
              _launchUrl();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: AlertDialog(
                        title: Text('Do you want to exit the app?'),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: Text('No',
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () async {
                                Navigator.pop(context);
                              }),
                          SizedBox(width: 15),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red.shade800,
                              ),
                              child: Text('Yes'),
                              onPressed: () async {
                                exit(0);
                              }),
                        ],
                      ),
                    );
                  });
            },
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
}
