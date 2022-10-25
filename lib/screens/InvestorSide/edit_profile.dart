import 'dart:io';
import 'dart:typed_data';
import 'package:crop_fit/screens/FarmerSide/cnic_uploader.dart';
import 'package:crop_fit/utilities/constants.dart';
import 'package:crop_fit/utilities/shared_preferences.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:crop_fit/data%20models/user.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import '../../Location/location_service.dart';
import 'package:location/location.dart' as loc;
import '../../gen/assets.gen.dart';
import '../../utilities/top_level_variables.dart';
import 'package:image_picker/image_picker.dart';
import '../../data models/user.dart';
import 'package:get/get.dart';
import '../../utilities/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';


class InvestorEditProfile extends StatefulWidget {
  const InvestorEditProfile({Key? key}) : super(key: key);

  @override
  State<InvestorEditProfile> createState() => _InvestorEditProfileState();
}

class _InvestorEditProfileState extends State<InvestorEditProfile> {
  bool isLocationLoading = false;
  bool isLoading = false;
  //File? pickedImage;
  File? file;
  CroppedFile? cropFile;
  File? coverFile;
  CroppedFile? cropCoverFile;
  Uint8List? cropCoverImage;
  Uint8List? cropImage;
  User user = UserPreferences.user;
  final formKey = GlobalKey<FormState>();
  String dropdownValue = "";
  String? address;
  TextEditingController locationController  = TextEditingController();

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
            AndroidUiSettings(
                backgroundColor: Colors.green,
                initAspectRatio: CropAspectRatioPreset.original),
          ],
        );
        cropFile!.readAsBytes().then((value) => cropImage = value);
        file = File(cropFile!.path);
      }
      setState(() {});
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  dynamic pickCoverImage(ImageSource source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        cropCoverFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio3x2,
          ],
          uiSettings: [
            AndroidUiSettings(
                backgroundColor: Colors.green,
                initAspectRatio: CropAspectRatioPreset.original),
          ],
        );
        cropCoverFile!.readAsBytes().then((value) => cropCoverImage = value);
        setState(() {
          coverFile = File(cropCoverFile!.path);
        });
      }
      setState(() {});
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> locationService() async {
    loc.Location location = loc.Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if(_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if(_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      UserLocation.lat = _locData.latitude!;
      UserLocation.long = _locData.longitude!;
    });
    await getLocation();
  }

  String country = '';
  String locality = '';
  String street = '';
  String subLocality = '';

  Future<void> getLocation() async {
    List<Placemark> placemark = await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

    print(placemark[0].country);
    print(placemark[0].locality);
    print(placemark[0].street);
    print(placemark[0].subLocality);

    setState(() {
      country = placemark[0].country!;
      locality= placemark[0].locality!;
      street = placemark[0].street!;
      subLocality =  placemark[0].subLocality!;
    });

    setState(() {
      address = "$street "+"$subLocality "+ "$locality, "+ "$country";
      user.loc = address;
      // locationController.text = address!;
    });
  }

  /* file?.readAsBytes().then((pic) async{
        try {
          // Upload raw data.
          await storageProfilePics.child(UserPreferences.user.email).child('profile.jpg').putData(pic);
          await storageProfilePics.child(UserPreferences.user.email).child('profile.jpg').getDownloadURL().then((url) {
            setState((){ user.picUrl = url; });
          });
        } on FirebaseException catch (e) {
          print(e);
        }
      });
      // file =pickedFile;
        setState(() {

      });
      Get.back();
    }catch (error) {
      debugPrint(error.toString());
    }
  }*/
  @override
  Widget build(BuildContext context) {
    dropdownValue = user.gender??'';
    locationController = TextEditingController(text: user.loc??'');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: formKey,
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: <Widget>[
                Container(
                  //color: Colors.red,
                  height: 285,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            coverimagePickerOption();
                          },
                          child: ClipRect(
                            child: user.coverUrl != null
                                ? Image.network(
                                  user.coverUrl ?? '',
                                  fit: BoxFit.fill,
                                )
                                    : coverFile==null
                                    ? Image.asset(
                                  Assets.coverphoto.path,
                                  fit: BoxFit.fill,
                                )
                                    : Image.file(
                                    coverFile!,
                                  fit: BoxFit.cover,
                                )
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
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
                      Positioned(
                        top: 100,
                        left: 115,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.green, width: 5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  imagePickerOption();
                                },
                                child: ClipOval(
                                  child: user.picUrl != null
                                      ? Image.network(
                                        user.picUrl ?? '',
                                        width: 170,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      )
                                          : file==null
                                          ? Image.asset(
                                        Assets.defaultpicture.path,
                                        width: 170,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.file(
                                        width: 170,
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
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    initialValue: user.email,
                    enabled: false,
                    decoration: InputDecoration(suffixIcon: Icon(Icons.lock)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: dobField(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: locationTextField(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: aboutTextField(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: GenderField(),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => {
                      TopVariable.switchScreen(cnicUploaderScreenPath),
                    },
                    child: Text(
                      'Click the link to upload your cnic picture',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: isLoading ? Center(child: const CircularProgressIndicator()):ElevatedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await updateUser(user);
                      }
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  updateUser(User user) {
    db.collection("users").doc(user.email).update(user.toJson()).then((value) async {
      UserPreferences.user = user;
      await storageProfilePics.child(UserPreferences.user.email).child('profile.jpg').putData(cropImage!)
          .then((p0) async {
        await storageProfilePics.child(UserPreferences.user.email).child('profile.jpg').getDownloadURL().then((value) {
          user.picUrl = value;
          db.collection("users").doc(user.email).update({"picUrl": value}).then((value) {
            db.collection("users").doc(user.email).update(user.toJson()).then((value) {
              UserPreferences.user = user;
            });
            setState(() {
              isLoading = false;
            });
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('user updated!')));
            MotionToast.success(
              title: Text(
                "User Updated! " + user.name.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              description: Text("Successfully!"),
            ).show(context);
          });
        });
      });
    }).onError((e, _) {});
  }

  Widget aboutTextField() {
    return TextFormField(
      maxLines: 4,
      initialValue: user.bio,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15, top: 15),
        labelText: "Bio",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Describe Yourself",
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        user.bio = value;
        value = '';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Biography';
        }
        return null;
      },
    );
  }

  Widget dobField() {
    DateTime dateTime1 = DateTime.now();
    if(user.dob == null) {
      // dateTime1 = DateFormat('yyyy-mm-dd').parse(user.dob!);
    }else {
      dateTime1 = DateFormat('yyyy-MM-dd').parse(user.dob!);
      print(dateTime1);
    }
    return DateTimeFormField(
      initialValue: user.dob == null ? null: dateTime1,
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.green),
          errorStyle: TextStyle(color: Colors.redAccent),
          labelStyle: TextStyle(color: Colors.green),
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.date_range,
            color: Colors.green,
          ),
          suffixIcon: Icon(Icons.event_note),
          labelText: 'Date',
          hintText: 'Enter Your Birth Date'),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        dateTime1 = value;
        String date = value.toString();
        date = date.replaceAll('00:00:00.000', '');
        user.dob = date;
        //value='' as DateTime;
      },
    );
  }

  Widget locationTextField() {
    return TextFormField(
      // initialValue: user.loc,
      controller: locationController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.only(left: 15),
        prefixIcon: Icon(
          Icons.location_city,
          color: Colors.green,
        ),
        labelText: "Location",
        labelStyle: TextStyle(color: Colors.green),
        hintText: "Enter Your Location",
        suffixIcon: isLocationLoading
            ? IconButton(
          onPressed: () async {
          },
          icon: Icon(
            Icons.sync,
          ),
        )
            : IconButton(
          onPressed: () async {
            setState(() {
              isLocationLoading = true;
            });
            await locationService();
            setState(() {
              isLocationLoading = false;
            });
          },
          icon: Icon(
            Icons.location_on_outlined,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        user.loc = value;
        value = '';
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Enter Location';
        }
        return null;
      },
    );
  }

  Widget GenderField() {
    return DropdownButtonFormField(
      value: dropdownValue,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 2.0)),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 15)),
      items: const [
        DropdownMenuItem<String>(
            child: Text('Choose Gender',
                style: TextStyle(color: Color(0xff11b719))),
            value: ''),
        DropdownMenuItem<String>(child: Text('Male'), value: 'Male'),
        DropdownMenuItem<String>(child: Text('Female'), value: 'Female'),
      ],
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          value = '';
          user.gender = dropdownValue as String;
        });
      },
      validator: (value) {
        if (dropdownValue == '') return 'You must select gender';
        return null;
      },
    );
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child:  ElevatedButton(onPressed: (){}, child:Text(
                      "Choose Profile photo",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickImage(ImageSource.camera);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(
                                  'assets/cam.json',
                                ),
                              ),
                            ),
                            Text(
                              "CAMERA",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickImage(ImageSource.gallery);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(
                                  'assets/gallery.json',
                                ),
                              ),
                            ),
                            Text(
                              "GALLERY",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void coverimagePickerOption() {
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
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                    child:  ElevatedButton(onPressed: (){}, child:Text(
                      "Choose Cover Photo",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickCoverImage(ImageSource.camera);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(
                                  'assets/camera.json',
                                ),
                              ),
                            ),
                            Text(
                              "CAMERA",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickCoverImage(ImageSource.gallery);
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Lottie.asset(
                                  'assets/gallery.json',
                                ),
                              ),
                            ),
                            Text(
                              "GALLERY",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
