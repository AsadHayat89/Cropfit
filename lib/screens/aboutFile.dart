import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('About'),
      ),
      body: ListView(

        children: [
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(image:AssetImage('assets/coverpic.png')
              as ImageProvider,
                  fit:BoxFit.fill ),
            ),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(-0.1,7),
                child: ClipOval(
                  child: Image.asset(
                    Assets.logo.path,
                    width: 250,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 80,right: 20,left: 20,bottom: 20),
            child:Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        //color: Colors.purple,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade400,
                          border: Border.all(color: Colors.amber.shade400, width: 3),
                          borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(20.0),
                            topRight: const  Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        //padding: const EdgeInsets.only(bottom: 8),
                        child:RichText(text: TextSpan(text:'Sabeeka Zaidi\n',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: 'Flutter Developer',style: TextStyle(fontSize: 12),),
                          ],
                        ),

                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        //color: Colors.purple,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade400,
                          border: Border.all(color: Colors.amber.shade400, width: 3),
                          borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(20.0),
                            topRight: const  Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],

                        ),
                        // padding: const EdgeInsets.only(bottom: 8),
                        child:RichText(text: TextSpan(text:'Iqra Farooq\n',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: 'Backend Developer',style: TextStyle(fontSize: 12),),
                          ],
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10,left: 40,right: 40,bottom: 10),
            child:Column(
              children: [
                Center(
                  child: Text('About Us',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
                Text('CropFit is a mobile application platform that connects investors with smallholder farmers who are seeking funding for their farm operation. Such funding will help the farmer operate at full capacity hence increasing the level of food security in all over the world. Beside this some of the good farmers have the capability to ensure the availability of the stocks at their farms for the walk-in investor to purchase.'
                    '\n\nThis app is developed to provide investments to the farmers who need them and for the investors who are seeking for the good farmers. Therefore, the project is aimed at solving such problems by designing an Android/IOS app that will provide an online way to connect potential investors with smallholder farmers who are seeking funding for their farm operation, reduce the time taken to find a farmer, accessibility of number of farmers at a single platform, this may lead to improve the economy.',
                  softWrap: true,
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}