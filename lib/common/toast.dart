
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastOverlay {

  static showToastMessage(String message, ToastType type, BuildContext context) {

    FToast fToast = FToast();
    fToast.init(context);

    Color backgroundColor;
    Color textColor;
    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      case ToastType.warning:
        backgroundColor = Colors.yellow;
        textColor = Colors.white;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        textColor = Colors.black;
        break;
    }

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Text(message, style: TextStyle(color: textColor)),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

  }

}

enum ToastType {
  success,
  warning,
  error,
}
