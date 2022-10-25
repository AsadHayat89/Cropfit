import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:crop_fit/widgets/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data models/crop_inquiry.dart';
import '../../data models/crop_inquiry_response.dart';
import '../../data models/rfq_response.dart';
import '../../utilities/constants.dart';
import 'crop_inquiry_responses_details.dart';
import 'crop_rfq_response_details.dart';

class CropInquiriesResponsesScreen extends StatefulWidget {
  const CropInquiriesResponsesScreen({Key? key}) : super(key: key);

  @override
  State<CropInquiriesResponsesScreen> createState() => _CropInquiriesResponsesScreenState();
}

class _CropInquiriesResponsesScreenState extends State<CropInquiriesResponsesScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> inquiryresponseStream = db.collection("inquiryresponse").snapshots();
    Stream<QuerySnapshot> rfqresponseStream = db.collection("RFQresponse").snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
       /*   TitleBar(title: 'CROPS INQUIRY RESPONSES',),
          Divider(),*/
          StreamBuilder(
              stream: inquiryresponseStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Inquiry response could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Loading Inquiry Response...'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('No Inquiry Response has been made'),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.docs
                        .map((dataElement) {
                      CropInquiryResponse cropInquiryResponse = CropInquiryResponse.fromJson(dataElement
                          .data()! as Map<String, dynamic>);
                      return InquiryResponseTile(cropInquiryResponse);
                    })
                        .toList()
                        .cast(),
                  ),
                );
              }),
          StreamBuilder(
              stream: rfqresponseStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('RFQ response could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Loading RFQ response...'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('No RFQ response has been made'),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.docs
                        .map((dataElement) {
                      RFQResponse cropRFQResponse = RFQResponse.fromJson(dataElement
                          .data()! as Map<String, dynamic>);
                      return RFQResponseTile(cropRFQResponse);
                    })
                        .toList()
                        .cast(),
                  ),
                );
              }),
        ],
      ),
    );
  }
  Widget InquiryResponseTile( CropInquiryResponse cropInquiryResponse) {
    return  Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('CROP INQUIRY RESPONSE',style: TextStyle(fontWeight: FontWeight.bold),),
              ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:  ListTile(
              title:Text(cropInquiryResponse.farmerId,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle:Text(cropInquiryResponse.id) ,
              trailing:ElevatedButton(onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CropInquiryResponsesDetailsScreen(cropInquiryResponse: cropInquiryResponse,),
                  ),
                );
                // TopVariable.switchScreen(cropInquiriesDetailsScreenPath);
              },
                child: Text(
                  'show details', style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber.shade400,),
              ),
            ),
          ),
          Divider(),
        ],
      );
  }
  Widget RFQResponseTile( RFQResponse cropRFQResponse) {
    return  Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('RFQ RESPONSE',style: TextStyle(fontWeight: FontWeight.bold),),
              ]),
         Container(
           padding: EdgeInsets.symmetric(horizontal: 10),
           child:  ListTile(
             title:Text(cropRFQResponse.farmerId,style: TextStyle(fontWeight: FontWeight.bold),),
             subtitle:Text(cropRFQResponse.id) ,
             trailing:ElevatedButton(onPressed: () async {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => RFQResponseDetailsScreen(cropRFQResponse: cropRFQResponse,),
                 ),
               );
               // TopVariable.switchScreen(cropInquiriesDetailsScreenPath);
             },
               child: Text(
                 'show details', style: TextStyle(fontWeight: FontWeight.bold),),
               style: ElevatedButton.styleFrom(
                 primary: Colors.amber.shade400,),
             ),
           ),
         ),
          Divider(),

        ],
      );
  }
}

/* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(cropRFQResponse.farmerId,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(cropRFQResponse.id, style: TextStyle(
                      color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
                ],
              ),
              ElevatedButton(onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RFQResponseDetailsScreen(cropRFQResponse: cropRFQResponse,),
                  ),
                );
                // TopVariable.switchScreen(cropInquiriesDetailsScreenPath);
              },
                child: Text(
                  'show details', style: TextStyle(fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber.shade400,),
              ),
            ],),*/