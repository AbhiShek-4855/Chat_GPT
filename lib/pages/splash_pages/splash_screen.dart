import 'package:chat_bot/constant/app_assets.dart';
import 'package:chat_bot/constant/app_color.dart';
import 'package:chat_bot/constant/app_text.dart';
import 'package:chat_bot/extensions/space_extension.dart';
import 'package:chat_bot/pages/home_pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Get.offAll(const HomeScreen());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.historyBackColor,

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(AppAssets.splashScreenImage)),


            20.0.addHSpace(),

            Text(AppText.appName,style: TextStyle(color: Colors.white,fontSize: 15),)
          ],
        ),
      ),

    );
  }
}
