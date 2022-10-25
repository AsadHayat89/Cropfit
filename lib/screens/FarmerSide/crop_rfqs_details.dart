import 'package:crop_fit/Theme/colors.dart';
import 'package:crop_fit/data%20models/rfq.dart';
import 'package:crop_fit/data%20models/rfq_response.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import '../onboarding_page.dart';
import 'package:motion_toast/motion_toast.dart';

import 'crop_rfq_negotiate.dart';



class CropRFQSDetailsScreen extends StatefulWidget {

  final RFQ cropRFQ;
  const CropRFQSDetailsScreen({Key? key, required this.cropRFQ}) : super(key: key);

  @override
  State<CropRFQSDetailsScreen> createState() => _CropRFQSDetailsScreenState();
}

class _CropRFQSDetailsScreenState extends State<CropRFQSDetailsScreen> {
  User user = UserPreferences.user;
  RFQ rfq = RFQ(farmerId: UserPreferences.user.email);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('RFQ Details'),
        centerTitle: true,),
      body: ListView(
        children: [
          RFQDetails(widget.cropRFQ),
        ],
      ),
    );
  }
  Widget RFQDetails(RFQ cropRFQ)
  {
    return Container(
      height: screenHeight! / 1,
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
                          ), Spacer(), Text(cropRFQ.investorId)
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'RFQ Id:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQ.id)
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
                          ), Spacer(), Text(cropRFQ.cropId.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [Text('Required Quantity Of Crop:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Spacer(), Text(cropRFQ.cropRequiredQuantity.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Required Time for Crop:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQ.cropRequiredTime.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Need Company Transport Facility:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQ.needTransportService.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Delivery Of Crop:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQ.mentionPreference.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Btn(onClicked: () {
                      RFQResponse cropRFQResponse = RFQResponse(rfqId:cropRFQ.id,inquiryresponseId:cropRFQ.inquiryresponseId,inquiryId: cropRFQ.inquiryId,cropId: cropRFQ.cropId, farmerId:UserPreferences.user.email, investorId: cropRFQ.investorId,acceptedStatus: 'true',cropQuantityLimit: cropRFQ.cropRequiredQuantity,cropTimeLimit: cropRFQ.cropRequiredTime);
                      db.collection(DbPaths.rfqResponse).add(cropRFQResponse.toJson()).then((snapShot) {
                        db.collection(DbPaths.rfqResponse).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                          TopVariable.switchScreen(farmerdashboardPath);
                          MotionToast.success(
                            title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                            description:  Text("Quotation accepted successfully!"),
                          ).show(context);
                          //  showToast('Inquiry made successfully!');
                        });
                      });
                    }, label: 'Accept',
                      size: Size(screenWidth!/1.5, 35),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber.shade400,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.amber.shade400),
                        ),
                        minimumSize: Size(screenWidth!/1.5, 35),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CropRFQNegotiateScreen(cropRFQ: cropRFQ,),
                          ),
                        );
                      },
                      child: Text('Negotiate'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        minimumSize: Size(screenWidth!/1.5, 35),
                      ),
                      onPressed: () {
                        RFQResponse cropRFQResponse = RFQResponse(rfqId:cropRFQ.id,inquiryresponseId:cropRFQ.inquiryresponseId,inquiryId: cropRFQ.inquiryId,cropId: cropRFQ.cropId, farmerId:UserPreferences.user.email, investorId: cropRFQ.investorId,acceptedStatus: 'false',cropQuantityLimit: cropRFQ.cropRequiredQuantity,cropTimeLimit: cropRFQ.cropRequiredTime);
                        db.collection(DbPaths.rfqResponse).add(cropRFQResponse.toJson()).then((snapShot) {
                          db.collection(DbPaths.rfqResponse).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                            TopVariable.switchScreen(farmerdashboardPath);
                            MotionToast.error(
                              title:  Text("Quotation",style: TextStyle(fontWeight: FontWeight.bold),),
                              description:  Text("Rejected successfully!"),
                            ).show(context);
                            //  showToast('Inquiry made successfully!');
                          });
                        });
                      },
                      child: Text('Reject'),
                    ),
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
