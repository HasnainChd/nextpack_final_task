import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static successSnackBar(String msg) {
    return Get.snackbar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
      'success',
      msg,
      colorText: Colors.white,
    );
  }

  static errorSnackBar(String text) {
    return Get.snackbar(
      backgroundColor: Colors.red,
      'Error',
      text,
      colorText: Colors.white,
    );
  }
}
