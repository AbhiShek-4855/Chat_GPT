import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/app_assets.dart';
import '../constant/app_color.dart';

class AppAppBar extends PreferredSize {
  final String? appbarTitle;
  Widget? title;
  Color? backGroundColor;
  Widget? leading;
  Widget? flexibleSpace;
  List<Widget>? action = [];
  PreferredSizeWidget? bottom;
  VoidCallback? onTap;
  Color? textColor;
  double? height;

  AppAppBar({
    Key? key,
    this.title,
    this.textColor,
    this.appbarTitle,
    this.leading,
    this.bottom,
    this.backGroundColor,
    this.height,
    this.onTap,
    this.flexibleSpace,
    this.action,
    Size? preferredSize,
  }) : super(
    key: key,
    child: Container(),
    preferredSize: Size.fromHeight(height ?? 60),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      flexibleSpace: flexibleSpace,
      actions: action,
      centerTitle: true,
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      toolbarHeight: 70,
      titleSpacing: 0,
      title: title ?? Text(appbarTitle ?? "",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: textColor ??  Colors.white)),
      backgroundColor: backGroundColor ?? AppColor.chatBackColor,
      bottom: bottom,


      // backgroundColor: Colors.red,
    );
  }
} // AppColor.chatBackColor