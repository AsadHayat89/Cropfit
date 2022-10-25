import 'package:get/get.dart';

import '../../data models/ChatUSer.dart';

class chatController extends GetxController{
  RxList<String> ChattedList=<String>[].obs;
  RxList<ChatUser> UserInfo=<ChatUser>[].obs;
  RxBool isloadding=false.obs;

  bool getStatusUser(String serach){

    for(int i=0;i<UserInfo.length;i++){
      if(UserInfo[i].email==serach){
        return true;
      }
    }
   return false;
  }
}