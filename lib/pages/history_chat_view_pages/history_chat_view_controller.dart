import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HistoryChatViewController extends GetxController{

  Rx<TextEditingController> chatController = TextEditingController().obs;
  RxBool isLoading = false.obs;


}