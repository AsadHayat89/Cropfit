
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import '../data models/user.dart';
import '../utilities/shared_preferences.dart';


class ChangedPassword extends StatefulWidget {
  const ChangedPassword ({Key? key}) : super(key: key);

  @override
  State<ChangedPassword > createState() => _ChangedPasswordState();
}

class _ChangedPasswordState extends State<ChangedPassword > {
  bool _obsecureText = true;
  bool _obsecureText2 = true;
  bool _obsecureText3 = true;
  TextEditingController passController = TextEditingController();
  TextEditingController currentController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  User user = UserPreferences.user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: Text("Changed Password"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              'Enter your new password !',
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: currentPass(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: passTextField(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: ConpassTextField(),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {

                                  if(user.password==currentController.value.text){
                                    print("confirm password");
                                    if(passController.value.text==conPassController.value.text){
                                      user.password=passController.value.text;
                                      //print("Changed password in password value");
                                      UpdatePassword(user);
                                      MotionToast.success(
                                        title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                        description:  Text("Your Password has been reset"),
                                      ).show(context);
                                    }
                                  }


                                });
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget currentPass() {
    return TextFormField(
      controller: currentController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: 'Current:',
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        //  prefixIcon: Icon(Icons.corporate_fare),
        hintText: 'Enter Your Current Password',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obsecureText3 = !_obsecureText3;
            });
          },
          child: Icon(_obsecureText3
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value != null && value.length < 6
          ? 'Enter more than 5 characters'
          : null,

      keyboardType: TextInputType.text,
      obscureText: _obsecureText3,
      onChanged: (value) {
        //user.password= value;
      },
    );
  }
  Widget passTextField() {
    return TextFormField(
      controller: passController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: 'Password:',
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        //  prefixIcon: Icon(Icons.corporate_fare),
        hintText: 'Enter Your Password',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obsecureText = !_obsecureText;
            });
          },
          child: Icon(_obsecureText
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value != null && value.length < 6
          ? 'Enter more than 5 characters'
          : null,

      keyboardType: TextInputType.text,
      obscureText: _obsecureText,
      onChanged: (value) {
        //user.password= value;
      },
    );
  }
  Widget ConpassTextField() {
    return TextFormField(
      controller: conPassController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: 'Confirm Password:',
        labelStyle: TextStyle(
          color: Colors.green,
        ),
        //  prefixIcon: Icon(Icons.corporate_fare),
        hintText: 'Enter Your Confirm Password',

        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obsecureText2 = !_obsecureText2;
            });
          },
          child: Icon(_obsecureText2
              ? Icons.visibility_off
              : Icons.visibility),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value != null && value.length < 6
          ? 'Enter more than 5 characters'
          : null,

      keyboardType: TextInputType.text,
      obscureText: _obsecureText2,
      onChanged: (value) {
        //user.password= value;
      },
    );
  }

  UpdatePassword(User user)
  {
    db.collection("users").doc(user.email).update(user.toJson()).then((userEntry) {
      UserPreferences.user = user;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password has been updated successfully!')));
    }).onError((e, _) {

    });
  }
}
