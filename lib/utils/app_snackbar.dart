import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success({required String title, required String message}) {
    _showSnackbar(
      title: title,
      message: message,
      backgroundColor: AppColors.black,
      position: SnackPosition.BOTTOM,
      icon: const Icon(Icons.check_circle, color: Color(0xFF19CA77), size: 24),
    );
  }

  static void error({String? title, required String message}) {
    _showSnackbar(
      title: title ?? 'Error',
      message: message,
      backgroundColor: AppColors.black,
      position: SnackPosition.TOP,
      icon: const Icon(Icons.error, color: Color(0xFFEF5350), size: 24),
    );
  }

  static void _showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required SnackPosition position,
    Widget? icon,
  }) {
    Get.rawSnackbar(
      titleText: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
      snackPosition: position,
      backgroundColor: backgroundColor.withValues(alpha: 0.95),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: icon,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      duration: const Duration(seconds: 3),
      barBlur: 10,
      isDismissible: true,
      leftBarIndicatorColor: icon != null ? (icon as Icon).color : null,
    );
  }
}
