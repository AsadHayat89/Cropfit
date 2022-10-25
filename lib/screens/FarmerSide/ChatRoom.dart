import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../data models/user.dart';
import '../../utilities/top_level_variables.dart';
import '../Controller/ChatController.dart';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;
  final String senderName;
  final String senderID;
  User user = UserPreferences.user;


  ChatRoom({required this.chatRoomId, required this.userMap, required this.senderName, required this.senderID});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  File? imageFile;

  Future getImage() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": user.name,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
    FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});

      print(imageUrl);
    }
  }

  void onSendMessage() async {
    print("Check1");


    if (_message.text.isNotEmpty) {
      print("Check2");
      Map<String, dynamic> messages = {
        "sendby": user.name,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      Map<String,Map<String, dynamic>> MainMessage={
        chatRoomId:messages
      };
      print("MEssages: "+ messages.toString());
      _message.clear();





     await _firestore
          .collection('PersonChatIds')
          .doc(user.email)
          .update({"person1": FieldValue.arrayUnion([senderID])});

     await _firestore
          .collection('PersonChatIds')
          .doc(senderID)
          .update({"person1": FieldValue.arrayUnion([user.email])});

      await _firestore
          .collection('chats')
          .doc(chatRoomId)
          .collection('messages')
          .add(messages);

      //testing working best
      //await db.collection("chats").doc("asd2").set(messages);

      // Map<String, dynamic> Receiver={
      //   "email": senderID,
      //   "Name": senderName
      // };
      //
      // await _firestore
      //     .collection('chats')
      //     .doc(chatRoomId)
      //     .collection('User1')
      //     .add(Receiver);
      //
      // Map<String, dynamic> Sender={
      //   "email": user.email,
      //   "Name": user.name
      // };
      //
      // await _firestore
      //     .collection('chats')
      //     .doc(chatRoomId)
      //     .collection('User2')
      //     .add(Sender);

    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // title: StreamBuilder<DocumentSnapshot>(
        //   stream:  _firestore.collection("users").doc(userMap['uid']).snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.data != null) {
        //       return Container(
        //         child: Column(
        //           children: [
        //             Text(userMap['name']),
        //             Text(
        //               snapshot.data!['status'],
        //               style: TextStyle(fontSize: 14),
        //             ),
        //           ],
        //         ),
        //       );
        //     } else {
        //       return Container();
        //     }
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,

              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chats')
                    .doc(chatRoomId)
                    .collection('messages')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => getImage(),
                              icon: Icon(Icons.photo),
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return map['type'] == "text"
        ? Container(
      width: size.width,
      alignment: map['sendby'] == user.name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color:map['sendby'] == user.name? Colors.green:Colors.blue,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    )
        : Container(
      height: size.height / 2.5,
      width: size.width,

      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      alignment: map['sendby'] == user.name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ShowImage(
              imageUrl: map['message'],
            ),
          ),
        ),
        child: Container(
          height: size.height / 2.5,
          width: size.width / 2,
          decoration: BoxDecoration(border: Border.all()),
          alignment: map['message'] != "" ? null : Alignment.center,
          child: map['message'] != ""
              ? Image.network(
            map['message'],
            fit: BoxFit.cover,
          )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//