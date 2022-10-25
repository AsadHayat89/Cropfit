import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/Theme/extention.dart';
import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/screens/AdminSide/ListCardData.dart';
import 'package:crop_fit/screens/splash_screen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../Theme/colors.dart';
import '../../Theme/text_styles.dart';
import '../../Theme/theme.dart';
import '../../data models/admin.dart';
import '../../utilities/shared_preferences.dart';
import '../FarmerSide/chat_list.dart';
import '../FarmerSide/drawer.dart';
import 'adminDrawer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  User user = UserPreferences.user;
  int Vegetables=0;
  int farmers=0;
  int investors=0;
  int crops=0;
  int inquires=0;

  List<String> investorsList=[];
  List<String> CropsList=[];
  List<String> FarmersList=[];
  List<String> alllist=[];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarmers();
    print(farmers);
  }

  void getFarmers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      print(a.id);
      DocumentReference docRef = await _firestore.collection('users').doc(a.id);
      docRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print('Document exists on the database'+ documentSnapshot['deal']);
          if(documentSnapshot['type'] == "Investor"){
            setState((){
              investors=investors+1;
              if(!investorsList.contains(documentSnapshot['type'])){
                investorsList.add(a.id);
              }
            });


          }
          else if(documentSnapshot['type'] == "Farmer"){
            setState((){
              farmers=farmers+1;
              if(!FarmersList.contains(documentSnapshot['type'])){
                FarmersList.add(a.id);
              }
            });

          }

      }});
    }


    QuerySnapshot querySnapshot1 = await _firestore.collection('crops').get();
    for (int i = 0; i < querySnapshot1.docs.length; i++) {
      var a = querySnapshot1.docs[i];
      //print(a.);
      DocumentReference docRef = await _firestore.collection('crops').doc(a.id);
      docRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print('Document exists on the database'+ documentSnapshot['deal']);
          setState((){
            crops=crops+1;
          });

          CropsList.add(a.id);
        }});
    }

    QuerySnapshot querySnapshot2 = await _firestore.collection('inquiryresponse').get();
    for (int i = 0; i < querySnapshot2.docs.length; i++) {
      var a = querySnapshot2.docs[i];
      //print(a.);
      DocumentReference docRef = await _firestore.collection('inquiryresponse').doc(a.id);
      docRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print('Document exists on the database'+ documentSnapshot['deal']);
          setState((){
            inquires=inquires+1;
          });
          alllist.add(a.id);
        }});
    }
  }
  @override
  Widget build(BuildContext context) {
    String farmerName = user.name ?? 'Guest Farmer';
    return Scaffold(
      drawer: AdminDrawerScreen(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Row(
          children: [
            Text(
              'Hello..!\n$farmerName',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            /* Text(
            'Hello ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),Text(user.name.toString()+' ..!',style: TextStyle(fontWeight: FontWeight.bold),),*/
          ],
        ), //const Text('Hello Farmer..!'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('Opening Chat ...')));
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              TopVariable.switchScreen(farmerNotificationScreenPath);
              /* ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening Notification ...')));*/
            },
          )
        ],
        actionsIconTheme: IconThemeData(
          size: 30,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Hello,", style: TextStyles.title.subTitleColor),
                Text(user.name ?? 'Guest User', style: TextStyles.h1Style),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,bottom: 20),
            child: Center(child: Text("Dashboard",style: TextStyles.h1Style)),
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 10.0,
                children: [
                  GestureDetector(
                    child: categoryCard(
                        "Farmers", "${farmers} + Farmers", 'assets/farm1.PNG',
                        color: LightColor.greenshade500,
                        lightColor: LightColor.greenshade300),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      //TopVariable.switchScreen(vegetablesCardScreenPath);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCardScreen(dataList:FarmersList,type: 'farmer',)));

                    },
                  ),
                  GestureDetector(
                    child: categoryCard(
                        "Crops", "${crops} + Crops", 'assets/veges.png',
                        color: LightColor.greenshade500,
                        lightColor: LightColor.greenshade300),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCardScreen(dataList:CropsList,type: 'crop',)));
                      //TopVariable.switchScreen(vegetablesCardScreenPath);
                      //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:vegetablesList)));

                    },
                  ),
                  GestureDetector(
                    child: categoryCard(
                        "Investors", "${investors} + Investors", 'assets/investor.png',
                        color: LightColor.greenshade500,
                        lightColor: LightColor.greenshade300),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      print(investorsList.length.toString());
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCardScreen(dataList:investorsList,type: 'investor',)));
                      //TopVariable.switchScreen(vegetablesCardScreenPath);
                      //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:vegetablesList)));

                    },
                  ),
                  GestureDetector(
                    child: categoryCard(
                        "Deals", "${inquires} + Contracts", 'assets/policy.png',
                        color: LightColor.greenshade500,
                        lightColor: LightColor.greenshade300),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListCardScreen(dataList:alllist,type: 'deal',)));
                      //TopVariable.switchScreen(vegetablesCardScreenPath);
                      //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:vegetablesList)));

                    },
                  ),
                ]),
          ),
        ],
      ),
    );
  }
  Widget categoryCard(String title, String subtitle, String imagePath,
      {required Color color, required Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle),
                    ),
                    SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ),
      ),
    );
  }
}
