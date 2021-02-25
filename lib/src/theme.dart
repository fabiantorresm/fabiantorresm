import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryDarkColor = const Color(0xFF140136);
const primaryLigthColor = const Color(0xFF031393);
const grisClaro = const Color(0xffe0e0e0);
const grisOscuro = const Color(0xff212121);
const white = const Color(0xffffffff);

final themeLigth = ThemeData(
  fontFamily: "Comfortaa",
).copyWith(
  textTheme: GoogleFonts.comfortaaTextTheme(),
  appBarTheme: AppBarTheme(
    elevation: 5,
    shadowColor: primaryDarkColor,
    color: primaryDarkColor,
    textTheme: TextTheme(
      caption: TextStyle(color: primaryDarkColor),
      headline1: TextStyle(color: primaryDarkColor),
      bodyText1: TextStyle(color: primaryDarkColor),
      bodyText2: TextStyle(color: primaryDarkColor),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: grisClaro,
    filled: true,
    labelStyle: TextStyle(
      color: const Color(0xFF263238),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
  ),
  buttonTheme: ButtonThemeData(
      height: 60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      buttonColor: primaryDarkColor,
      highlightColor: primaryDarkColor,
      padding: EdgeInsets.all(16),
      splashColor: primaryLigthColor,
      textTheme: ButtonTextTheme.normal,
      colorScheme: ColorScheme(
          primary: primaryDarkColor,
          onPrimary: primaryLigthColor,
          secondary: primaryDarkColor,
          onSecondary: primaryDarkColor,
          secondaryVariant: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.black,
          onBackground: Colors.black,
          surface: grisOscuro,
          onSurface: grisClaro,
          brightness: Brightness.dark,
          primaryVariant: primaryDarkColor)),
);
