import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../../data models/user.dart';
import '../../utilities/shared_preferences.dart';
import '../../utilities/top_level_variables.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  double rating =0;
  String radioValue = "";
  User user = UserPreferences.user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Give Feedback'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical:30 ),
          children: [
            Row(
              children: [
                Lottie.asset('assets/feedback.json',
                  height: 120.0,
                  repeat: true,
                  reverse: true,
                  animate: true,),
                Text(
                  'Valuable Feedback \n             Form',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text('1. Rate this app',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RatingBar.builder(minRating:1,
                    itemBuilder:(context,_)=>Icon(Icons.star,color: Colors.amber,),
                    onRatingUpdate: (rating)=>setState((){
                      this.rating=rating;
                      user.appRating=rating;
                    }),
                  ),
                ],),
            ),
            SizedBox(height: 10,),
            Text('2. Are you Statisfied with our app?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            _ansTwoRadioButtonWidget(),
            SizedBox(height: 10,),
            Text('3. Tell us your valuable feedback to improve the app.',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child:TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Enter your valuable feedback here',
                  filled: true,
                ),
                maxLines: 5,
                maxLength: 4096,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  user.valuableFeedback = value;
                  value = '';
                },
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child:isLoading
                  ? const Center(child: CircularProgressIndicator())
                  :  ElevatedButton(
                child: Text(
                  'Send Feedback',
                  style: TextStyle(fontSize: 18.0),
                ),

                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                          //  side: BorderSide(color: color??appTheme.primaryColor)
                        )
                    )
                ),
                // style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await updateUser(user);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),),
          ],
        ),
      ),
    );
  }

  updateUser(User user) {
    setState(() {
      isLoading = true;
    });
    db.collection("users").doc(user.email).update(user.toJson()).then((value) async {
      UserPreferences.user = user;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback Send Successfully')));
    }).onError((e, _) {});
  }

  _ansTwoRadioButtonWidget()
  {
    return Column(
      children: [
        Row(
          children: [
            Radio(
                activeColor: Colors.green,
                value:'Yes',
                groupValue: radioValue,
                onChanged: (value) {
                  radioValue = value as String;
                  setState(() {
                    radioValue = value;
                    user.appSatisfaction=radioValue;
                    //rfq.needTransportService=radioValue;
                  });
                }),
            Text(
              'Yes',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Row(
          children: [
            Radio(
                activeColor: Colors.green,
                value:'No',
                groupValue: radioValue,
                onChanged: (value) {
                  radioValue = value as String;
                  setState(() {
                    radioValue = value;
                    user.appSatisfaction=radioValue;
                    //rfq.needTransportService=radioValue;
                  });
                }),
            Text(
              'No',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}