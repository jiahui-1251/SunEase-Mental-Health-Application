import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final lightElevatedButtonTheme =ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      //shape：RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      backgroundColor: tBlackColor,
      side:BorderSide(color: tBlackColor),
      //side:BorderSide(color: tSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );
}