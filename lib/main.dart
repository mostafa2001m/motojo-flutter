// ignore_for_file: prefer_const_constructors

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:motojo/firebase_options.dart';
import 'package:motojo/src/features/authentication/repository/authentication_repository/authentication_repository.dart';
import 'package:motojo/src/features/authentication/screens/login/login_screen.dart';
import 'package:motojo/src/utils/theme/theme.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
).then((value) => Get.put(AuthenticationRepository()));
await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: Duration(milliseconds: 500),
      home: logIn(),
  //     initialRoute: '/', // Specify the initial route
  // routes: {
  //   '/': (context) => SplashScreen(),
  //   '/login': (context) => loginScreen(),
  //   '/sigunup':(context) => signupScreen(),
  //   '/home':(context) => homeScreen(),
  //   // Add more routes for your screens
  // },
     debugShowCheckedModeBanner: false,
      title: 'My App',
     
     theme: TAppTheme.lightTheme,
     darkTheme: TAppTheme.darkTheme,
    );
  }
}