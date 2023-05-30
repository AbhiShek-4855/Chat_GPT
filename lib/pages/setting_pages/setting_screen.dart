import 'package:chat_bot/constant/app_icon.dart';
import 'package:chat_bot/pages/setting_pages/setting_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../constant/app_color.dart';
import '../../widgets/app_app_bar.dart';
import '../privacy_terms_pages/privacy_policy_screen.dart';
import '../privacy_terms_pages/terms_condition_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingPageController = Get.put(SettingPageController());
    final InAppReview inAppReview = InAppReview.instance;

    return Scaffold(
      backgroundColor: AppColor.chatBackColor,
      appBar: AppAppBar(
        appbarTitle: "Setting",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Obx(() {
          //   return settingPageListTile(
          //     onTap: () {},
          //     title: settingPageController.isSoundOn.value == false
          //         ? "Sound Off"
          //         : "Sound On",
          //     leadingIcon: settingPageController.isSoundOn.value == true
          //         ? AppIcon.soundOnIcon()
          //         : AppIcon.soundOffIcon(),
          //     trailing: CupertinoSwitch(
          //         value: settingPageController.isSoundOn.value,
          //         onChanged: settingPageController.onChangeSound),
          //   );
          // }),
          settingPageListTile(
            onTap: () async {
              if (await inAppReview.isAvailable()) {
                inAppReview.requestReview();
              }
            },
            leadingIcon: AppIcon.appReviewIcon(),
            title: "App Review",
            trailing: const SizedBox(),
          ),
          settingPageListTile(
            onTap: () {
              Get.to(const PrivacyPolicyScreen(),
                  transition: Transition.rightToLeft);
            },
            leadingIcon: AppIcon.privacyPolicyIcon(),
            title: "Privacy Policy",
            trailing: const SizedBox(),
          ),
          settingPageListTile(
              onTap: () {
                Get.to(const TermsAndConditionScreen(),
                    transition: Transition.rightToLeft);
              },
              leadingIcon: AppIcon.termsAndConditionIcon(),
              title: "Terms and condition",
              trailing: const SizedBox()
              // trailing: Container(),
              ),
        ],
      ),
    );
  }

  Widget settingPageListTile(
      {required String title,
      required Widget trailing,
      Widget? leadingIcon,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      leading: leadingIcon,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: trailing,
    );
  }
}
