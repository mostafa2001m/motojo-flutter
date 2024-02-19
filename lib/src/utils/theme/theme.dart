//vedio #2 for themes
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motojo/src/utils/theme/elevated_button_theme.dart';
import 'package:motojo/src/utils/theme/outlined_button_theme.dart';
import 'package:motojo/src/utils/theme/widget_theme/text_field_theme.dart';
import 'package:motojo/src/utils/theme/widget_theme/text_theme.dart';
class TAppTheme {
  static ThemeData lightTheme=ThemeData(
    brightness: Brightness.light,
    outlinedButtonTheme: tOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: tElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    );
  static ThemeData darkTheme=ThemeData(
    brightness: Brightness.dark,
    outlinedButtonTheme: tOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: tElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    );
}