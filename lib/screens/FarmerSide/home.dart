import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/screens/FarmerSide/drawer.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:crop_fit/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:lottie/lottie.dart';

import '../../data models/crop.dart';
import 'chat_list.dart';


class FarmerHome extends StatefulWidget {
  const FarmerHome({Key? key}) : super(key: key);

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  User user = UserPreferences.user;
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db.collection("crops").snapshots();
    String farmerName = user.name ?? 'Guest Farmer';
    return Scaffold(
      drawer:FameNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Row( children: [
        Text(
        'Hello..!\n$farmerName',
        style: TextStyle(fontWeight: FontWeight.bold),),
         /* Text(
            'Hello ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),Text(user.name.toString()+' ..!',style: TextStyle(fontWeight: FontWeight.bold),),*/
        ],),//const Text('Hello Farmer..!'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
      body:ListView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        children: [
          //Lottie.asset('assets/twinklingstars.json'),
          Center(child:
      Image.asset(
      Assets.myfarmword.path,
       height: 150,
      ),),
          //Text('My Farm',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
          GridView(
            padding: EdgeInsets.only(top: 50),
            physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10
            ),
            children: [
              InkWell(
                onTap: (){
                  TopVariable.switchScreen(vegetablesScreenPath);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber.shade400,
                    image: DecorationImage(
                        image:  AssetImage('assets/veges.png'),
                        colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.9), BlendMode.modulate,),
                        fit: BoxFit.cover
                    ) ,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // Icon(Icons.home,size: 50,color: Colors.white,),
                      Text("Vegetables",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 25),)
                    ],),
                ),
              ),
              InkWell(
                onTap: (){
                  TopVariable.switchScreen(fruitsScreenPath);
                },
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber.shade300,
                  image: DecorationImage(
                      image:  AssetImage('assets/fruitss.png'),
                      colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.9), BlendMode.modulate,),
                      fit: BoxFit.cover
                  ) ,
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // Icon(Icons.search,size: 50,color: Colors.white,),
                      Text("Fruits",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 25),),
                    ],),
                ),
              ),
              InkWell(
                onTap: (){
                  TopVariable.switchScreen(organicScreenPath);
                },
                child: Container(decoration:  BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber.shade300,
                  image: DecorationImage(
                      image:  AssetImage('assets/organics.png'),
                      colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.9), BlendMode.modulate,),
                      fit: BoxFit.cover
                  ) ,

                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    //  Icon(Icons.settings,size: 50,color: Colors.white,),
                      Text("Organic",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 25),),
                    ],),
                ),
              ),
              InkWell(
                onTap: (){
                  TopVariable.switchScreen(dairyScreenPath);

                },
                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.amber.shade400,
                  image: DecorationImage(
                      image:  AssetImage('assets/dairy.png'),
                      colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.9), BlendMode.modulate,),
                      fit: BoxFit.cover
                  ) ,
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // Icon(Icons.book,size: 50,color: Colors.white,),
                      Text("Dairy",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 25),),
                    ],),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

