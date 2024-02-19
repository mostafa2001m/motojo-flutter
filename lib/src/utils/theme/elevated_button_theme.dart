import 'package:flutter/material.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/sizes.dart';


//--LIGHT AND DARK BUTTON THEMES
class tElevatedButtonTheme {
  tElevatedButtonTheme._();

  //LIGHT THEME
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(),
                    foregroundColor: Colors.white,
                    backgroundColor: tPrimaryColor,
                    side: BorderSide(color: tPrimaryColor),
                    padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  ),  
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: OutlinedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(),
                    foregroundColor: tPrimaryColor,
                    backgroundColor: tSecondaryColor,
                    side: BorderSide(color: tSecondaryColor),
                    padding: EdgeInsets.symmetric(vertical: tButtonHeight),
                  ),  
  );
}