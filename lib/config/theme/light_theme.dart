import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  fontFamily: 'SFProDisplay',        // ✅ Global Font Set
  useMaterial3: true,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  hoverColor: AppColors.transparent,

  /// AppBar Theme
  appBarTheme: const AppBarTheme(
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    backgroundColor: AppColors.background,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'SFProDisplay',     // ✅ SF Pro AppBar Title
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  ),

  /// Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      maximumSize: const Size(double.infinity, 48),
      minimumSize: const Size(double.infinity, 48),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      textStyle: const TextStyle(
        fontFamily: 'SFProDisplay',     // ✅ Button Text
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  /// Text Theme — All Using SF Pro Display
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'SFProDisplay',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  ),
);