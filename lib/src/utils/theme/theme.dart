import 'package:flutter/material.dart';
import 'package:fyp/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:fyp/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:fyp/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {

  //making constructor as private
  TAppTheme._(); 

  static ThemeData lightTheme = ThemeData (
        brightness: Brightness.light,
        textTheme: TTextTheme.lightTextTheme,
        outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
        elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
        // elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
        primarySwatch: MaterialColor(0xFFFFE200, <int, Color> {
          50: Color(0XFFFFF3E0),
          100: Color(0xFFFFE0B2),
          200: Color(0XFFFFCC80),
          300: Color(0XFFFFB74D),
          400: Color(0XFFFFA726),
          500: Color(0XFFFF9800),
          600: Color(0XFFFB8C00),
          700: Color(0XFFF57C00),
          800: Color(0XFFEF6C00),
          900: Color(0XFFE65100),
        })
      );
}