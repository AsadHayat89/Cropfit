import 'package:crop_fit/screens/InvestorSide/verical-croplist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../utilities/constants.dart';
import '../../utilities/top_level_variables.dart';

class DetailCrops extends StatefulWidget {
  const DetailCrops({Key? key}) : super(key: key);

  @override
  State<DetailCrops> createState() => _DetailCropsState();
}

class _DetailCropsState extends State<DetailCrops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        ),
        title: const Text(
          "Details",
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
              icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening...')));
              TopVariable.switchScreen(MyCropPagePath);
            },
             // onPressed: () => Navigator.of(context)
                //  .push(MaterialPageRoute(builder: (_) => MyCropPage()))

          ),
        ],
      ),
      body:Center(
       child:ListView(
        children: [
          SizedBox(height: 70,),

          Image.asset(
       Assets.watch.path,
         // width: 7,
       height: 150,
       ),
          SizedBox(height: 20,),
          const Text(

            'Delivery Time : 22-12-2022.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),

          ),
          SizedBox(height: 70,),
          Image.asset(
            Assets.live.path,
            // width: 7,
            height: 100,
          ),
          SizedBox(height: 10,),
          TextButton(

            style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () { },
            child: Text('Live streaming',
              style: TextStyle(fontWeight: FontWeight.bold),
             ),
          ) ],

      )
    ),);
  }
}
