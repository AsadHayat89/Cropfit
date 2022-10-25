import 'package:crop_fit/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../../data models/crop_inquiry_response.dart';
import '../../data models/rfq.dart';
import '../../data models/user.dart';
import '../../utilities/db_paths.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';
import 'package:motion_toast/motion_toast.dart';

import '../onboarding_page.dart';


class CropRFQScreen extends StatefulWidget {
  final CropInquiryResponse cropInquiryResponse;
  const CropRFQScreen({Key? key, required this.cropInquiryResponse}) : super(key: key);

  @override
  State<CropRFQScreen> createState() => _CropRFQScreenState();
}

class _CropRFQScreenState extends State<CropRFQScreen> {
  User user = UserPreferences.user;
  RFQ rfq = RFQ(investorId: UserPreferences.user.email);
  final formKey = GlobalKey<FormState>();

  String radioValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
              child:_quesThreeWidget(),),
              _quesFourWidget(),

                submit(widget.cropInquiryResponse),

                Padding(padding: EdgeInsets.only(top: 10,bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text('CropFit',style: TextStyle(color: Colors.grey.shade600,fontSize: 20,fontWeight: FontWeight.w900),),
                    SizedBox(width: 3,),
                    Text('Forms',style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w900),),
                  ]
                ),
                ),



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
                "Crop RFQ",
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
              Text('Enter the required quantity of a crop.',
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
              Text('Enter the time required for the delivery of the crop.',
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
  _quesThreeWidget() {
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
              Text('Would you like to prefer our transport services?',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(padding:EdgeInsets.symmetric(vertical: 10),
                child:_ansThreeRadioButtonWidget(),),
            ],
          ),
        ),
      ],
    );
  }
  _quesFourWidget() {
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
              Text('If Yes, then where to deliver the required crop? If No, then mention your preference or a way for the delivery of crop.',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Padding(padding:EdgeInsets.symmetric(vertical: 10),
                child:_ansFourTextField(),),
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
      initialValue: rfq.cropRequiredQuantity,
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
         rfq.cropRequiredQuantity= value;
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
      initialValue: rfq.cropRequiredTime,
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
        rfq.cropRequiredTime= value;
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
  _ansThreeRadioButtonWidget()
  {
    return Column(
      children: [
        Row(
          children: [
            Radio(
                activeColor: Colors.green,
                value:'Yes',
                groupValue: radioValue,
                onChanged: (value) {
                  radioValue = value as String;
                  setState(() {
                    radioValue = value;
                    rfq.needTransportService=radioValue;
                  });
                }),
            Text(
              'Yes',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              activeColor: Colors.green,
                value:'No',
                groupValue: radioValue,
                onChanged: (value) {
                  radioValue = value as String;
                  setState(() {
                    radioValue = value;
                    rfq.needTransportService=radioValue;
                  });
                }),
            Text(
              'No',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
  Widget _ansFourTextField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.grey,
      initialValue: rfq.mentionPreference,
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
        rfq.mentionPreference= value;
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

  Widget submit(CropInquiryResponse cropInquiryResponse)
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
                RFQ cropRFQ = RFQ(inquiryresponseId:cropInquiryResponse.id,inquiryId: cropInquiryResponse.inquiryId,cropId: cropInquiryResponse.cropId, farmerId: cropInquiryResponse.farmerId, investorId: UserPreferences.user.email,cropRequiredQuantity: rfq.cropRequiredQuantity,cropRequiredTime: rfq.cropRequiredTime,needTransportService: rfq.needTransportService,mentionPreference: rfq.mentionPreference);
                db.collection(DbPaths.rfq).add(cropRFQ.toJson()).then((snapShot) {
                  db.collection(DbPaths.rfq).doc(snapShot.id).update({"id":snapShot.id}).then((value) {
                    TopVariable.switchScreen(investorSubmissionSplashScreenPath);
                    MotionToast.success(
                      title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                      description:  Text("Quotation sent successfully!"),
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

