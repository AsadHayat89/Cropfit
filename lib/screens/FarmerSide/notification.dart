import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:crop_fit/widgets/title_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data models/crop_inquiry.dart';
import '../../data models/rfq.dart';
import '../../utilities/constants.dart';
import 'crop_inquiries_details.dart';
import 'crop_rfqs_details.dart';

class FarmerNotificationScreen extends StatefulWidget {
  const FarmerNotificationScreen({Key? key}) : super(key: key);

  @override
  State<FarmerNotificationScreen> createState() => _FarmerNotificationScreenState();
}

class _FarmerNotificationScreenState extends State<FarmerNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> inquiryStream = db.collection("inquiry").snapshots();
    Stream<QuerySnapshot> rfqStream = db.collection("RFQ").snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         /* TitleBar(title: 'CROPS INQUIRIES',),
          Divider(),*/
          StreamBuilder(
              stream: inquiryStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Inquiry could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Loading Inquiry...'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('No Inquiry has been made'),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.docs
                        .map((dataElement) {
                      CropInquiry cropInquiry = CropInquiry.fromJson(dataElement
                          .data()! as Map<String, dynamic>);
                      return InquiryTile(cropInquiry);
                    })
                        .toList()
                        .cast(),
                  ),
                );
              }),
          StreamBuilder(
              stream: rfqStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('RFQ could not be loaded'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('Loading RFQ...'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('No RFQ has been made'),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: snapshot.data!.docs
                        .map((dataElement) {
                      RFQ cropRFQ = RFQ.fromJson(dataElement
                          .data()! as Map<String, dynamic>);
                      return RFQTile(cropRFQ);
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

  Widget InquiryTile(CropInquiry cropInquiry) {
    return  Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("CROP INQUIRY",style: TextStyle(fontWeight: FontWeight.bold),),
              ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:  ListTile(
              title:Text(cropInquiry.investorId,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle:Text(cropInquiry.id) ,
              trailing:ElevatedButton(onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropInquiriesDetailsScreen(cropInquiry: cropInquiry,),
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
  Widget RFQTile(RFQ cropRFQ) {
    return  Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text("CROP RFQ",style: TextStyle(fontWeight: FontWeight.bold),),
              ]),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:  ListTile(
              title:Text(cropRFQ.investorId,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle:Text(cropRFQ.id) ,
              trailing:ElevatedButton(onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropRFQSDetailsScreen(cropRFQ: cropRFQ,),
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

/*
Widget InquiryTile(CropInquiry cropInquiry) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 5, left: 16, right: 16),
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(cropInquiry.investorId,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Text(cropInquiry.id, style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.bold),),
          ],),
        // SizedBox(width: 150),
        ElevatedButton(onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CropInquiriesDetailsScreen(cropInquiry: cropInquiry,),
            ),
          );
          // TopVariable.switchScreen(cropInquiriesDetailsScreenPath);
        },
          child: Text(
            'show details', style: TextStyle(fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            primary: Colors.amber.shade400,),
        ),

      ],
    ),);
}*/
