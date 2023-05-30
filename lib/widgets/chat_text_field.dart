import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_icon.dart';

class ChatTextField extends StatelessWidget {
  TextEditingController textEditingController;
  VoidCallback onTap;
  ChatTextField({Key? key,required this.textEditingController,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff40414F),
        child: TextField(
          controller: textEditingController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
              hintText: "Send a message.",
              hintStyle: const TextStyle(color: Color(0xff8E8EA0),fontSize: 17),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: IconButton(onPressed: onTap, icon: AppIcon.sendMessageIcon())

          ),
        ).marginOnly(left: 10)
    ).marginOnly(bottom: 20,left: 15,right: 15);
  }
}
