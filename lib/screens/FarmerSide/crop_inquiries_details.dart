import 'package:crop_fit/data%20models/crop_inquiry.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/screens/FarmerSide/farmer_dashboard.dart';
import 'package:crop_fit/screens/FarmerSide/home.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data models/crop_inquiry.dart';
import '../../data models/crop.dart';
import '../../data models/crop_inquiry_response.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import 'package:motion_toast/motion_toast.dart';

import '../onboarding_page.dart';


class CropInquiriesDetailsScreen extends StatefulWidget {
  final CropInquiry cropInquiry;
  const CropInquiriesDetailsScreen({Key? key, required this.cropInquiry}) : super(key: key);

  @override
  State<CropInquiriesDetailsScreen> createState() => _CropInquiriesDetailsScreenState();
}

class _CropInquiriesDetailsScreenState extends State<CropInquiriesDetailsScreen> {
  User user = UserPreferences.user;

  Crop crop = Crop();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Inquiry Details'),
        centerTitle: true,),
      body: ListView(
        children: [
          InquiryDetails(widget.cropInquiry,crop),
        ],
      ),
    );
  }
  Widget InquiryDetails(CropInquiry cropInquiry,Crop crop)
  {
   return Container(
      height: screenHeight! / 1.7,
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
                        children: [
                          Text(
                            'Investor Id:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropInquiry.investorId)
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Inquiry Id:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropInquiry.id)
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
                          ), Spacer(), Text(crop.id??'')
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [Text('Crop Name:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Spacer(), Text(crop.name),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Crop Price:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(crop.price.toString() + " PK R/ 40 Kg")
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
                          ), Spacer(), Text(crop.type??''),
                        ],
                      ),
                    ),
                    Divider(),
                    Btn(onClicked: () {
                      CropInquiryResponse cropInquiryResponse = CropInquiryResponse(inquiryId:cropInquiry.id,cropId: cropInquiry.cropId, farmerId: UserPreferences.user.email, investorId: cropInquiry.investorId);
                      db.collection(DbPaths.CropInquiryResponses).add(cropInquiryResponse.toJson()).then((snapShot) {
                        db.collection(DbPaths.CropInquiryResponses).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                          TopVariable.switchScreen(farmerdashboardPath);
                          MotionToast.success(
                            title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            description:  Text("Respond Inquiry successfully!"),
                          ).show(context);
                          //showToast('Responsed Inquiry successfully!');
                        });
                      });
                    }, label: 'Accept Inquiry and Proceed Negotiations',
                     // size: Size(screenWidth!/1.3, 35),
                    )
                  ],
                )),

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    db.collection(DbPaths.crops).doc(widget.cropInquiry.cropId).get().then((snapshot) {
      setState((){
        crop = Crop.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    });
    super.initState();
  }
}
