import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class HomeTheme {
  static ThemeData homeData() {
    ThemeData data = ThemeData(
      primaryColor: Color(0xfff5f6fa),
      primaryColorDark: Color(0xfff5f6fa),
      accentColor: Color(0xff4cd137),
      textTheme: TextTheme(
        title: GoogleFonts.playball(
          color: Color(0xff2f3640),
          fontSize: 24,
        ),
        button: GoogleFonts.playball(
          color: Color(0xff2f3640),
          fontSize: 20,
        ),
        body1: GoogleFonts.playfairDisplay(
          color: Color(0xff2f3640),
          fontSize: 20,
        ),
        body2: GoogleFonts.playfairDisplay(
          color: Color(0xff2f3640),
          fontSize: 18,
        ),
        headline: GoogleFonts.playfairDisplay(
          color: Color(0xff2f3640),
          fontSize: 28,
        ),
        caption: GoogleFonts.playfairDisplay(
          color: Color(0xff2f3640),
          fontSize: 15,
        ),
      ),
    );

    return data;
  }
}
