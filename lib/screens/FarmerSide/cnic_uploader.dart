import 'dart:io';
import 'dart:typed_data';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../gen/assets.gen.dart';
import '../../utilities/top_level_variables.dart';
import 'package:image_picker/image_picker.dart';
import '../../data models/user.dart';
import 'package:get/get.dart';
import '../../utilities/shared_preferences.dart';


class CnicUploaderScreen extends StatefulWidget {
  const  CnicUploaderScreen({Key? key}) : super(key: key);

  @override
  State< CnicUploaderScreen> createState() => _CnicUploaderScreenState();
}
class _CnicUploaderScreenState extends State< CnicUploaderScreen> {

  File? file;
  CroppedFile? cropFile;
  Uint8List? cropImage;
  User user = UserPreferences.user;
  final formKey = GlobalKey<FormState>();

  dynamic pickImage(ImageSource source) async {
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
        cropFile!.readAsBytes().then((value) => cropImage = value);
        setState(() {
          file = File(cropFile!.path);
        });
      }
      // file =pickedFile;
      setState(() {

      });
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Cnic Screen'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            }, child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20), child: TextFormField(
                initialValue: user.cnic,
                enabled: false,
                decoration: InputDecoration(suffixIcon: Icon(Icons.lock)),
              ),),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Upload Cnic Picture ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 5),
                        // borderRadius: const BorderRadius.all(
                        //   Radius.circular(100),
                        // ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          imagePickerOption();
                        },
                        child: ClipRect(
                          child: user.cnicUrl != null
                              ? Image.network(
                                  user.cnicUrl ?? '',
                                  width: 250,
                                  height: 170,
                                  fit: BoxFit.cover,
                                )
                              : file==null
                                ? Image.asset(
                                  Assets.defaultcnicpic.path,
                                  width: 250,
                                  height: 170,
                                  fit: BoxFit.cover,
                                )
                                : Image.file(
                                  width: 250,
                                  height: 170,
                                  file!,
                                  fit: BoxFit.cover,
                                )
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
                height: 20,
              ),
              ElevatedButton(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18.0),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      updateUser(user);
                    });
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],),
          ),
        ),
      ),
    );
  }


  updateUser(User user) {
      UserPreferences.user = user;
      storageCnicPics.child(UserPreferences.user.email).child('cnic.jpg').putData(cropImage!).then((p0) {
        storageCnicPics.child(UserPreferences.user.email).child('cnic.jpg').getDownloadURL().then((value) {
          user.cnicUrl = value;
              db.collection("users").doc(user.email).update({"cnicUrl": value}).then((value) {
                db.collection("users").doc(user.email).update(user.toJson()).then((value) {
                  UserPreferences.user = user;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('user updated!')));
              });
        });
      }).onError((e, _) {

    });
  }

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
                    "Upload Cnic Picture",
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
                      primary: Colors.green,),
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,),
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
                      primary: Colors.green,),
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


}