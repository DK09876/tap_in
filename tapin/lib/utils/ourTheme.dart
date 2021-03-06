import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OurTheme {
  ThemeData buildTheme() {
    Color _backgroundColor = Color.fromARGB(255, 50, 50, 50);
    Color _cardColor = Color.fromARGB(255, 255, 254, 250);
    Color _disabledColor = Color.fromARGB(255, 240, 236, 228);
    Color _loginText = Color.fromARGB(255, 148, 144, 141);
    Color _tapinBrown = Color.fromARGB(255, 96, 94, 92);
    Color _tapinDarkGreen = Color.fromARGB(255, 115, 182, 147);
    Color _tapinLightGreen = Color.fromARGB(255, 152, 221, 163);
    Color _buttonsColor = Color.fromARGB(255, 37, 237, 160);
    Color _gradientPink = Color.fromARGB(255, 255, 183, 255);
    Color _gradientYellow = Color.fromARGB(255, 255, 246, 20);
    Color _white = Color.fromARGB(255, 255, 255, 255);

    return ThemeData(
      unselectedWidgetColor: _white,
      primaryColorDark: _buttonsColor,
      canvasColor: _backgroundColor,
      primaryColor: _gradientPink,
      secondaryHeaderColor: _gradientPink,
      accentColor: _gradientPink,
      selectedRowColor: _gradientPink,
      buttonColor: _gradientPink,
      cardColor: _gradientPink,
      disabledColor: _gradientPink,
      textTheme: GoogleFonts.comfortaaTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 96, 94, 92))),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 96, 94, 92)),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 96, 94, 92)),
        ),
      ),
    );
  }
}
