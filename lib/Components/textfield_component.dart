import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final String hintText;
  final IconData prefixIcon;
  final IconButton? suffixIcon;
  final Color hintColor;
  final Color iconColor;
  final String? Function(String?) validator;

  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.hintColor,
    required this.iconColor,
    required this.validator,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        obscureText: obscureText!,
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor),
            prefixIcon: Icon(prefixIcon, color: iconColor),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
