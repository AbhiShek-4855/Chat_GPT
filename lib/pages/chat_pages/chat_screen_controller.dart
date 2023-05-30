import 'dart:developer';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../modals/chat_modals.dart';
import '../../shared_preference/shared_preference.dart';
import '../../utils/app_key.dart';
  import 'package:speech_to_text/speech_to_text.dart' as stt;


class ChatScreenController extends GetxController{
  Rx<TextEditingController> chatController = TextEditingController().obs;
  RxList chatList = <ChatModal>[].obs;
  RxBool isLoading  = false.obs;
  ScrollController scrollController =  ScrollController();
  final FlutterTts flutterTts = FlutterTts();
  RxBool isSpeak = true.obs;
  final GlobalKey<ScaffoldState> key = GlobalKey(); // Create a key
  RxInt messageLimit = maxMessageLimit.obs;
  // SpeechToText speechToText = SpeechToText();
  SpeechToText speech = SpeechToText();
  RxBool isListening = false.obs;





  downScroll() {
    scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(seconds: 1),
    );
  }

  speak(String value) async {
    await flutterTts.stop();
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    isSpeak.value == true ?  await flutterTts.speak(value) : null;
  }

  storeChatLimit (int value) async {
    storeIntKey(messageKey,value);
    messageLimit = await getIntKey(messageKey) ?? maxMessageLimit;
    print("MessageLimit =------> $messageLimit");
    update();
  }

  getLocalData() async {
    isSpeak.value = await getBoolKey(isSpeakKey);
    messageLimit.value = await getIntKey(messageKey);
    log('Is Sound On ------> ${isSpeak.value}');
    log('Message Limit ------> ${messageLimit.value}');
    update();
  }


  OpenAI openAI = OpenAI.instance.build(
    token: openAiToken,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 22),
      connectTimeout: const Duration(seconds: 22),
      sendTimeout: const Duration(seconds: 22),
    ),
    // isLog: true,
  );


  dynamic chatComplete(String question) async {
    String data = "";
    try{
      final request = ChatCompleteText(messages: [
        Map.of({"role": "user", "content": question.trim()})
      ],
          maxToken: 300,
          model: ChatModel.gptTurbo);
      final response = await openAI.onChatCompletion(request: request);
      for (var element in response!.choices) {
        data = element.message?.content.toString() ?? "";
      }
    }catch(e){
      final request = CompleteText(prompt: question,   model: Model.textDavinci3, maxTokens: 300);
      final response = await openAI.onCompletion(request: request);
      String answer = response?.choices.last.text.trim() ?? "";
      data = answer;
      update();
    }
    return data;
  }


  generateResponse(String sendQuestion) async {
    getLocalData();

    await flutterTts.stop();
    isLoading.value = true;
    try{
      String answer = await chatComplete(sendQuestion);
      storeChat(chat: sendQuestion,answer: answer,dateTime: DateTime.now().toString(),isSent: true);
      addMessageToMessageList(answer, true);
      downScroll();
      isLoading.value = false;
      update();
    }catch(e){
      addMessageToMessageList('Failed to response', true);
      print('Generate Chat Error is -----> $e');
      isLoading.value = false;
      update();
    }
  }

  addMessageToMessageList( String message, bool isSent){
    chatList.insert(0, ChatModal(message: message, isSent: isSent));
    update();
  }


  startListening() async {
    await flutterTts.stop();
    try{
      speech.listen(
          onResult: (result) {
            chatController.value.text  =  result.recognizedWords;
            print("Listen Text-------> ${chatController.value.text}");
            update();
          }

      );

      isListening.value = true;
      update();
    }catch(e){
      print("Listing Error is  ---------> $e");
    }
  }

  void stopListening() {
    try{
      speech.stop();
      isListening.value = false;
      update();
    }catch(e){
      print("Stop Listing Error is -------> $e");
    }
  }

  Future<void> initSpeechToText() async {
    speech = stt.SpeechToText();
    bool available = await speech.initialize();
    if (available) {
        isListening.value = false;
        update();
    } else {
      print('Speech recognition is not available');
    }
  }



  @override
  void onClose() {
    chatController.close();
    flutterTts.stop();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onInit() {
    initSpeechToText();
    getLocalData();
    // TODO: implement onInit
    super.onInit();
  }


}