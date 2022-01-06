import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarnToast(String? text) {
  if (text != null && text.length > 0) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}

void showToast(String? text) {
  if (text != null && text.length > 0) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.white);
  }
}
