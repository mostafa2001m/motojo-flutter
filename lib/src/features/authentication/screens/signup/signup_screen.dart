// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/common_widgets/form/form_header_widget.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/login/login_screen.dart';
import 'package:motojo/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              FormHeaderWidget(title: tSignUpTitle, image: tWelcomeScreenImage, subTitle: tSignUpSubTitle),
              SignUpFormWidget(),
              Column(
                children: [
                  Text("OR"),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(onPressed: (){}, 
                    icon: Image(image: AssetImage(tGoogleLogoImage),width: 20.0,), 
                    label: Text(tSignInWithGoogle)
                    ),
                  ),
                  TextButton(onPressed: (){Get.to(()=>logIn());}, 
                  child: Text.rich(
                    TextSpan(
                    children:[
                      TextSpan(text: tAlreadyHaveAnAccount,style: Theme.of(context).textTheme.bodyText1),
                      TextSpan(text: tLogin.toUpperCase(),style: TextStyle(color: tPrimaryColor))
                    ]
                  )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

