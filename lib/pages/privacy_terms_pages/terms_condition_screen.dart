import 'package:chat_bot/extensions/space_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../constant/app_color.dart';
import '../../constant/app_text.dart';
import '../../utils/app_key.dart';
import '../../widgets/app_app_bar.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.chatBackColor,
      appBar: AppAppBar(appbarTitle: "Terms and Condition"),

      body: SingleChildScrollView(
        child: Column(
          children: [
            10.0.addHSpace(),
            const HtmlWidget(
              HtmlStrings.termsHtmlString,
              textStyle: TextStyle(color: Colors.white),
            )
            ,10.0.addHSpace(),
          ],
        ).marginSymmetric(horizontal: 15),
      ),
    );
  }
}
