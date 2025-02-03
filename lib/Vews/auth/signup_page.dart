import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_final_task/Components/button_component.dart';
import 'package:next_final_task/Components/custom_snackbar.dart';
import 'package:next_final_task/Components/text_component.dart';
import 'package:next_final_task/Components/textfield_component.dart';
import 'package:next_final_task/Components/validators.dart';
import 'package:next_final_task/Controllers/auth_controller.dart';
import 'package:next_final_task/Vews/auth/login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final authController = Get.put(AuthController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //bg image
            Image.asset('assets/bg_image.png'),
            //illustration
            Positioned(
              top: 15,
              right: 0,
              child: Image.asset('assets/sign_up_ilustration.png'),
            ),
            //Form
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //header text 1
                        Align(
                          alignment: Alignment.center,
                          child: TextComponent(
                            text: 'Get Started Free',
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //header text2
                        Align(
                          alignment: Alignment.center,
                          child: TextComponent(
                            text: 'Free Forever No Credit card Needed',
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
                          controller: authController.emailController,
                          hintText: 'yourname@gmail.com',
                          hintColor: Colors.white54,
                          prefixIcon: Icons.email_outlined,
                          iconColor: Colors.white54,
                          validator: Validator.emailValidator,
                        ),
                        SizedBox(height: 20),
                        //title name
                        TextComponent(
                          text: 'Your Name',
                          fontSize: 15,
                          color: Colors.white54,
                          fontWeight: FontWeight.w600,
                        ),
                        //name textField
                        TextFieldComponent(
                          controller: authController.nameController,
                          hintText: '@yourname',
                          hintColor: Colors.white54,
                          prefixIcon: Icons.person_outlined,
                          iconColor: Colors.white54,
                          validator: Validator.nameValidator,
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
                            controller: authController.passwordController,
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
                                //form is valid submit
                                await authController.signUp();
                              } else {
                                //show a error snack-bar
                                CustomSnackBar.errorSnackBar(
                                    'please fill the required fields correctly');
                              }
                            },
                            text: 'SignUp'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                                text: 'Already have an account?',
                                fontSize: 16,
                                color: Colors.white54),
                            TextButton(
                                onPressed: () {
                                  Get.offAll(LoginPage());
                                },
                                child: Text('Login')),
                          ],
                        ),
                        Center(
                          child: TextComponent(
                            text: 'or SignUp With',
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        ),
                        SizedBox(height: 20),
                        //showing other authentication methods(images)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google_image.png', height: 20),
                            SizedBox(width: 20),
                            Image.asset('assets/apple_image.png', height: 20),
                            SizedBox(width: 20),
                            Image.asset('assets/facebook_image.png', height: 20)
                          ],
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
