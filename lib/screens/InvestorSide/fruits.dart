import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/Theme/extention.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Theme/colors.dart';
import '../../Theme/text_styles.dart';
import '../../data models/user.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';
import 'farmer_profile.dart';


class FruitsCardScreen extends StatefulWidget {
  const FruitsCardScreen({Key? key}) : super(key: key);

  @override
  State<FruitsCardScreen> createState() => _FruitsCardScreenState();
}

class _FruitsCardScreenState extends State<FruitsCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Text('Fruits'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          searchField(),
          farmerlist(),

        ],
      ),
    );
  }
  Widget searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        //cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search by Name",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening Notification ...')));
                },
                child: Icon(Icons.search),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder (
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  )),
                  // overlayColor: MaterialStateProperty.all(Colors.grey.shade100)
                ),
              ),),
        ),
      ),
    );
  }
  Widget farmerlist(){
    Stream<QuerySnapshot> userStream = db.collection("users").where('type', isEqualTo: 'Farmer').snapshots();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Farmers", style: TextStyles.title.bold).p(12),
           /* TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening Notification ...')));
              },
              child: Icon(Icons.sort),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder (
                  borderRadius:BorderRadius.all(Radius.circular(10)),
                )),
                // overlayColor: MaterialStateProperty.all(Colors.grey.shade100)
              ),
            ).p(12),*/
          ],
        ).hP16,
        StreamBuilder(
            stream: userStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Users could not be loaded'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  Container(
                  alignment: Alignment.center,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Loading Users'),
                      Lottie.asset('assets/loading.json',
                        height: 40.0,
                        repeat: true,
                        reverse: true,
                        animate: true,),
                    ],
                  ),

                );
              }
              if(snapshot.data!.docs.isEmpty){
                return Center(
                    child:Text('No Users Registered'));
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: snapshot.data!.docs.map((dataElement) {
                    User user = User.fromJson(dataElement.data()! as Map<String, dynamic>);
                    return FarmerTile(user);
                  }).toList().cast(),
                ),
              );
            }
        ),
      ],
    );
  }
  Widget FarmerTile(User user) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerProfileScreen(user: user,),
          ),
        );
        //TopVariable.switchScreen(farmerProfileScreenPath);
      },
      child:Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                Assets.farmer.path,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(user.name.toString(), style: TextStyles.title.bold),
          subtitle: Text(
            user.type,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),),
      ),
    ),
    );
  }
  Color randomColor() {
    var random = Random();
    final colorList = [
      LightColor.lightskygreen,
      LightColor.greenshade400,
      LightColor.subTitleTextColor,
      LightColor.titleTextColor,
      LightColor.ambershade300,
      LightColor.greenshade900,
      LightColor.ambershade400,
      LightColor.darkgreen,
      LightColor.redshade500,
      LightColor.darkgreenshade,
      LightColor.purpleLight,
      LightColor.ambershade100,
      LightColor.black,
      LightColor.skygreen,
      LightColor.grey,
      LightColor.lightblack,
      LightColor.greenshade300,
      LightColor.lightBlue,
      LightColor.purple,
      LightColor.ambershade300,
      LightColor.greenshade500,
      LightColor.redshade300,
      LightColor.purpleExtraLight,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }
}
