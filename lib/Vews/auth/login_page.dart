import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Components/button_component.dart';
import 'package:next_final_task/Components/custom_snackbar.dart';
import 'package:next_final_task/Components/text_component.dart';
import 'package:next_final_task/Components/textfield_component.dart';
import 'package:next_final_task/Components/validators.dart';
import 'package:next_final_task/Controllers/auth_controller.dart';
import 'package:next_final_task/Vews/auth/signup_page.dart';
import 'package:next_final_task/Vews/profile/user_profile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final authController = Get.put(AuthController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //bg image
            Image.asset('assets/bg_image.png'),
            //illustration
            Positioned(
              top: 15,
              right: 0,
              child: Image.asset('assets/login_Illustration.png'),
            ),
            //Form
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.3),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //header text 1
                        Align(
                          alignment: Alignment.center,
                          child: TextComponent(
                            text: 'Welcome Back',
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //header text2
                        Align(
                          alignment: Alignment.center,
                          child: TextComponent(
                            text: 'Welcome back we missed you',
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(height: 30),

                        //email title
                        TextComponent(
                          text: 'Email Address',
                          fontSize: 15,
                          color: Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                        //email Field
                        TextFieldComponent(
                          controller: authController.loginEmailController,
                          hintText: 'yourname@gmail.com',
                          hintColor: Colors.white54,
                          prefixIcon: Icons.email_outlined,
                          iconColor: Colors.white54,
                          validator: Validator.emailValidator,
                        ),
                        SizedBox(height: 20),
                        // title password
                        TextComponent(
                          text: 'Password',
                          fontSize: 15,
                          color: Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                        //password textField
                        Obx(
                          () => TextFieldComponent(
                            controller: authController.loginPasswordController,
                            obscureText:
                                !authController.isPasswordVisible.value,
                            hintText: 'password',
                            hintColor: Colors.white54,
                            prefixIcon: Icons.key,
                            iconColor: Colors.white54,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  authController.togglePassword();
                                },
                                icon: Icon(
                                  authController.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                )),
                            validator: Validator.passwordValidator,
                          ),
                        ),
                        SizedBox(height: 30),
                        ButtonComponent(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await authController.login();
                              } else {
                                //show a error snack-bar
                                CustomSnackBar.errorSnackBar(
                                    'please Fill require Fields');
                              }
                            },
                            text: 'Login'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                                text: 'Not registered yet?',
                                fontSize: 16,
                                color: Colors.white54),
                            TextButton(
                                onPressed: () {
                                  Get.offAll(SignUpPage());
                                },
                                child: Text('SignUp ')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                              text: 'or Continue With',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white54,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final result =
                                  await authController.signInWithGoogle();
                              if (kDebugMode) {
                                print(result!.user!.email);
                              }
                              CustomSnackBar.successSnackBar(
                                  'login Successful');
                              Get.offAll(UserProfile());
                            },
                            child: Obx(
                              ()=> authController.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Image.asset('assets/google_image.png',
                                      height: 30),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
