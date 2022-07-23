import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  // static final _darkTheme = ThemeData();

  static _themeData(ColorScheme colorScheme) => ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.nunitoTextTheme(
          _textTheme(colorScheme),
        ),
      );

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.lightBlue,
    secondary: AppColors.deep,
    onBackground: AppColors.dark,
    onSurface: AppColors.icon,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headline1: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w300,
          color: colorScheme.onBackground,
        ),
        headline2: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
        ),
        headline3: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: colorScheme.onBackground,
        ),
        headline4: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
        ),
        headline5: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colorScheme.onBackground,
        ),
        headline6: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onBackground,
        ),
        overline: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.primary,
        ),
        subtitle1: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: colorScheme.onBackground),
        subtitle2: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: colorScheme.onBackground,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onBackground,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.primary,
        ),
        button: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      );
}
