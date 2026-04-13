import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart'; // Adjust path
import '../text/common_text.dart'; // Adjust path

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String titleText;
  final Color titleColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const CommonButton({
    super.key,
    required this.onTap,
    required this.titleText,
    this.titleColor = Colors.white,
    this.buttonColor,
    this.titleSize = 14,
    this.buttonRadius = 10,
    this.titleWeight = FontWeight.w700,
    this.buttonHeight = 48, // Default height
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity, // Default full width thakbe
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth?.w,
      height: buttonHeight.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : (onTap ?? () {}),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? AppColors.primaryColor,
          foregroundColor: titleColor,
          elevation: 0,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.h,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : CommonText(
          text: titleText,
          color: titleColor,
          fontSize: titleSize,
          fontWeight: titleWeight,
        ),
      ),
    );
  }
}