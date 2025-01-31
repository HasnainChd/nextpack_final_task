import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Controllers/auth_controller.dart';

class ButtonComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Row(children: [
      Expanded(
          child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: [
                    Colors.purple,
                    Colors.red,
                  ]),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Obx(
              () => authController.isLoading.value
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    ),
              // ),
            ),
          ),
        ),
      ))
    ]);
  }
}
