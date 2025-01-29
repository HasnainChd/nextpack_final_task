import 'package:flutter/material.dart';
import 'package:next_final_task/Pages/login_page.dart';
import 'package:next_final_task/Pages/signup_page.dart';
import 'package:next_final_task/Pages/user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfile(),
    );
  }
}
