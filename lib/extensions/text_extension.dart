
import 'package:flutter/material.dart';

import '../constant/app_color.dart';

extension TextWidget on String {
  introTitleText(){
    return Text(this,style: TextStyle(color: AppColor.introTextColor,fontSize: 20,fontWeight: FontWeight.w500),);
  }


  introSubTitleText(){
    return Text(this,style: TextStyle(color: AppColor.introTextColor),textAlign: TextAlign.center,);
  }

  introButtonStyle(){
    return Text(this,style: TextStyle(color: AppColor.introTextColor,fontWeight: FontWeight.w500),textAlign: TextAlign.center,);
  }


  homeTitleText(){
    return Text(this,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),textAlign: TextAlign.center,);
  }

}