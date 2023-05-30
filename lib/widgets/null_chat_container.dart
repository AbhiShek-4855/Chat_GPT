import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/extensions/text_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_icon.dart';

class NullCheckContainer extends StatelessWidget {
  const NullCheckContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            50.0.addHSpace(),
            AppIcon.capabilityIcon(),
            "Capability".homeTitleText(),
            30.0.addHSpace(),
            textContainer('''Remembers what user said earlier in the conversation'''),
            5.0.addHSpace(),
            textContainer('''Allows user to provide follow-up corrections'''),
            5.0.addHSpace(),
            textContainer('''Trained to decline inappropriate requests'''),

          ],
        ),

      ],
    );
  }

  Widget textContainer(String text) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(color: const Color(0xff3E3F4B),borderRadius: BorderRadius.circular(8)),
      // width: double.infinity,
      child: Text(text,style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,).marginAll(10),
    );
  }

}
