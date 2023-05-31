// ignore_for_file: use_build_context_synchronously
import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/extensions/text_extension.dart';
import 'package:chat_bot/google_ads_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../../constant/app_text.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/chat_icon.dart';
import '../../widgets/chat_text_field.dart';
import '../../widgets/null_chat_container.dart';
import '../history_pages/history_screen.dart';
import '../setting_pages/setting_screen.dart';
import 'chat_screen_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final chatScreenController = Get.put(ChatScreenController());
    final googleAdsController = Get.put(GoogleAdsController());

    Future<Widget> _banner() async {
      await googleAdsController.bannerAds.value.dispose();
      await googleAdsController.loadBanner();

      return Container(
        alignment: Alignment.center,
        height: googleAdsController.bannerAds.value.size.height.toDouble(),
        width: googleAdsController.bannerAds.value.size.width.toDouble(),
        child: AdWidget(ad: googleAdsController.bannerAds.value),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.chatBackColor,
      appBar: AppAppBar(
        appbarTitle: AppText.appName,
        leading: Obx(() {
          return GestureDetector(
            onTap: () {
              print("Reward clicked.");
              googleAdsController.showRewardedAd();
            },
            child: CircleAvatar(
              backgroundColor: AppColor.introBackColor,
              child: "${chatScreenController.messageLimit.value}"
                  .introSubTitleText(),
            ),
          );
        }).marginAll(10),
        action: [
          IconButton(
              onPressed: () async {
                await chatScreenController.flutterTts.stop();
                Get.to(const HistoryScreen(), transition: Transition.rightToLeft);
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () async {
                await chatScreenController.flutterTts.stop();
                Get.to(const SettingScreen(),transition: Transition.rightToLeft);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              )),
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            chatScreenController.chatList.isEmpty
                ? const NullCheckContainer()
                : ListView.builder(
                    controller: chatScreenController.scrollController,
                    itemCount: chatScreenController.chatList.length,
                    shrinkWrap: true,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        color:
                            chatScreenController.chatList[index].isSent == true
                                ? const Color(0xff444654)
                                : AppColor.chatBackColor,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                chatScreenController.chatList[index].isSent
                                    ? AppIcon.responseIcon()
                                    : AppIcon.meIcon(),
                                10.0.addWSpace(),
                                Expanded(
                                    child: Text(
                                  chatScreenController.chatList[index].message,
                                  style: const TextStyle(color: Colors.white),
                                ))
                              ],
                            ).marginSymmetric(horizontal: 20),
                            10.0.addHSpace(),
                            chatScreenController.chatList[index].isSent == true
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ChatIcon(
                                        icon: const Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                              text: chatScreenController
                                                  .chatList[index].message));
                                          showSnackBar(context, title: "Copy");
                                        },
                                        text: "Copy",
                                      ),
                                      ChatIcon(
                                        icon: const Icon(Icons.share, color: Colors.white),
                                        onTap: () async {
                                          await shareMessage(chatScreenController.chatList[index].message);
                                          showSnackBar(context, title: "Share");
                                        },
                                        text: "Share",
                                      ),
                                      ChatIcon(
                                        icon: const Icon(
                                          Icons.volume_up_rounded,
                                          color: Colors.white,
                                        ),
                                        onTap: () async {
                                          chatScreenController.speak(
                                              chatScreenController
                                                  .chatList[index].message);
                                          // await shareMessage(chatScreenController.chatList[index].message);
                                          // showSnackBar(context, title: "Share");
                                        },
                                        text: "Speak",
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    }).marginOnly(bottom: 118),

            // const Expanded(child: NullCheckContainer()),
            //
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                chatScreenController.isLoading.value == false ? Container() : AppLottie.loadingLottie(),
                5.0.addHSpace(),
                Container(
                  color: AppColor.chatBackColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: ChatTextField(
                          textEditingController:
                              chatScreenController.chatController.value,
                          onTap: () {
                            if (chatScreenController.isLoading.value == true) {
                              showSnackBar(context,
                                  title: "Please Wait While Loading");
                            } else if (chatScreenController
                                .chatController.value.text.isEmpty) {
                              showSnackBar(context,
                                  title: "Please Enter Some Text");
                            } else if (chatScreenController.messageLimit.value ==
                                0) {
                              hideKeyboard(context);
                              showSnackBar(context, title: "Please Watch Video");
                            } else {
                              hideKeyboard(context);
                              chatScreenController.messageLimit.value == 0
                                  ? null
                                  : chatScreenController.messageLimit.value--;
                              chatScreenController.storeChatLimit(
                                  chatScreenController.messageLimit.value);
                              chatScreenController.addMessageToMessageList(
                                  chatScreenController.chatController.value.text,
                                  false);
                              chatScreenController.generateResponse(
                                  chatScreenController.chatController.value.text);
                              chatScreenController.chatController.value.clear();
                            }
                          },
                        ),
                      ),


                      GestureDetector(
                        onTap: chatScreenController.isListening.value
                            ?
                        chatScreenController.stopListening
                            :
                        chatScreenController.startListening,
                        child: AvatarGlow(
                           animate: chatScreenController.isListening.value,
                          repeat: chatScreenController.isListening.value,
                          endRadius: 30.0,
                          child:  const CircleAvatar(
                            backgroundColor: Color(0xff40414F),
                            child: Icon(
                              Icons.mic,
                              color: Colors.white
                            )).marginOnly(bottom: 20),
                        ),
                      )
                    ],
                  ),
                ),

               // FutureBuilder(
               //     future: _banner(),
               //     builder: (context,snapShot){
               //   if(snapShot.connectionState == ConnectionState.waiting){
               //     return const SizedBox.shrink();
               //   }
               //   return snapShot.data as Widget;
               // })


               // Obx(() =>  Container(
               //   // height: 40,
               //   color: Colors.red,
               //   child: AdWidget(ad: googleAdsController.bannerAds.value),
               // ))

              ],
            ),
          ],
        );
      }),
    );
  }
}
