import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Components/edit_dialog.dart';
import 'package:next_final_task/Components/text_component.dart';
import 'package:next_final_task/Controllers/auth_controller.dart';
import 'package:next_final_task/Controllers/user_controller.dart';
import '../../Utils/shared_preferences.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  AuthController authController = AuthController();
  UserController userController = Get.put(UserController());

  Future<void> loadUserData() async {
    Map<String, String?> userData = await SharedPrefHelper.getUserData();
    // print('User ID: ${userData['uid']}');
    // print('Email: ${userData['email']}');
    // print('Name: ${userData['name']}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400,
        actions: [
          TextComponent(
              text: 'User Profile', fontSize: 20, color: Colors.white),
          SizedBox(width: 110),
          IconButton(
              onPressed: () async {
                authController.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
          stream: userController.userStream.value,
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshots.hasData && snapshots.data!.exists) {
              final user = snapshots.data;
              return Column(
                children: [
                  Obx(() => InkWell(
                    onTap: () {
                      userController.pickImage();
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.deepPurple.shade200,
                      backgroundImage: userController.selectedImage.value != null
                          ? FileImage(userController.selectedImage.value!) // Use FileImage
                          : null,
                      child: userController.selectedImage.value == null
                          ? Icon(Icons.camera_alt, color: Colors.white)
                          : null, // Remove icon when an image is selected
                    ),
                  )),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        tileColor: Colors.deepPurple.shade300,
                        title: TextComponent(
                            text: 'Name', fontSize: 20, color: Colors.black),
                        subtitle: TextComponent(
                          color: Colors.white,
                          text: user!['name'],
                          fontSize: 20,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showEditDialog(
                              context,
                              user['name'] ?? "No Name", // Pass current name
                              (newName) {
                                userController
                                    .updateName(newName); // Update Firestore
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.deepPurple.shade300,
                          title: TextComponent(
                              text: 'Email', fontSize: 20, color: Colors.black),
                          subtitle: TextComponent(
                              text: user['email'],
                              fontSize: 20,
                              color: Colors.white)),
                    ],
                  ),
                ],
              );
            }
            return SizedBox();
          }),
    );
  }
}
