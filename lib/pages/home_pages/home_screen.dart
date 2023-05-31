import 'package:chat_bot/constant/app_icon.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/extensions/text_extension.dart';
import 'package:chat_bot/pages/chat_pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_color.dart';
import '../../constant/app_text.dart';
import '../../widgets/intro_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff152F14),
      bottomNavigationBar: IntroButton(
        onTap: (){
          Get.offAll(const ChatScreen(),transition: Transition.rightToLeft);
        },
      ).marginAll(15),
      body: Column(
        children: [

          Container(
            height: height / 3,
          ),

          // Align(
          //     alignment: Alignment.center,
          //     child: AppIcon.openAiIcon()),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(AppAssets.splashScreenImage,color: AppColor.introTextColor,)),

          30.0.addHSpace(),

          "WelCome To ${AppText.appName}".introTitleText(),

          10.0.addHSpace(),


          '''The dialogue format makes it possible for ${AppText.appName} to answer followup questions,admit its mistakes challenge incorrect premises,and reject inappropriate request.'''.introSubTitleText(),


          // Container(
          //   height: height / 8,
          //   // color: Colors.red,
          // ),




        ],
      ).marginSymmetric(horizontal: 15),
    );
  }
}
