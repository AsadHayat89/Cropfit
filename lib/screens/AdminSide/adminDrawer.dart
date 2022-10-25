import 'dart:io';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data models/user.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';
import '../Button_tap_listener.dart';
import 'admin_dashboard.dart';

class AdminDrawerScreen extends StatelessWidget {
  User user = UserPreferences.user;
  AdminDrawerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final object = Provider.of<ButtonTapListenerClass>(context);
    return Drawer(
      /* backgroundColor: object.isClicked
          ?Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,*/
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.name.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,backgroundColor: Colors.green.shade900,decoration: TextDecoration.underline)),
            accountEmail: Text(user.email,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,backgroundColor: Colors.amber.shade600,decoration: TextDecoration.underline),),
            currentAccountPicture: ClipOval(
              child:InkWell(
                child: Image.asset(
                  Assets.admin.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/wallpaper.jpeg')
                  as ImageProvider,
                )),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Dashboard'),
              onTap: () async {
                TopVariable.switchScreen(adminDashboardPath);
              }),
          ListTile(
              leading: Icon(Icons.supervised_user_circle_outlined),
              title: Text('View Users'),
              onTap: () async {

              }),
          ListTile(
              leading: Icon(Icons.verified_user_outlined),
              title: Text('Verify Farmers'),
              onTap: () async {

              }),
          ListTile(
              leading: Icon(Icons.feed_outlined),
              title: Text('View Feedbacks'),
              onTap: () async {
                TopVariable.switchScreen(feedbackScreenPath);
              }),
          ListTile(
              leading: Icon(Icons.newspaper),
              title: Text('View Contracts'),
              onTap: () async {

              }),
          ListTile(
            leading: Icon(Icons.design_services),
            title: Text('About Us'),
            onTap: () async {
              TopVariable.switchScreen(aboutUsScreenPath);
            },
          ),
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
}