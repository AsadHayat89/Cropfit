import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/screens/InvestorSide/vegetables.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:crop_fit/Theme/extention.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:lottie/lottie.dart';
import '../../Theme/colors.dart';
import '../../Theme/text_styles.dart';
import '../../Theme/theme.dart';
import '../../data models/user.dart';
import '../FarmerSide/ChatRoom.dart';
import '../FarmerSide/chat_list.dart';
import '../onboarding_page.dart';
import '../side-bar.dart';
import 'Search.dart';
import 'farmer_profile.dart';

class InvestorHome extends StatefulWidget {
  const InvestorHome({Key? key}) : super(key: key);

  @override
  State<InvestorHome> createState() => _InvestorHomeState();
}

class _InvestorHomeState extends State<InvestorHome> {
  User user = UserPreferences.user;
  int Fruits = 0;
  int Vegetables = 0;
  int Organic = 0;
  int Dairy = 0;
  List<String> fruitsList=[];
  List<String> vegetablesList=[];
  List<String> organicList=[];
  List<String> dairyList=[];
  List<String> alllist=[];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFarmers();
  }

  void getFarmers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('crops').get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];
      //print(a.);
      DocumentReference docRef = await _firestore.collection('crops').doc(a.id);
      docRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print('Document exists on the database'+ documentSnapshot['deal']);
          if (documentSnapshot['type'] == "Vegetable") {

            //vegetablesList.add(documentSnapshot['farmerId']);
            if(!vegetablesList.contains(documentSnapshot['farmerId'])){
              setState(() {
                Vegetables = Vegetables + 1;
              });
              vegetablesList.add(documentSnapshot['farmerId']);
              if(!alllist.contains(documentSnapshot['farmerId'])){
                alllist.add(documentSnapshot['farmerId']);
              }

            }
            print("Total vegetavles: " + Vegetables.toString());
          }
          else if (documentSnapshot['type'] == "Organic") {

            if(!organicList.contains(documentSnapshot['farmerId'])){
              setState(() {
                Organic = Organic + 1;
              });
              organicList.add(documentSnapshot['farmerId']);
              if(!alllist.contains(documentSnapshot['farmerId'])){
                alllist.add(documentSnapshot['farmerId']);
              }
            }
           // organicList.add(documentSnapshot['farmerId']);
            //print("Total vegetavles: "+Vegetables.toString());
          }
          else if (documentSnapshot['type'] == "Fruit") {

            if(!fruitsList.contains(documentSnapshot['farmerId'])){
              setState(() {
                Fruits = Fruits + 1;
              });
              fruitsList.add(documentSnapshot['farmerId']);
              if(!alllist.contains(documentSnapshot['farmerId'])){
                alllist.add(documentSnapshot['farmerId']);
              }
            }

            //print("Total vegetavles: "+Vegetables.toString());
          }
          else if (documentSnapshot['type'] == "Dairy") {

            if(!dairyList.contains(documentSnapshot['farmerId'])){
              setState(() {
                Dairy = Dairy + 1;
              });
              dairyList.add(documentSnapshot['farmerId']);
              if(!alllist.contains(documentSnapshot['farmerId'])){
                alllist.add(documentSnapshot['farmerId']);
              }
            }
            //dairyList.add(documentSnapshot['farmerId']);
            //print("Total vegetavles: "+Vegetables.toString());
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db.collection("crops").snapshots();
    // Stream<QuerySnapshot> userStream = db.collection("users").snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Text(
          'Welcome To CropFit ...!',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          /* IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: Icon(Icons.search)),*/
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () async {
              //getFarmers();
              //print("Total vegetavles: "+Vegetables.toString());
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => HomeScreen()));
            },
          ),
          // Navigate to the Search Screen
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              TopVariable.switchScreen(cropInquiriesResponsesScreenPath);
            },
          )
        ],
        actionsIconTheme: IconThemeData(
          size: 30,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          header().p(8),
          searchField(),
          category(),
          farmerlist(),
        ],
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(user.name ?? 'Guest User', style: TextStyles.h1Style),
      ],
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
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
            width: 50,
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening Notification ...')));
              },
              child: Icon(Icons.search),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
                // overlayColor: MaterialStateProperty.all(Colors.grey.shade100)
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Categories", style: TextStyles.title.bold).p(8),
              IconButton(
                  onPressed: () {
                    TopVariable.switchScreen(storeScreenPath);
                  },
                  icon: Icon(
                    Icons.local_grocery_store,
                    color: Colors.orange.shade400,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .27,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                child: categoryCard(
                    "Vegetables", "${Vegetables} + Farmers", 'assets/veges.png',
                    color: LightColor.greenshade500,
                    lightColor: LightColor.greenshade300),
                onTap: () {
                  FocusScope.of(context).unfocus();
                  //TopVariable.switchScreen(vegetablesCardScreenPath);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:vegetablesList)));

                },
              ),
              GestureDetector(
                child: categoryCard(
                    "Organic", "${Organic} + Farmers", 'assets/organics.png',
                    color: LightColor.ambershade300,
                    lightColor: LightColor.ambershade100),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:organicList)));
                },
              ),
              GestureDetector(
                child: categoryCard(
                    "Fruits", "${Fruits} + Farmers", 'assets/fruitss.png',
                    color: LightColor.redshade500,
                    lightColor: LightColor.redshade300),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:fruitsList)));
                },
              ),
              GestureDetector(
                child: categoryCard(
                    "Dairy", "${Dairy} + Farmers", 'assets/dairy.png',
                    color: LightColor.skygreen,
                    lightColor: LightColor.lightskygreen),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:dairyList)));
                },
              ),
              GestureDetector(
                child: categoryCard(
                    "All",
                    "${alllist.length} + Farmers",
                    'assets/all.png',
                    color: LightColor.greenshade900,
                    lightColor: LightColor.greenshade400),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => VegetablesCardScreen(dataList:alllist)));
                },
              ),
            ],
          ),
        ),
      ],
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

  Widget farmerlist() {
    Stream<QuerySnapshot> userStream =
        db.collection("users").where('type', isEqualTo: 'Farmer').snapshots();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Top Farmers", style: TextStyles.title.bold).p(12),
          ],
        ),
        StreamBuilder(
            stream: userStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Users could not be loaded'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Loading Users'),
                      Lottie.asset(
                        'assets/loading.json',
                        height: 40.0,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No Users Registered'));
              }
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: snapshot.data!.docs
                      .map((dataElement) {
                        User user = User.fromJson(
                            dataElement.data()! as Map<String, dynamic>);
                        return FarmerTile(user);
                      })
                      .toList()
                      .cast(),
                ),
              );
            }),
      ],
    );
  }

  Widget FarmerTile(User user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FarmerProfileScreen(
              user: user,
            ),
          ),
        );
        //TopVariable.switchScreen(farmerProfileScreenPath);
      },
      child: Container(
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
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                child: ClipOval(
                  child: user.picUrl != null
                      ? Image.network(
                          user.picUrl ?? '',
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          Assets.defaultpicture.path,
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                ), /*Image.asset(
                Assets.farmer.path,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),*/
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
            ),
          ),
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
