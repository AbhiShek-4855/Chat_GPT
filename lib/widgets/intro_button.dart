import 'package:chat_bot/constant/app_text.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_color.dart';

class IntroButton extends StatelessWidget {
  VoidCallback onTap;
  IntroButton({Key? key,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.introTextColor)
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Try ${AppText.appName}".introButtonStyle(),
              5.0.addWSpace(),
              Icon(Icons.arrow_forward_rounded,color: AppColor.introTextColor ,)
            ],
          ),
        ),
      ),
    ).marginOnly(bottom: 10);
  }
}
