import 'package:flutter/material.dart';

class ChatIcon extends StatelessWidget {
  String text;
  Widget icon;
  VoidCallback onTap;
  ChatIcon({Key? key,required this.text,required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox.fromSize(
      size: const Size(56, 56),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                icon,
                Text(text,style: const TextStyle(color: Colors.white),), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );
  }
}
