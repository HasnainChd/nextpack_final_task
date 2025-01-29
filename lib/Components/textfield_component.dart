import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  final Color hintColor;
  final Color iconColor;
  final String? Function(String?) validator;


  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconData,
    required this.hintColor,
    required this.iconColor,
    required this.validator,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.white,fontSize: 16),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            prefixIcon: Icon(iconData,color: iconColor,),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}

