// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/sizes.dart';

class tOutlinedButtonTheme {
  tOutlinedButtonTheme._();

  //LIGHT THEME
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    foregroundColor: tPrimaryColor,
                    side: BorderSide(color: tPrimaryColor),
                    padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  ), 
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  ), 
  );
}