import 'package:flutter/material.dart';
import 'package:fyp/src/constants/colors.dart';
import 'package:fyp/src/constants/sizes.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      //shape：RoundedRectangleBorder(),
      foregroundColor: tWhiteColor,
      backgroundColor: tBlackColor,
      side:BorderSide(color: tBlackColor),
      padding: EdgeInsets.symmetric(vertical: tButtonHeight),
    ),
  );
}