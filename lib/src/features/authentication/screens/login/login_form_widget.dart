// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/features/authentication/screens/home/widgets/home_screen.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/controllers/signup_controller.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_Password_Btn_Widget.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_password_model_bottom_sheet.dart';

class logInForm extends StatefulWidget {
  

  logInForm({Key? key}) : super(key: key);

  @override
  State<logInForm> createState() => _logInFormState();
}

class _logInFormState extends State<logInForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                labelText: tPassword,
                hintText: tPassword,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    // Implement logic to toggle password visibility
                  },
                  icon: Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // You can add additional password validation rules here
                return null;
              },
            ),
            SizedBox(height: tFormHeight - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgotPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: Text(tForgotPassword),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // Validation passed, attempt to sign in
                    SignUpController.Instance.signIn(
                      emailController.text.toString(),
                      passwordController.text.toString(),
                    );
                    
                  }
                },
                child: Text(tLogin.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
