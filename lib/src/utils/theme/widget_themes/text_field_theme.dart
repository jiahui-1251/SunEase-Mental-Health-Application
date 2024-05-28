import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = 
    const InputDecorationTheme(

      border: OutlineInputBorder(),
      prefixIconColor: tOrangeColor,
      floatingLabelStyle: TextStyle(color: tBlackColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: tOrangeColor),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
      );
}