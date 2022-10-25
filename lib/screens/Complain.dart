import 'package:crop_fit/screens/side-bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Complain extends StatelessWidget {
  const Complain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Colors.green,
         /* actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],*/
          title: Text('Contact'),
        ),
        body: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            children: [
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 5,
                  wordSpacing: 3,
                ),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                enabled: false,
                textAlign: TextAlign.center,
                initialValue: 'We Are Always Here To Solve Your Queries',
              ),
              SizedBox(height: 20),
              Lottie.asset('assets/24hrs.json',
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,),
              /*Lottie.network(
                'https://assets8.lottiefiles.com/packages/lf20_b3r66wwt.json',
                height: 200.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),*/
              SizedBox(
                height: 50,
              ),

              ElevatedButton.icon(
                icon: Lottie.asset('assets/phonecall.json'),
                label: Text("Call"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  fixedSize: Size(200, 60),
                  textStyle: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),
                  primary: Colors.green,
                  onPrimary: Colors.black87,
                  elevation: 15,
                  shadowColor: Colors.green,
                  side: BorderSide(color: Colors.white54,width: 2),
                  //alignment: Alignment.bottomLeft,
                  shape:StadiumBorder(),


                ),
                onPressed: () {

                  launch('tel: +92 3009133193');
                },
              ),
              SizedBox(width: 30,height:40),

              ElevatedButton.icon(
                icon: Lottie.asset('assets/sendmail.json'),
                label: Text("Send Mail"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  fixedSize: Size(60, 60),
                  textStyle: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),
                  primary: Colors.white,
                  onPrimary: Colors.black87,
                  elevation: 15,
                  shadowColor: Colors.green,
                  side: BorderSide(color: Colors.white54,width: 2),
                  //alignment: Alignment.bottomLeft,
                  shape:StadiumBorder(),


                ),
                onPressed: () {

                  launch('mailto:iqraf908@gmai.com?subject=Complain or Give feedback about CropFit&body=Hi CroFit I want to tell you about');

                },
              ),
              SizedBox(width: 30,height:40),

              ElevatedButton.icon(
                icon: Lottie.asset('assets/chat.json'),
                label: Text("Send Message"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10.0),
                  fixedSize: Size(200, 60),
                  textStyle: TextStyle(fontSize: 25,fontWeight:FontWeight.bold),
                  primary: Colors.amber,
                  onPrimary: Colors.black87,
                  elevation: 15,
                  shadowColor: Colors.green,
                  side: BorderSide(color: Colors.white54,width: 2),
                  //alignment: Alignment.bottomLeft,
                  shape:StadiumBorder(),


                ),
                onPressed: () {
                  launch('sms: +92 3009133193');

                },
              ),
              SizedBox(width: 30,height:40),

            ],
          ),
        ));
  }
}