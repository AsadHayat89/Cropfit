import 'dart:typed_data';
import 'package:crop_fit/data%20models/user.dart';
import 'package:crop_fit/screens/onboarding_page.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import '../../data models/crop.dart';
import '../../gen/assets.gen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../utilities/top_level_variables.dart';

class CropRegisteration extends StatefulWidget {
  const CropRegisteration({Key? key}) : super(key: key);

  @override
  State<CropRegisteration> createState() => _CropRegisterationState();
}
class _CropRegisterationState extends State<CropRegisteration> {
  User user = UserPreferences.user;

  final formKey = GlobalKey<FormState>();
  Crop crop = Crop(farmerId: UserPreferences.user.email);

  String dropdownValue = "";
  String dropDownValue="";
  XFile? file;
  CroppedFile? cropFile;
  Uint8List? cropImage;

  dynamic pickImage(ImageSource source)async{
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        cropFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio3x2,
          ],
          uiSettings: [
            AndroidUiSettings(backgroundColor: Colors.green,
                initAspectRatio: CropAspectRatioPreset.original),
          ],
        );
        cropFile!.readAsBytes().then((value) => cropImage=value);
        file = XFile(cropFile!.path);
      }
      // file =pickedFile;
      setState(() {

      });
      Get.back();
    }catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Crops Registration'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
              Row(
                children: [
                  Lottie.asset('assets/formregistration.json',
                    height: 120.0,
                    repeat: true,
                    reverse: true,
                    animate: true,),
            Text(
              'Crops Registration \n            Form',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: nameTextField(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: priceTextField(),
              ),
              SizedBox(
                height: 10,
              ),
              quantityTextField(),
              SizedBox(
                height: 10,
              ),
              CropField(),
              SizedBox(
                height: 10,
              ),
              offerfor(),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Upload Crop Picture ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 5),
                        // borderRadius: const BorderRadius.all(
                        //   Radius.circular(100),
                        // ),
                      ),
                      child:  GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          imagePickerOption();
                        },
                        child: ClipRect(
                          child: file!= null
                              ? Image.file(
                            File(file!.path),
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            Assets.gallerypic.path,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          color: Colors.green,
                        ),
                        child: InkWell(
                          onTap: () {
                            imagePickerOption();
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    'Register',
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
                      setState(() {
                         Register(crop);
                      });
                    }
                  },
                ),),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),);
  }

  Widget nameTextField() {
    return TextFormField(
      //   controller: nameController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: "Crop Name",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Enter Crop Name",
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        crop.name = value;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Crop Name';
        }
        return null;
      },
    );
  }

  Widget priceTextField() {
    return TextFormField(
      // controller: priceController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: "Crop Price",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Enter Crop Price",
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        crop.price = int.parse(value);
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Crop Price';
        }
        return null;
      },
    );
  }

  Widget quantityTextField() {
    return TextFormField(
      // controller: priceController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        labelText: "Crop Quantity Unit",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Enter Crop Quantity Unit",
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        crop.quantity = value;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Crop Quantity Unit';
        }
        return null;
      },
    );
  }

  Widget CropField() {
    return DropdownButtonFormField(

      value: dropdownValue,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2.0)),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 15)),

      items: const [
        DropdownMenuItem<String>(
            child: Text(
                'Choose Crop Type', style: TextStyle(color: Color(0xff11b719))),
            value: ''),
        DropdownMenuItem<String>(
            child: Text('Fruit'), value: 'Fruit'),
        DropdownMenuItem<String>(
            child: Text('Vegetable'), value: 'Vegetable'),
        DropdownMenuItem<String>(
            child: Text('Organic'), value: 'Organic'),
        DropdownMenuItem<String>(
            child: Text('Dairy'), value: 'Dairy'),
      ],
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          crop.type = dropdownValue;
        });
      },
      validator: (value) {
        if (dropdownValue == '')
          return 'You must select crop type';
        return null;
      },
    );
  }

  Widget offerfor() {
    return DropdownButtonFormField(

      value: dropDownValue,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2.0)),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 15)),

      items: const [
        DropdownMenuItem<String>(
            child: Text(
                'Choose Deal Method', style: TextStyle(color: Color(0xff11b719))),
            value: ''),
        DropdownMenuItem<String>(
            child: Text('For Buyer'), value: 'For Buyer'),
        DropdownMenuItem<String>(
            child: Text('For Investor'), value: 'For Investor'),
      ],
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
          crop.deal = dropDownValue;
        });
      },
      validator: (value) {
        if (dropDownValue == '')
          return 'You must select deal method';
        return null;
      },
    );
  }


  File? pickedImage;

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Choose Crop Picture",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


Register(Crop crop)
  {
    print(crop.toJson());
    db.collection("crops").add(crop.toJson()).then((value) {
      print('crop created');
      String cropId = value.id;
      db.collection("crops").doc(cropId).update({"id":cropId}).then((value) {
        storage.child("crops").child("$cropId.jpg").putData(cropImage!).then((p0) {
          storage.child("crops").child("$cropId.jpg").getDownloadURL().then((value) {
            db.collection("crops").doc(cropId).update({"picUrl":value}).then((value) {
              TopVariable.switchScreen(farmerdashboardPath);
              MotionToast.success(
                title:  Text("Congratulation "+user.name.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
               description:  Text("Your crop has been registered"),
              ).show(context);

             /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your crop has been registered')));
              Navigator.of(context).pop();*/
            });
          });
        });
      });
    }).onError((e, _) {});
  }
}



