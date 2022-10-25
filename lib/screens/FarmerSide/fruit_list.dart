import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../data models/crop.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import '../../widgets/crop_tile.dart';

class FruitListScreen extends StatefulWidget {
  const FruitListScreen({Key? key}) : super(key: key);

  @override
  State<FruitListScreen> createState() => _FruitListScreenState();
}

class _FruitListScreenState extends State<FruitListScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db
        .collection("crops")
        .where('type', isEqualTo: 'Fruit')
        .where('farmerId', isEqualTo: UserPreferences.user.email)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Text('Catalog Screen'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'My Fruits Catalog',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          StreamBuilder(
              stream: cropsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Crops could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Loading Crops'),
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
                  return Center(child: Text('No Crops has been Registered'));
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.docs
                        .map((dataElement) {
                          Crop crop = Crop.fromJson(
                              dataElement.data()! as Map<String, dynamic>);
                          return CropTile(crop, () {
                            _cropShowMenu(context, crop);
                          });
                        })
                        .toList()
                        .cast(),
                  ),
                );
              }),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered Your Crops',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    TopVariable.switchScreen(CropRegistrationFormPath);
                  },
                  child: Lottie.network(
                    'https://assets5.lottiefiles.com/datafiles/5IanpdP2ZRSpvdr/data.json',
                    height: 40.0,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _cropShowMenu(context, Crop crop) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: AlertDialog(
              title: Text('Delete Crop'),
              content: Text('Are you sure you want to delete your Crop?'),
              actions: [
                Btn(
                  onClicked: () {
                    print("asdf");
                    Navigator.of(context).pop();
                  },

                  label: 'No',
                  size: Size(screenWidth! / 4.5, 35),
                ),
                SizedBox(width: 15),
                Btn(
                  onClicked: () {
                    print("asad");
                    db.collection("crops").doc(crop.id).delete().then((value) {
                      print('crop deleted');
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Crop deleted successfully!')));
                      /* MotionToast.success(
                      title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      description:  Text("Crop deleted successfully!"),
                    ).show(context);*/
                    });
                    Navigator.of(context).pop();
                  },
                  label: 'Yes',
                  size: Size(screenWidth! / 4.5, 35),
                ),
              ],
            ),
          );
        });
  }
}
