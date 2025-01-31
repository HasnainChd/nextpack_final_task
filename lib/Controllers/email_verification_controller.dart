import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Components/custom_snackbar.dart';
import 'package:next_final_task/Components/text_component.dart';

class EmailVerificationController extends GetxController {
  var timer = 60.obs;
  Timer? countDown;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = 60;
    countDown?.cancel();
    countDown = Timer.periodic(Duration(seconds: 1), (time) {
      if (timer.value > 0) {
        timer.value--;
      } else {
        time.cancel();
      }
    });
  }

  void resendEmailVerification(user) async {
    try {
      await user.sendEmailVerification();
      startTimer();
      CustomSnackBar.successSnackBar('Verification email is sent');
    } catch (e) {
      CustomSnackBar.errorSnackBar('Failed to send verification email');
    }
  }

  void showVerificationDialog(user) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.purple.shade200,
        title: Text('Email Not Verified'),
        content: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Please verify your email.'),
                SizedBox(height: 10),
                Text(timer.value > 0
                    ? 'Resend in ${timer.value}s'
                    : 'You can resend now'),
              ],
            )),
        actions: [
          Obx(() => ElevatedButton(
              onPressed:
                  timer.value > 0 ? null : () => resendEmailVerification(user),
              child: TextComponent(
                  text: 'Resend', fontSize: 16, color: Colors.green.shade200))),
          TextButton(
              onPressed: () {
                countDown?.cancel();
                Get.back();
              },
              child: TextComponent(
                  text: 'Cancel', fontSize: 16, color: Colors.red.shade200))
        ],
      ),
      barrierDismissible: false,
    );
  }
}
