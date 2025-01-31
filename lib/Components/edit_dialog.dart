import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Components/text_component.dart';
import 'package:next_final_task/Components/textfield_component.dart';
import 'package:next_final_task/Components/validators.dart';

import '../Controllers/user_controller.dart';

void showEditDialog(
    BuildContext context, String currentName, Function(String) onUpdate) {
  TextEditingController nameController =
      TextEditingController(text: currentName);
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.deepPurple.shade300,
        title:
            TextComponent(text: 'Edit Name', fontSize: 20, color: Colors.white),
        content: TextFieldComponent(
            controller: nameController,
            hintText: 'Enter new Name',
            prefixIcon: Icons.person,
            hintColor: Colors.white,
            iconColor: Colors.white,
            validator: Validator.nameValidator),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: TextComponent(
                  text: 'Cancel', fontSize: 20, color: Colors.red.shade500)),
          TextButton(
              onPressed: () {
                String newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  Get.find<UserController>().updateName(newName);
                  Navigator.pop(context);
                }
              },
              child: TextComponent(
                  text: 'Update', fontSize: 20, color: Colors.green.shade500)),
        ],
      );
    },
  );
}
