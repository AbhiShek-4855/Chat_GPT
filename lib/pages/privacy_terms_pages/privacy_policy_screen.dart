import 'package:chat_bot/constant/app_color.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../constant/app_text.dart';
import '../../utils/app_key.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.chatBackColor,
      appBar: AppAppBar(appbarTitle: "Privacy Policy"),

      body: SingleChildScrollView(
        child: Column(
          children: [
            10.0.addHSpace(),


            HtmlWidget(
              onLoadingBuilder: (context, element, loadingProgress) {
                return const Center(child: CircularProgressIndicator(color: Colors.white,));
              },
                HtmlStrings.privacyPolicy,
              textStyle: const TextStyle(color: Colors.white),
            ),
            10.0.addHSpace(),
          ],
        ).marginSymmetric(horizontal: 15),
      ),
    );
  }
}
