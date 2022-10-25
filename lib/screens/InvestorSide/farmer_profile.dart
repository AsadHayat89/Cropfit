import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import '../../data models/crop.dart';
import '../../data models/crop_inquiry.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import '../../widgets/crop_tile_smallsize.dart';
import '../onboarding_page.dart';
import 'package:motion_toast/motion_toast.dart';


class FarmerProfileScreen extends StatefulWidget {
  final User user;
  const FarmerProfileScreen({Key? key,required this.user}) : super(key: key);

  @override
  State<FarmerProfileScreen> createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen> {
  User user = UserPreferences.user;
  double rating =0;
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db.collection("crops").snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Profile'),),
      body: ListView(
        children: [
          FarmerProfile(widget.user),
        ],
      ),
    );
  }
  Widget FarmerProfile(User user)
  {
    Stream<QuerySnapshot> IDCropsStream = db.collection("crops").where('type', isEqualTo: 'Dairy').where('deal',isEqualTo:'For Investor').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> IFCropsStream = db.collection("crops").where('type', isEqualTo: 'Fruit').where('deal',isEqualTo:'For Investor').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> IOCropsStream = db.collection("crops").where('type', isEqualTo: 'Organic').where('deal',isEqualTo:'For Investor').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> IVCropsStream = db.collection("crops").where('type', isEqualTo: 'Vegetable').where('deal',isEqualTo:'For Investor').where('farmerId', isEqualTo: user.email).snapshots();

    Stream<QuerySnapshot> BDCropsStream = db.collection("crops").where('type', isEqualTo: 'Dairy').where('deal',isEqualTo:'For Buyer').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> BFCropsStream = db.collection("crops").where('type', isEqualTo: 'Fruit').where('deal',isEqualTo:'For Buyer').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> BOCropsStream = db.collection("crops").where('type', isEqualTo: 'Organic').where('deal',isEqualTo:'For Buyer').where('farmerId', isEqualTo: user.email).snapshots();
    Stream<QuerySnapshot> BVCropsStream = db.collection("crops").where('type', isEqualTo: 'Vegetable').where('deal',isEqualTo:'For Buyer').where('farmerId', isEqualTo: user.email).snapshots();
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Container(
          decoration: BoxDecoration(
            image:DecorationImage(image: user.coverUrl!=null? NetworkImage(user.coverUrl??'') : AssetImage('assets/coverpic.png')
            as ImageProvider,
                fit:BoxFit.fill ),
          ),
          child: Container(
            width: double.infinity,
            height: 200,
            child: Container(
              alignment: Alignment(0.0,4),
              child: ClipOval(
                child: user.picUrl != null
                    ? Image.network(
                  user.picUrl ?? '',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  Assets.defaultpicture.path,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 90)),
        Center(
          child: Text(user.name.toString(),
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Center(
          child: Text(user.type,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Rating: $rating',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              RatingBar.builder(minRating:1,
                itemBuilder:(context,_)=>Icon(Icons.star,color: Colors.amber,),
                onRatingUpdate: (rating)=>setState((){
                  this.rating=rating;

                }),
              ),
            ],),
        ),
        Divider(),
        ExpansionTile(
          trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
          leading: Icon(Icons.view_list,color: Colors.green,),
          title: Text('My Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black,),),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(), Text(user.email)
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(), Text(user.name.toString())
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(), Text(user.gender.toString())
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Date of birth',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(),
                  Expanded(
                    child:  Text(user.dob.toString(),textAlign: TextAlign.end,),
                  ),
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(),
                  Expanded(
                    child:  Text(user.loc.toString(),textAlign: TextAlign.end,),
                  ),
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), Spacer(),
                  Expanded(
                    child:  Text(user.bio.toString(),textAlign: TextAlign.end,),
                  ),
                ],
              ),
            ),
            Divider(indent: 40,
              endIndent: 40,),
          ],
        ),
        ExpansionTile(
          trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
          leading: Icon(Icons.business,color: Colors.green,),
          title: Text('My Deals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black,),),
          children: [
            ExpansionTile( trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
              leading: Image.asset('assets/investoricon.png',
                width: 30,
                color: Colors.green,),
              title: Text('For Investor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black,),),
              children: [
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/fruit.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Fruits', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: IFCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _cropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],


                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/vegetable.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Vegetables', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: IVCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _cropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/organic.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Organic', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream:IOCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _cropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/dairyproducts.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Dairy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: IDCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Dairy has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _cropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
              ],
            ),
            ExpansionTile( trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
              leading: Image.asset('assets/buyer.png',
                width: 30,
                color: Colors.green,),
              title: Text('For Buyer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black,),),
              children: [
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/fruit.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Fruits', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: BFCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _buyersCropBottomSheet(context, crop);

                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/vegetable.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Vegetables', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: BVCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _buyersCropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/organic.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Organic', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: BOCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Crops has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _buyersCropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
                ExpansionTile(trailing: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.amber,),
                  leading: Image.asset('assets/dairyproducts.png',
                    width: 30,
                    //  color: Colors.green,
                  ),
                  title: Text('Dairy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black,),),
                  children: [
                    StreamBuilder(
                        stream: BDCropsStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text('Crops could not be loaded'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return  Container(
                              alignment: Alignment.center,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Loading Crops'),
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
                                child:Text('No Dairy has been Registered'));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: snapshot.data!.docs.map((dataElement) {
                                Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                                return CropTileSmall(crop, (){
                                  _buyersCropBottomSheet(context, crop);
                                });
                              }).toList().cast(),
                            ),
                          );
                        }
                    ),
                  ],

                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
  void _cropBottomSheet(context, Crop crop) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: screenHeight! / 2.5,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Farm Location:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(user.loc.toString())
                              ],
                            ),
                          ),
                        ],
                      )),
                  Btn(onClicked: () {
                    CropInquiry cropInquiry = CropInquiry(cropId: crop.id??'', farmerId: crop.farmerId, investorId: UserPreferences.user.email);
                    db.collection(DbPaths.cropInquiries).add(cropInquiry.toJson()).then((snapShot) {
                      db.collection(DbPaths.cropInquiries).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                        MotionToast.success(
                          title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                          description:  Text("Inquiry made successfully!"),
                        ).show(context);
                        //  showToast('Inquiry made successfully!');
                      });
                    });
                    Navigator.of(context).pop();
                  }, label: 'Make Inquiry'
                  )
                ],
              ),
            ),
          );
        });
  }
  void _buyersCropBottomSheet(context, Crop crop) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: screenHeight! / 2.5,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  'Farm Location:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(user.loc.toString())
                              ],
                            ),
                          ),
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
