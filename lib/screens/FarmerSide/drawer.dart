import 'dart:io';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data models/user.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';
import '../Button_tap_listener.dart';
import '../aboutFile.dart';

class FameNavBar extends StatelessWidget {
  User user = UserPreferences.user;
  FameNavBar({Key? key}) : super(key: key);
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
                child: user.picUrl != null
                    ? Image.network(
                  user.picUrl ?? '',
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  Assets.defaultpicture.path,
                  fit: BoxFit.cover,
                ),
                //child:Image.asset(Assets.defaultpicture.path),
                onTap: () {
                  TopVariable.switchScreen(farmerProfilePath);
                },
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:user.coverUrl!=null? NetworkImage(user.coverUrl??'') : AssetImage('assets/coverphoto.png')
    as ImageProvider,
                )),
          ),
          ListTile(
              leading: Icon(Icons.business_center),
              title: Text('My Deals'),
              onTap: () async {
                TopVariable.switchScreen(FamDealsPath);
              }),
          ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text('Complain'),
              onTap: () async {
                TopVariable.switchScreen(ComplainPath);
              }),
          ListTile(
              leading: Icon(Icons.feed_outlined),
              title: Text('Give Feedback'),
              onTap: () async {
                TopVariable.switchScreen(feedbackScreenPath);
              }),
          ListTile(
              leading: Icon(Icons.perm_device_information),
              title: Text('About US'),
              onTap: () async {
                //TopVariable.switchScreen(aboutUsScreenPath); AboutUsScreen
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutUsScreen()));
              }),
         /* ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              onTap: () async {
                TopVariable.switchScreen(farmerPhoneNumberScreenPath);
              }),*/

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
