import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:next_final_task/Vews/profile/user_profile.dart';
import 'package:next_final_task/firebase_options.dart';
import 'Vews/auth/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({super.key, required this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? UserProfile() : SignUpPage(),
    );
  }
}
