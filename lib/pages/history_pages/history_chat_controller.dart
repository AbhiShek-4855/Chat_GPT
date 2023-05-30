import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modals/chat_modals.dart';
import '../../shared_preference/shared_preference.dart';

class HistoryChatController extends GetxController{

  RxList<ChatModal> historyList = <ChatModal>[].obs;

  getLocalHistory() async {
    historyList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) async  {
      if(key !=  isSpeakKey){
        var jsonDocument = await json.decode(prefs.getString(key).toString());
        ChatModal messageModel = ChatModal(
          message: jsonDocument['message'],
          isSent: jsonDocument['isSent'],
          id: jsonDocument['id'],
          dateTime: jsonDocument['dateTime'],
          answer: jsonDocument['answer'],
        );
        historyList.add(messageModel);
      }else{}
    });
    print(" ----> ${historyList.length}");
  }


  removeHistoryChat({required String key, required int index}){
    removeChat(historyList[index].id ?? "");
    getLocalHistory();
  }


  @override
  void onInit() {
    getLocalHistory();
    // TODO: implement onInit
    super.onInit();
  }


}