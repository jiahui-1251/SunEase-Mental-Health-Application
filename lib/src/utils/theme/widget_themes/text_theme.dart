import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {

  static TextTheme lightTextTheme = TextTheme(
          titleLarge: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
          titleMedium: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          titleSmall: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodyLarge: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
          labelLarge: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          headlineSmall: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w100,
            fontSize: 14,
          ),          
        );
}