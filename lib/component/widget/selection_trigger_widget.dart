import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class SelectionTriggerWidget extends StatelessWidget {
  final String? label;
  final String value;
  final VoidCallback onTap;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final Widget? prefixIcon;
  final double? height;

  const SelectionTriggerWidget({
    super.key,
    this.label,
    required this.value,
    required this.onTap,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.prefixIcon,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          CommonText(
            text: label!,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            bottom: 8,
          ),
        ],
        InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: fillColor ?? Colors.white,
              borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
              border: Border.all(color: borderColor ?? AppColors.colorEABB00),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: value.contains("Select") ? Colors.grey : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
