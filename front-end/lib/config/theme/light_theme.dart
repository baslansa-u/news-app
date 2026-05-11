import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Muli',
    scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.accentColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.zero,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppConstants.accentColor,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
