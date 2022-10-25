import 'package:crop_fit/Theme/colors.dart';
import 'package:flutter/material.dart';
import '../../data models/user.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/shared_preferences.dart';



class InvestorProfile extends StatefulWidget {
   const InvestorProfile({Key? key}) : super(key: key);


  @override
  State<InvestorProfile> createState() => _InvestorProfileState();
}

class _InvestorProfileState extends State<InvestorProfile> {
  User user = UserPreferences.user;
  String? name;
 //User user = UserPreferences.user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Profile'),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
           // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image:DecorationImage(image: user.coverUrl!=null? NetworkImage(user.coverUrl??'') : AssetImage('assets/coverpic.png')
                  as ImageProvider,
                      fit:BoxFit.fill ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0,4),
                    child: ClipOval(
                      child: user.picUrl != null
                          ? Image.network(
                        user.picUrl ?? '',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        Assets.defaultpicture.path,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 45,horizontal: 30)),
              Center(
                child: Text(user.name.toString(),
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: Text(user.type,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
             Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              child:Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 24,
                    right: 24,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      emailTextField(),
                      Divider(indent: 10,
                        endIndent: 10,),
                      genderTextField(),
                      Divider(indent: 10,
                        endIndent: 10,),
                      dobField(),
                      Divider(indent: 10,
                        endIndent: 10,),
                      locationTextField(),
                      Divider(indent: 10,
                        endIndent: 10,),
                      aboutTextField(),
                      Divider(indent: 10,
                        endIndent: 10,),
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
  Widget emailTextField() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            'Email:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), Spacer(), Text(user.email)
        ],
      ),
    );
  }
  Widget aboutTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), Spacer(),
          Expanded(
            child:  Text(user.bio.toString(),textAlign: TextAlign.end,),
          ),
        ],
      ),
    );
  }

  Widget dobField() {
    return   Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            'Date of birth',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), Spacer(),
          Expanded(
            child:  Text(user.dob.toString(),textAlign: TextAlign.end,),
          ),
        ],
      ),
    );
  }

  Widget locationTextField() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            'Location',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), Spacer(),
          Expanded(
            child:  Text(user.loc.toString(),textAlign: TextAlign.end,),
          ),
        ],
      ),
    );
  }
  Widget genderTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            'Gender',
            style: TextStyle(fontWeight: FontWeight.bold),
          ), Spacer(), Text(user.gender.toString())
        ],
      ),
    );
  }
}


/*TextFormField(
      initialValue: user.bio,
      enabled: false,
      maxLines: 5,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        //border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: "About",
        labelStyle: TextStyle(color: Colors.green),
        //   hintText: "I am Ali Mehdi",
      ),
    );*/