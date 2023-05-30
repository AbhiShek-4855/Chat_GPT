import 'dart:developer';

import 'package:get/get.dart';

import '../../shared_preference/shared_preference.dart';

class SettingPageController extends GetxController{

  RxBool isSoundOn = true.obs;

  onChangeSound(value){
    isSoundOn.value = value;
    setBoolValue(isSpeakKey,isSoundOn.value);
    update();
  }



  getLocalData() async {
    isSoundOn.value = await getBoolKey(isSpeakKey);
    log('Is Sound On ------> ${isSoundOn.value}');
    update();
  }



  @override
  void onInit() {
    getLocalData();
    // TODO: implement onInit
    super.onInit();
  }

}