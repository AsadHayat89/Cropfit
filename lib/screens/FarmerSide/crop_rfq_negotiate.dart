import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../../data models/crop_inquiry_response.dart';
import '../../data models/rfq.dart';
import '../../data models/rfq_response.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import 'package:motion_toast/motion_toast.dart';

import '../onboarding_page.dart';


class CropRFQNegotiateScreen extends StatefulWidget {
  final RFQ cropRFQ;
  const CropRFQNegotiateScreen({Key? key, required this.cropRFQ}) : super(key: key);

  @override
  State<CropRFQNegotiateScreen> createState() => _CropRFQNegotiateScreenState();
}

class _CropRFQNegotiateScreenState extends State<CropRFQNegotiateScreen> {
  User user = UserPreferences.user;
  RFQResponse rfqResponse = RFQResponse(farmerId: UserPreferences.user.email);
  final formKey = GlobalKey<FormState>();

  String radioValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('CropFit',style: TextStyle(color: Colors.grey.shade600,fontSize: 20,fontWeight: FontWeight.w900),),
              SizedBox(width: 3,),
              Text('Forms',style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w900),),
            ]
        ),
      ],
      //backgroundColor: Colors.green,
      backgroundColor: const Color.fromARGB(255, 16, 30, 2),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child:Form(
          key: formKey,
          child:  ListView(
              padding: EdgeInsets.only(left: 20,right: 20,top: 40),
              children: [
                _headingWidget(),
                Padding(padding: EdgeInsets.symmetric(vertical: 10),
                  child:_quesOneWidget(),),
                _quesTwoWidget(),
                submit(widget.cropRFQ),

              ]),
        ),
      ),
    );
  }
  _headingWidget()
  {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey Farmer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Please fill the form",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5,),
              Divider(
                indent: 1,
                endIndent: 1,
                color: Colors.green,
              ),
            ],
          ) ,
        ),
      ],
    );
  }

  _quesOneWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('Enter the quantity limit of a crop.',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(padding:EdgeInsets.symmetric(vertical: 10),
                child:_ansOneTextField(),),
            ],
          ),
        ),
      ],
    );
  }
  _quesTwoWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('Enter the time limit required for the delivery of the crop.',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(padding:EdgeInsets.symmetric(vertical: 10),
                child:_ansTwoTextField(),),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ansOneTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.grey,
      initialValue: rfqResponse.cropQuantityLimit,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide:BorderSide(color: Colors.green),
        ),
        contentPadding: EdgeInsets.only(left: 15),
        //labelText: "Name",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Your answer",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        rfqResponse.cropQuantityLimit= value;
        value = '';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This is a required question';
        }
        return null;
      },
    );
  }
  Widget _ansTwoTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.grey,
      initialValue: rfqResponse.cropTimeLimit,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide:BorderSide(color: Colors.green),
        ),
        contentPadding: EdgeInsets.only(left: 15),
        //labelText: "Name",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Your answer",
        hintStyle: TextStyle(color: Colors.grey),
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        rfqResponse.cropTimeLimit= value;
        value = '';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This is a required question';
        }
        return null;
      },
    );
  }

  Widget submit(RFQ cropRFQ)
  {
    return  Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.symmetric( vertical: 10),
        child: ElevatedButton(
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.green.shade700),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.white70),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              setState(() {
                RFQResponse cropRFQResponse = RFQResponse(rfqId:cropRFQ.id,inquiryresponseId:cropRFQ.inquiryresponseId,inquiryId: cropRFQ.inquiryId,cropId: cropRFQ.cropId, farmerId:UserPreferences.user.email, investorId: cropRFQ.investorId,cropQuantityLimit:rfqResponse.cropQuantityLimit,cropTimeLimit: rfqResponse.cropTimeLimit,acceptedStatus: 'wait');
                db.collection(DbPaths.rfqResponse).add(cropRFQResponse.toJson()).then((snapShot) {
                  db.collection(DbPaths.rfqResponse).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                    TopVariable.switchScreen(farmerSubmissionSplashScreenPath);
                    MotionToast.success(
                      title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      description:  Text("Respond successfully!"),
                    ).show(context);
                    //  showToast('Inquiry made successfully!');
                  });
                });
              });
            }
          },
        ),
      ),
    );
  }

}

