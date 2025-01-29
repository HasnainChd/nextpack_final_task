import 'package:flutter/material.dart';

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
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
