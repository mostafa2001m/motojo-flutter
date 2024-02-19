// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:motojo/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  static const String screenRoute = 'splash_screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
      super.initState();
      // Delayed navigation after 3 seconds (adjust the duration as needed).
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => loginScreen(), // Replace MainScreen with your desired screen.
          ),
        );
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/splash_logoo.gif'), // Replace with your actual GIF path.
          ],
        ),
      ),
    );
  }
}
