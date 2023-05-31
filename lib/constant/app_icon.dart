

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'app_assets.dart';

class AppIcon{

  static Widget soundOnIcon(){
    return SvgPicture.asset(AppAssets.soundOnIcon,color: Colors.white,height: 30,width: 30,);
  }


  static Widget appReviewIcon(){
    return SvgPicture.asset(AppAssets.appReviewIcon,color: Colors.white,height: 30,width: 30,);
  }


  static Widget soundOffIcon(){
    return SvgPicture.asset(AppAssets.soundOffIcon,color: Colors.white,height: 30,width: 30,);
  }

  static Widget termsAndConditionIcon(){
    return SvgPicture.asset(AppAssets.termsAndConditionIcon,color: Colors.white,height: 30,width: 30,);
  }

  static Widget privacyPolicyIcon(){
    return SvgPicture.asset(AppAssets.privacyPolicyIcon,color: Colors.white,height: 30,width: 30,);
  }


  static Widget capabilityIcon(){
    return SvgPicture.asset(AppAssets.capabilityIcon,color: Colors.white,height: 35,width: 35,);
  }

  static Widget historyChatIcon(){
    return SvgPicture.asset(AppAssets.histroyChatICon,color: Colors.white,height: 25,width: 25,);
  }

  static Widget deleteIcon(){
    return SvgPicture.asset(AppAssets.deleteIcon,color: Colors.white,height: 25,width: 25,);
  }

  static Widget sendMessageIcon(){
    return SvgPicture.asset(AppAssets.sendMessageIcon,color: const Color(0xff8E8EA0),);
  }


  static Widget openAiIcon({double? height, double? width}){
    return SvgPicture.asset(AppAssets.openAiIcon,color: Colors.white,height: height ?? 100,width: width ?? 100,);
  }



  static Widget meIcon(){
    return  Container(
      height: 40,
      width: 40,
      color: const Color(0xff444654),
      child: const Center(child: Text('ME',style: TextStyle(color: Colors.white)),),
    );
  }


  static Widget responseIcon(){
    return  Container(
      height: 40,
      width: 40,
      color: const Color(0xff0FA47F),
      child: Center(
        child: Image.asset(AppAssets.splashScreenImage,color: Colors.white,).marginAll(5),
      ),
    );
  }

}

class AppLottie{
  static Widget loadingLottie () {
    return Lottie.asset(
      AppAssets.loadingLottie,
      width: 60,
      // height: 200,
      fit: BoxFit.fill,
    );
  }
}