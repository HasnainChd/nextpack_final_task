import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  Rx<Stream<DocumentSnapshot>?> userStream =
      Rx<Stream<DocumentSnapshot>?>(null);
  User? currentUser = FirebaseAuth.instance.currentUser;

  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    if (currentUser != null) {
      if (kDebugMode) {
        print("Logged-in User UID: ${currentUser!.uid}");
      } // Debugging
      userStream.value = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .snapshots();
    }
    super.onInit();
  }

  Future<void> updateName(String newName) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(currentUser!.uid)
        .update({'name': newName});
  }

  Future<void> pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      selectedImage.value = File(file.path);
    }
  }
}
