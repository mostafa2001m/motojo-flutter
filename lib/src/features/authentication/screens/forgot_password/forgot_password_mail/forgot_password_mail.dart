// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/common_widgets/form/form_header_widget.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_OTP/otp_screen.dart';

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                SizedBox(height: tDefaultSize*4,),
                FormHeaderWidget(
                  title: tForgotPassword, 
                  image: tForgotPasswordimg, 
                  subTitle: tForgotPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                  ),
                  SizedBox(height: tFormHeight,),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(tEmail),
                            hintText: tEmail,
                            prefixIcon:Icon(Icons.mail_outline_rounded), 
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: (){
                            Get.to(()=>OTPScreen());
                          }, child: Text("Next")),
                        )
                      ],
                    )
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}