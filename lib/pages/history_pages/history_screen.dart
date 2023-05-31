import 'package:chat_bot/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../history_chat_view_pages/histroy_chat_view_screen.dart';
import 'history_chat_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyScreenController = Get.put(HistoryChatController());

    return Scaffold(
      backgroundColor: AppColor.historyBackColor,
      appBar: AppAppBar(
        appbarTitle: "History",
        backGroundColor: AppColor.historyBackColor,
      ),
      body: Obx(() {
        return historyScreenController.historyList.isEmpty
            ? const Center(
                child: Text("No Pending History",
                    style: TextStyle(color: Colors.white)),
              )
            : ListView.builder(
                itemCount: historyScreenController.historyList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final historyChatList =
                      historyScreenController.historyList.reversed.toList();
                  return ListTile(
                    leading: AppIcon.historyChatIcon(),
                    onTap: () {
                      Get.to(
                          HistoryChatViewScreen(answer: historyChatList[index].answer ?? "", message: historyChatList[index].message ?? "",),
                          transition: Transition.rightToLeft);
                    },
                    title: Text('${historyChatList[index].answer}',
                        style: const TextStyle(color: Colors.white),
                        maxLines: 1),
                    trailing: IconButton(
                        onPressed: () {
                          historyScreenController.removeHistoryChat(
                            key: historyChatList[index].id ?? "",
                            index: index,
                          );
                        },
                        icon: AppIcon.deleteIcon()),
                  ).marginSymmetric(horizontal: 10);
                });
      }),
    );
  }
}
