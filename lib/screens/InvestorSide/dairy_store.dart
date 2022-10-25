import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/Theme/extention.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../../Theme/colors.dart';
import '../../Theme/text_styles.dart';
import '../../Theme/theme.dart';
import '../../data models/crop.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import '../../widgets/crop_grid.dart';
import '../onboarding_page.dart';


class DairyStoreScreen extends StatefulWidget {
  const DairyStoreScreen({Key? key}) : super(key: key);

  @override
  State<DairyStoreScreen> createState() => _DairyStoreScreenState();
}

class _DairyStoreScreenState extends State<DairyStoreScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db.collection("crops").where('type', isEqualTo: 'Dairy').where('deal',isEqualTo:'For Buyer').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Store'),
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        children: [
          searchField(),
          category(),
          StreamBuilder(
              stream: cropsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Crops could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Loading Crops...'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('No Crops has been Registered'),
                  );
                }
                return GridView(
                  physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2),
                  children: snapshot.data!.docs
                      .map((dataElement) {
                    Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                    return CropGrid(crop, () {
                      _buyersCropBottomSheet(context, crop);
                    });
                  })
                      .toList()
                      .cast(),
                );
              }),
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
          hintText: "Search",
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
            ),
          ),
        ),
      ),
    );
  }

  Widget category() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: AppTheme.fullHeight(context) * .18,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              GestureDetector(
                child:
                categoryCard("All",'assets/all.png',
                    color:LightColor.greenshade900, lightColor:LightColor.greenshade400),
                onTap: (){
                  TopVariable.switchScreen(storeScreenPath);
                },
              ),
              GestureDetector(
                child:categoryCard("Veggies",'assets/veges.png',
                    color: LightColor.greenshade500, lightColor: LightColor.greenshade300),
                onTap: (){
                  FocusScope.of(context).unfocus();
                  TopVariable.switchScreen(veggiesStoreScreenPath);
                },
              ),
              GestureDetector(
                child:  categoryCard("Organic",'assets/organics.png',
                    color: LightColor.ambershade300, lightColor: LightColor.ambershade100),
                onTap: (){
                  TopVariable.switchScreen(organicStoreScreenPath);
                },
              ),
              GestureDetector(
                child: categoryCard("Fruits",'assets/fruitss.png',
                    color: LightColor.redshade500, lightColor: LightColor.redshade300),
                onTap: (){
                  TopVariable.switchScreen(fruitStoreScreenPath);
                },
              ),

              GestureDetector(
                child: categoryCard("Dairy",'assets/dairy.png',
                    color: LightColor.skygreen, lightColor: LightColor.lightskygreen),
                onTap: (){
                  TopVariable.switchScreen(dairyStoreScreenPath);
                },
              ),

            ],
          ),
        ),
      ],
    );
  }

  Widget categoryCard(String title,String imagePath,
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
                    radius: 45,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(title,style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,fontSize: 16),),
                    SizedBox(height: 10),
                  ],
                ).p16
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _buyersCropBottomSheet(context, Crop crop) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: screenHeight! / 3,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [Text('Crop:', style: TextStyle(fontWeight: FontWeight.bold)), Spacer(), Text(crop.name)],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Price:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(crop.price.toString() + " PKR/" +crop.quantity)
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Crop Id:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(crop.id??'')
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Crop Type:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(crop.type??'')
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Farmer:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(crop.farmerId)
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      )),
                  Btn(onClicked: () {
                    /*CropInquiry cropInquiry = CropInquiry(cropId: crop.id??'', farmerId: crop.farmerId, investorId: UserPreferences.user.email);
                    db.collection(DbPaths.cropInquiries).add(cropInquiry.toJson()).then((snapShot) {
                      db.collection(DbPaths.cropInquiries).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                        MotionToast.success(
                          title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          description:  Text("Inquiry made successfully!"),
                        ).show(context);
                        //  showToast('Inquiry made successfully!');
                      });
                    });
                    Navigator.of(context).pop();*/
                  }, label: 'Add to Cart'
                  )
                ],
              ),
            ),
          );
        });
  }
}
