import 'package:flutter/material.dart';
import 'package:next_final_task/Components/button_component.dart';
import 'package:next_final_task/Components/text_component.dart';
import 'package:next_final_task/Components/textfield_component.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              margin: EdgeInsets.only(top: 260),
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
                        controller: emailController,
                        hintText: 'yourname@gmail.com',
                        hintColor: Colors.white54,
                        iconData: Icons.email_outlined,
                        iconColor: Colors.white54,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter you email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
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
                      TextFieldComponent(
                        controller: passwordController,
                        hintText: 'password',
                        hintColor: Colors.white54,
                        iconData: Icons.key,
                        iconColor: Colors.white54,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter you password';
                          }
                          if (value.length < 6) {
                            return 'password must be at least 6 character';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'please enter a strong password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ButtonComponent(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //form is correct
                            } else {
                              //show a error snackbar
                            }
                          },
                          text: 'Login'),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextComponent(
                            text: 'or Continue With',
                            fontSize: 15,
                            color: Colors.white54,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: InkWell(

                          onTap: () {},
                          child: Image.asset('assets/google_image.png',
                              height: 30),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
