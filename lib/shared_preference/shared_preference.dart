import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../modals/chat_modals.dart';



const String isSpeakKey = 'is_speak_key';
const String messageKey = 'message_Key';

Future<bool>getBoolKey(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? true;
}

setBoolValue(key,value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}


storeIntKey(key,value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}
getIntKey(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt(key);
}


storeChat({required String chat, required bool isSent, required String dateTime, required String answer}) async {
  try{
    String prefsKey = DateTime.now().microsecondsSinceEpoch.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ChatModal messageModel = ChatModal(message: chat, isSent: isSent, id: prefsKey, dateTime: dateTime, answer: answer);
    String jsonDocument = json.encode(messageModel);
    await prefs.setString(prefsKey.toString(), jsonDocument);
  }catch(e){
    print("Store Chat Error is ------> $e");
  }
}


removeChat(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}











