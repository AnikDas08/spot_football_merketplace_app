import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class SeasonSelectorButton extends StatelessWidget {
  final String seasonValue;
  final VoidCallback onTap;
  final String label;

  const SeasonSelectorButton({
    super.key,
    required this.seasonValue,
    required this.onTap,
    this.label = "Season",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: label,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color6B6B6B,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: seasonValue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppIcons.topArrow, width: 12.w, height: 6.h),
                SizedBox(height: 6.h),
                SvgPicture.asset(
                  AppIcons.bottomArrow,
                  width: 12.w,
                  height: 6.w,
                  placeholderBuilder: (BuildContext context) => Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
