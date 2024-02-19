// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unrelated_type_equality_checks, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/screens/signup_screen.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/login/login_screen.dart';
import 'package:motojo/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context);
    var height=MediaQuery.of(context).size.height;
    var brightness=mediaQuery.platformBrightness;
    final isDarkMode=brightness==Brightness.dark;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(tWelcomeScreenImage),height: height*0.6,),
            Column(
              children: [
                Text(tWelcomeTitle,style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),
                Text(tWelcomeSubTitle,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),
              ],
            ),
            
            Row(
              children: [
                Expanded(child: OutlinedButton(
                  onPressed: (){ Get.to(()=>logIn());},
                  
                  child: Text(tLogin.toUpperCase())
                  )
                  ),
                SizedBox(width: 10,),
                Expanded(child: ElevatedButton(
                  onPressed: (){Get.to(()=>SignUpScreen());}, 
                  
                  child: Text(tSignup.toUpperCase()))),
              ],
            )
          ],
        ),
      ),
    );
  }
}