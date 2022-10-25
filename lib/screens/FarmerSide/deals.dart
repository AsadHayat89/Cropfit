import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import '../Button_tap_listener.dart';

class FamDeals extends StatefulWidget {
  const FamDeals({Key? key}) : super(key: key);

  @override
  State<FamDeals> createState() => _FamDealsState();
}

class _FamDealsState extends State<FamDeals> {
  @override
  Widget build(BuildContext context) {
    //final object = Provider.of<ButtonTapListenerClass>(context);
    return Scaffold(
      /*   backgroundColor: object.isClicked
          ?Theme.of(context).primaryColorLight
          : Theme.of(context).primaryColorDark,*/
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Deals'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'My Deals',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Inquiry(),
                PurchaseOrder(),

              ],

            ),
          ),
        ],
      ),
    );
  }

  Widget Inquiry() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image:NetworkImage('https://t3.ftcdn.net/jpg/03/57/63/70/240_F_357637094_lhrPz4rTlrM23eLDLhvIcfhsM1YUTpM4.jpg'),
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.9), BlendMode.modulate,),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    '#001',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'INQUIRY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.green),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.green),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(width: 2, color: Colors.green),
                            ))),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 55,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'WHEAT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.amberAccent),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.amberAccent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(width: 2, color: Colors.amberAccent),
                            ))),
                  ),
                ),

                Positioned(
                  top: 140,
                  left: 5,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'JOHN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.transparent),
                            ))),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget PurchaseOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image:NetworkImage('https://t3.ftcdn.net/jpg/05/07/56/70/240_F_507567082_wvkSGR4N3ZIFQICkjptGUPVEg4USFrH2.jpg'),
                    colorFilter: ColorFilter.mode(
                      Colors.white10.withOpacity(1), BlendMode.modulate,),
                    fit: BoxFit.cover
                )
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    '#002',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 5,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'PURCHASE ORDER',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.green),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.green),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(width: 2, color: Colors.green),
                            ))),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 35,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'SUGARCANE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.amberAccent),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.amberAccent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(width: 2, color: Colors.amberAccent),
                            ))),
                  ),
                ),

                Positioned(
                  top: 140,
                  left: 5,
                  child: TextButton(
                    onPressed: () async {},
                    child: Center(
                      child: Text(
                        'JACK',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(width: 2, color: Colors.transparent),
                            ))),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}