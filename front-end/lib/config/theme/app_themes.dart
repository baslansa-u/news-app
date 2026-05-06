import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_constants.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    fontFamily: 'Muli',
    primaryColor: AppConstants.textPrimary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppConstants.accentColor,
      primary: AppConstants.textPrimary,
      secondary: AppConstants.accentColor,
      background: AppConstants.backgroundColor,
      surface: AppConstants.surfaceColor,
      error: AppConstants.errorColor,
    ),
    appBarTheme: _appBarTheme(),
    floatingActionButtonTheme: _fabTheme(),
    cardTheme: _cardTheme(),
    textTheme: _textTheme(),
    iconTheme: const IconThemeData(color: AppConstants.textPrimary),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    backgroundColor: AppConstants.surfaceColor,
    foregroundColor: AppConstants.textPrimary,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppConstants.textPrimary),
    titleTextStyle: const TextStyle(
      fontSize: AppConstants.fontSizeXLarge,
      fontWeight: FontWeight.w700,
      color: AppConstants.textPrimary,
    ),
  );
}

FloatingActionButtonThemeData _fabTheme() {
  return FloatingActionButtonThemeData(
    backgroundColor: AppConstants.accentColor,
    foregroundColor: AppConstants.surfaceColor,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
    ),
  );
}

CardTheme _cardTheme() {
  return CardTheme(
    color: AppConstants.surfaceColor,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
    ),
    margin: EdgeInsets.zero,
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(
      fontSize: AppConstants.fontSizeLarge,
      fontWeight: FontWeight.w700,
      color: AppConstants.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: AppConstants.fontSizeRegular,
      fontWeight: FontWeight.w400,
      color: AppConstants.textPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: AppConstants.fontSizeSmall,
      fontWeight: FontWeight.w400,
      color: AppConstants.textSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: AppConstants.fontSizeSmall,
      fontWeight: FontWeight.w500,
      color: AppConstants.textSecondary,
    ),
  );
}
