import 'package:crop_fit/data%20models/crop_inquiry.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/printState.dart';
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
import 'dart:io';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../onboarding_page.dart';
import 'crop_rfq.dart';


class CropInquiryResponsesDetailsScreen extends StatefulWidget {
  final CropInquiryResponse cropInquiryResponse;
  const CropInquiryResponsesDetailsScreen({Key? key, required this.cropInquiryResponse}) : super(key: key);

  @override
  State<CropInquiryResponsesDetailsScreen> createState() => _CropInquiryResponsesDetailsScreenState();
}

class _CropInquiryResponsesDetailsScreenState extends State<CropInquiryResponsesDetailsScreen> {

  Crop crop = Crop();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Inquiry Response Details'),
        centerTitle: true,),
      body: Padding(
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
                          ), Spacer(), Text(widget.cropInquiryResponse.acceptedStatus.toString()),
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
                          ), Spacer(), Text(widget.cropInquiryResponse.farmerId)
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
                          ), Spacer(), Text(widget.cropInquiryResponse.inquiryId)
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
                  ],
                )),
           Btn(onClicked: (){
             Navigator.push(
               context,
               MaterialPageRoute(
                 builder: (context) => CropRFQScreen(cropInquiryResponse: widget.cropInquiryResponse,),
               ),
             );
             //TopVariable.switchScreen(cropQuestionnaireFormScreenPath);
           }, label: 'RFQ'),
            Btn(onClicked: (){
              printContract();
              // TopVariable.switchScreen(contractPrintScreenPath);
            }, label: 'Print Contract'),
          ],
        ),
      ),
    );
  }

  printContract() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => PrintState.page1,
      ),
    );
    //final file = File('contract.pdf');
    //await file.writeAsBytes(await pdf.save());
    await Printing.layoutPdf(onLayout: (_) => pdf.save());
  }


  @override
  void initState() {
    db.collection(DbPaths.crops).doc(widget.cropInquiryResponse.cropId).get().then((snapshot) {
      setState((){
        crop = Crop.fromJson(snapshot.data() as Map<String, dynamic>);
      });
    });
    super.initState();
  }
}
