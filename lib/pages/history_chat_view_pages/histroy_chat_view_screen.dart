import 'package:chat_bot/constant/app_color.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/pages/chat_pages/chat_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constant/app_icon.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/chat_icon.dart';
import '../../widgets/chat_text_field.dart';
import 'history_chat_view_controller.dart';

class HistoryChatViewScreen extends StatelessWidget {
  String message;
  String answer;

  HistoryChatViewScreen({Key? key, required this.answer, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.chatBackColor,
      appBar: AppAppBar(
        appbarTitle: "History Chat", backGroundColor: AppColor.chatBackColor,),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: AppColor.chatBackColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      AppIcon.meIcon(),

                      10.0.addWSpace(),

                      Expanded(child: Text(
                        message,
                        style: const TextStyle(color: Colors.white),))
                    ],
                  ).marginSymmetric(horizontal: 20),

                  10.0.addHSpace(),


                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: const Color(0xff444654),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppIcon.responseIcon(),

                      10.0.addWSpace(),

                      Expanded(child: Text(
                        answer,
                        style: const TextStyle(color: Colors.white),))


                    ],
                  ).marginSymmetric(horizontal: 20),

                  10.0.addHSpace(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChatIcon(
                        icon: const Icon(
                          Icons.copy, color: Colors.white,),
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: answer));
                          showSnackBar(context, title: "Copy");
                        },
                        text: "Copy",
                      ),


                      ChatIcon(
                        icon: const Icon(
                          Icons.share, color: Colors.white,),
                        onTap: () async {
                          await shareMessage(answer);
                          showSnackBar(context, title: "Share");
                        },
                        text: "Share",
                      ),


                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
