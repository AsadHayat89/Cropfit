import 'package:crop_fit/screens/InvestorSide/home.dart';
import 'package:crop_fit/screens/InvestorSide/investor_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';
import 'DetailCrops.dart';


class MyCropPage extends StatefulWidget {
  @override
  _MyCropPageState createState() => _MyCropPageState();
}

class _MyCropPageState extends State<MyCropPage> {
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = Crop_DATA;
    List<Widget> listItems = [];

    responseList.forEach((post) {
      listItems.add(Container(

          height: 170,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),

                    Text(
                      post["brand"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post["Investment"]}",
                      style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                    child:IconButton(
                      icon: Icon(Icons.expand_more),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Opening...')));
                        TopVariable.switchScreen(DetailCropsPath);
                      },
                       // onPressed: () => Navigator.of(context)
                          //  .push(MaterialPageRoute(builder: (_) => DetailCrops())),
                      iconSize: 40,
                    ),
                    ),

                  ],
                ),





                Image.asset(
                  "assets/${post["image"]}",
                  height: 50,

                )

              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: Container(
            padding: const EdgeInsets.all(5),
            child:InkWell(
            child: Image.asset(Assets.investor.path),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening...')));
              TopVariable.switchScreen(investorProfilePath);
            },
          ),),
          title: const Text(
            "Investments",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 3,
                wordSpacing: 20,
                shadows: [
                  Shadow(color: Colors.greenAccent, offset: Offset(2,1), blurRadius:10)
                ]
            ),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening Search ...')));

              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Opening...')));
                TopVariable.switchScreen(investordashboardPath);
              },


            ),
                      ],
        ),

        body: Container(
          color: Colors.white60,
          height: size.height,
          child: Column(

            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Text(
                    "Your Crops",
                    style: TextStyle(color: Colors.white
                        , fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(

                  child: ListView.builder(

                      controller: controller,
                      itemCount: itemsData.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      }
                      )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

