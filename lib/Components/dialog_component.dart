import 'package:flutter/material.dart';

class DialogComponent extends StatelessWidget {
  const DialogComponent({super.key});

  void showMyDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
