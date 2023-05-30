import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

extension SpaceWidget on double{
  addHSpace(){
    return SizedBox(height: this);
  }

  addWSpace(){
    return SizedBox(width: this);
  }
}

/// HIDE KEYBOARD
hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}



/// SHARE TEXT
shareMessage(String message) async {
  await Share.share(message);
}


/// SHOW SNACKBAR
showSnackBar(BuildContext context,{required String title}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content:  Text(title,style: const TextStyle(color: Colors.black),),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    margin: const EdgeInsets.all(15),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 1),
  ));
}