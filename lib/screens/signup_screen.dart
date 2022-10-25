import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/gen/assets.gen.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/top_level_variables.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../utilities/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool _obsecureText = true;
  bool _obsecureText2 = true;
  final formKey = GlobalKey<FormState>();

  var cnicMask = MaskTextInputFormatter(
      mask: '#####-#######-#', filter: {"#": RegExp(r'[0-9]')});
  User user = User(
      email: 'email',
      contact: 'contact',
      password: 'password',
      cnic: 'cnic',
      type: 'type',
    ChatIds: []
  );


  String dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(25, 137, 8, 1),
          title: const Text('Signup Screen'),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            children: [
              Image.asset(
                Assets.logo.path,
                // width: 7,
                height: 300,
                fit: BoxFit.cover,
              ),
          TextFormField(
            initialValue:'',
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green, width: 2.0),
              ),
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(left: 15),
              labelText: "Name",
             labelStyle: TextStyle(color: Colors.green),
              hintText: "Enter Your Name",
            ),
            keyboardType: TextInputType.text,
            onChanged: (value) {
              user.name = value;
              value = '';
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Name';
              }
              return null;
            },
          ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: '',
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'Email:',
                  labelStyle: TextStyle(color: Colors.green),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: 'Enter Your Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  user.email = value;
                  value ='';
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter more than 5 characters'
                    : null,
                initialValue: '',
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
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
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'Password:',
                  labelStyle: TextStyle(color: Colors.green),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: 'Enter Your Password',
                ),
                keyboardType: TextInputType.text,
                obscureText: _obsecureText,
                onChanged: (value) {
                  user.password = value;
                  value = '';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: '',
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
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
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'Confirm Password:',
                  labelStyle: TextStyle(color: Colors.green),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: 'Confirm Your Password',
                ),
                keyboardType: TextInputType.text,
                obscureText: _obsecureText2,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Confirm password is required please enter';
                  }
                  if (value != user.password) {
                    return 'Confirm password is not matching';
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                inputFormatters: [cnicMask],
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'CNIC is required';
                  }
                  if (value!.isNotEmpty) {
                    bool cnicValid = RegExp(r'^[0-9]').hasMatch(value);
                    return cnicValid ? null : "Invalid mobile";
                  }
                },
                //  onSaved: (value) => _username = value!,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.green, width: 2.0),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 15),
                  labelText: 'CNIC',
                  labelStyle: TextStyle(color: Colors.green),
                  //  prefixIcon: Icon(Icons.corporate_fare),
                  hintText: '11111-1111111-1',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  user.cnic = value;
                  value = '';
                },
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                value: dropdownValue,
                decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.green, width: 2.0)),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 15)),

                items: const [
                  DropdownMenuItem<String>(
                      child: Text('Choose User Type',style: TextStyle(color: Colors.green),), value: ''),
                  DropdownMenuItem<String>(
                      child: Text('Farmer',style: TextStyle(color: Colors.black)), value: 'Farmer'),
                  DropdownMenuItem<String>(
                      child: Text('Investor',style: TextStyle(color: Colors.black)), value: 'Investor'),

                ],
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                    user.type=dropdownValue as String;
                  });
                },
                validator: (value) {
                  if (dropdownValue == '')
                    return 'You must select user type';
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              isLoading
                ? Center(child: const CircularProgressIndicator())
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('    SIGNUP    '),
                onPressed: () async {
                  singUp(user);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account? "),
                    TextButton(
                        onPressed: () => {
                          TopVariable.switchScreen(loginScreenPath),
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.green),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  singUp(User user) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });
    db.collection("users").doc(user.email).get().then((userEntry) {
      //Text(user.name??'');
      if (userEntry.exists) {
        setState(() {
          isLoading = false;
        });
        // print('user already exists');
        MotionToast.warning(
            title: Text(
              "User already exists",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            description: Text("Please enter a new email"))
            .show(context);
      }
      else {
        db
            .collection('PersonChatIds')
            .doc(user.email)
            .set({"person1": []});
        db.collection("users").doc(user.email).set(user.toJson()).then((value) {
          print('user created');
          UserPreferences.user = user;
          UserPreferences.userSignedIn = true;
          setState(() {
            isLoading = false;
          });
          TopVariable.switchScreenAndRemoveAll(PageOnBorardingPath);
         // user.type == 'Farmer'
           //   ? TopVariable.switchScreenAndRemoveAll(farmerdashboardPath)
             // : TopVariable.switchScreenAndRemoveAll(investordashboardPath);
        }).onError((e, _) {});
      }
    });
  }
}



