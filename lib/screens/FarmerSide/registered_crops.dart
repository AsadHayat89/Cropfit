import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/data%20models/crop.dart';
import 'package:flutter/material.dart';

import '../../utilities/top_level_variables.dart';
import '../../widgets/crop_tile.dart';

class RegisteredCrops extends StatefulWidget {
  const RegisteredCrops({Key? key}) : super(key: key);

  @override
  State<RegisteredCrops> createState() => _RegisteredCropsState();
}

class _RegisteredCropsState extends State<RegisteredCrops> {

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> cropsStream = db.collection("crops").snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Registered Crops'),
      ),
      body: Column(
          children: [
            SizedBox(height: 30,),
            Center(child: Text('My Crops',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
            SizedBox(height: 30,),
            StreamBuilder(
                stream: cropsStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text('Crops could not be loaded'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text('Loading Crops...'),
                    );
                  }
                  if(snapshot.data!.docs.isEmpty){
                    return Text('No Crops Registered');
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data!.docs.map((dataElement) {
                        Crop crop = Crop.fromJson(dataElement.data()! as Map<String, dynamic>);
                        return CropTile(crop, (){});
                      }).toList().cast(),
                    ),
                  );
                }
            )
          ],
        ),
    );
  }

}

  /*Widget Crop2()
  {
    return   Padding(
      padding:const EdgeInsets.all(8.0) ,
      child: InkWell(
        onTap: (){},
        child: Container(
            width: 250,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Colors.white),
            child:Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('#002',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),),
                Positioned(
                  left: 5,
                  right: 5,
                  top: 5,
                  bottom: 15,
                  child: Image.asset(
                    Assets.sugarcane.path,
                    height: 170,
                    width: 170,
                  ),),
                Positioned(
                  top: 225,
                  left:100,
                  child: Text('Sugarcane',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),
                Positioned(
                  top: 250,
                  left:100,
                  child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),
              ],
            )
        ),
      ),);
  }

  Widget Crop3()
  {
    return  Padding(
      padding:const EdgeInsets.all(8.0) ,
      child: InkWell(
        onTap: (){},
        child: Container(
            width: 250,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Colors.white),
            child:Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('#003',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),),
                Positioned(
                  left: 5,
                  right: 5,
                  top: 5,
                  bottom: 15,
                  child: Image.asset(
                    Assets.apple.path,
                    height: 170,
                    width: 170,
                  ),),
                Positioned(
                  top: 225,
                  left:100,
                  child: Text('Apple',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),
                Positioned(
                  top: 250,
                  left:100,
                  child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),


              ],
            )
        ),
      ),);
  }

  Widget Crop4()
  {
    return  Padding(
      padding:const EdgeInsets.all(8.0) ,
      child: InkWell(
        onTap: (){},
        child: Container(
            width: 250,
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(20),color: Colors.white),
            child:Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('#004',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),),
                Positioned(
                  left: 5,
                  right: 5,
                  top: 5,
                  bottom: 15,
                  child: Image.asset(
                    Assets.carrot.path,
                    height: 170,
                    width: 170,
                  ),),
                Positioned(
                  top: 225,
                  left:100,
                  child: Text('Carrot',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),
                Positioned(
                  top: 250,
                  left:100,
                  child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),

                ),


              ],
            )
        ),
      ),);
  }*/

