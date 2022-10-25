import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop_fit/data%20models/ChatUSer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/shared_preferences.dart';
import '../Controller/ChatController.dart';
import 'ChatRoom.dart';
import '../../data models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  List<String>? ChattedUser;
  bool isLoading = false;
  User user = UserPreferences.user;
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var ControllerChat = Get.put(chatController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    serachCaht();
    //testingFunction();
    //print("chatted USer: "+ChattedUser!.length.toString());
    // serachCaht();
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(user.email).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void serachCaht() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection("PersonChatIds")
        .doc(user.email)
        .get()
        .then((value) {
      List.from(value['person1']).forEach((element) {
        //print(value['person1'][0]);

        if(!ControllerChat.ChattedList.contains(element))
          {
            ControllerChat.ChattedList.value.add(element);
          }
        onSearch(element);

        ControllerChat.ChattedList.length;
        //ChattedUser.add(value['person1'])
      });

      setState(() {
        isLoading = false;
      });
    });

    // setState(() {
    //   isLoading = false;
    // });
  }

  // void testingFunction() async{
  //   QuerySnapshot querySnapshot = await _firestore
  //       .collection('users')
  //       .get();
  //   String mail;
  //   for(int i=0;i<querySnapshot.size;i++){
  //     mail=querySnapshot.docs[i]['email'];
  //     if(mail!=user.email){
  //       await _firestore
  //           .collection('PersonChatIds')
  //           .doc(mail)
  //           .set({"person1": []});
  //     }
  //
  //   }
  //
  //
  // }
  void onSearch(String search) async {
    // print("asdf"+search);
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    //print("Chatt: " + ChattedUser!.length.toString());
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: search)
        .get()
        .then((value) {

      ChatUser c=new ChatUser();
      userMap=value.docs[0].data();
      print(userMap!['name']);
      c.name=userMap!['name'];
      c.email=userMap!['email'];
      if(!ControllerChat.getStatusUser(userMap!['email'])){
        ControllerChat.UserInfo.value.add(c);
      }
setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      //print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          //IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => ControllerChat.isloadding.value
              ? Center(
                  child: Container(
                    height: size.height / 20,
                    width: size.height / 20,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height / 14,
                          alignment: Alignment.center,
                          child: Container(
                            height: size.height / 14,
                            width: size.width / 1.45,
                            child: TextField(
                              controller: _search,
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed:(){
                            onSearch(_search.text);
                          }, //
                          child: Text("Search"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    isLoading == false
                        ? SizedBox(
                            height: size.height,

                            child: ListView.builder(
                              itemCount:   ControllerChat.UserInfo.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    //print("Auth data : "+_auth.currentUser!.email.toString());
                                    String roomId =
                                        chatRoomId(user.name!, ControllerChat.UserInfo[index].name!);

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => ChatRoom(
                                          senderID: ControllerChat.UserInfo[index].email!,
                                          senderName: ControllerChat.UserInfo[index].name!,
                                          chatRoomId: roomId,
                                          userMap: userMap!,
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Icon(Icons.account_box,
                                      color: Colors.black),
                                  title: Text(
                                    ControllerChat.UserInfo[index].name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text(ControllerChat.UserInfo[index].email!),
                                  trailing: Icon(Icons.chat, color: Colors.black),
                                );
                              },
                            ),
                          )
                        : Container(
                            child: Center(child: Text("Loading")),
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
