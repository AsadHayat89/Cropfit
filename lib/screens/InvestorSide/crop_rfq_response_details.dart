import 'package:crop_fit/data%20models/crop_inquiry.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data models/crop_inquiry.dart';
import '../../data models/crop.dart';
import '../../data models/crop_inquiry_response.dart';
import '../../data models/rfq_response.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import '../../widgets/btn.dart';
import 'package:motion_toast/motion_toast.dart';

import '../onboarding_page.dart';
import 'crop_rfq.dart';


class RFQResponseDetailsScreen extends StatefulWidget {
  final RFQResponse cropRFQResponse;
  const RFQResponseDetailsScreen({Key? key, required this.cropRFQResponse}) : super(key: key);

  @override
  State<RFQResponseDetailsScreen> createState() => _RFQResponseDetailsScreenState();
}

class _RFQResponseDetailsScreenState extends State<RFQResponseDetailsScreen> {
  Crop crop = Crop();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Inquiry Response Details'),
        centerTitle: true,),
      body: ListView(
        children: [
          InquiryDetails(widget.cropRFQResponse,crop),
        ],
      ),
    );
  }
  Widget InquiryDetails(RFQResponse cropRFQResponse,Crop crop)
  {
    return Container(
      height: screenHeight! / 2.2,
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
                            'Accepted Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQResponse.acceptedStatus.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [

                          Text(
                            'Farmer Id:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ), Spacer(), Text(cropRFQResponse.farmerId)
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
                          ), Spacer(), Text(cropRFQResponse.rfqId)
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
                          ), Spacer(), Text(cropRFQResponse.cropId)
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
                        children: [Text('Crop Quantity:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Spacer(), Text(cropRFQResponse.cropQuantityLimit.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [Text('Crop Time:', style: TextStyle(fontWeight: FontWeight.bold)),
                          Spacer(), Text(cropRFQResponse.cropTimeLimit.toString()),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                )),
            Btn(onClicked: (){
              //TopVariable.switchScreen(cropQuestionnaireFormScreenPath);
            }, label: 'Accept'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red),
                ),
                minimumSize: Size(screenWidth!/1.6, 35),
              ),
              onPressed: () {
              },
              child: Text('Reject'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    db.collection(DbPaths.crops).doc(widget.cropRFQResponse.cropId).get().then((snapshot) {
      setState((){
        crop = Crop.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    });
    super.initState();
  }
}
