import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:next_final_task/Components/custom_snackbar.dart';
import 'package:next_final_task/Controllers/email_verification_controller.dart';
import 'package:next_final_task/Vews/profile/user_profile.dart';
import '../Utils/shared_preferences.dart';
import '../Vews/auth/login_page.dart';

class AuthController extends GetxController {
  //SignUp Controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login Controllers
  var loginEmailController = TextEditingController();
  var loginPasswordController = TextEditingController();

  final EmailVerificationController controller =
      Get.put(EmailVerificationController());

  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  UserCredential? userCredential;

  //sign up method
  Future<void> signUp() async {
    try {
      isLoading.value = true;
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = userCredential!.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'uid': user.uid,
        });
      }

      nameController.clear();
      emailController.clear();
      passwordController.clear();

      await userCredential!.user!.sendEmailVerification();
      CustomSnackBar.successSnackBar(
          'An verification link is send to your email address,'
          'please verify');
      Get.offAll(LoginPage());
    } catch (e) {
      CustomSnackBar.errorSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //login method
  Future<void> login() async {
    isLoading.value = true;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );

      User? user = userCredential?.user;
      if (user != null) {
        if (!user.emailVerified) {
          controller.showVerificationDialog(user);
        } else {
          await SharedPrefHelper.saveUserData(
            user.uid,
            user.email ?? '',
            user.displayName ?? '',
          );
          CustomSnackBar.successSnackBar('Sign-in successful');
          Get.offAll(UserProfile());
        }
        loginEmailController.clear();
        loginPasswordController.clear();
      } else {
        CustomSnackBar.errorSnackBar('User not found');
      }
    } catch (e) {
      debugPrint(e.toString());
      CustomSnackBar.errorSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //sign in with google
  Future<UserCredential?> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleSignIn?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      isLoading.value = false;
      CustomSnackBar.errorSnackBar('something went wrong: ${e.toString()}');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  //sign-out method
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await SharedPrefHelper.clearUserData();
      Get.to(LoginPage());
    } catch (e) {
      CustomSnackBar.errorSnackBar(e.toString());
    }
  }

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
