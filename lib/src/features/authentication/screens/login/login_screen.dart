// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:motojo/src/features/authentication/screens/login/login_foteer_widget.dart';
import 'package:motojo/src/features/authentication/screens/login/login_header_widget.dart';

class logIn extends StatelessWidget {
  const logIn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loginHeaderWidget(size: size),
                logInForm(),
                loginFoteerWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

