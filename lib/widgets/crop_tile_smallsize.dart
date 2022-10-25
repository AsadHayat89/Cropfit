import 'package:flutter/material.dart';

import '../data models/crop.dart';

Widget CropTileSmall(Crop crop, VoidCallback onClicked)
{
  return Padding(
    padding: EdgeInsets.all(8.0) ,
    child: InkWell(
      onTap: onClicked,
      child: Container(
          width: 250,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(crop.picUrl??''),
                  colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.9), BlendMode.modulate,),
                  fit: BoxFit.cover
              )
          ),
          child:Column(
            children: [
              Text(crop.id.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11,color: Colors.white),),
              Spacer(),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(crop.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                    Spacer(),
                    Text(crop.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white,),),
                  ],
                ),
              ),
            ],
          )
      ),
    ),
  );
}