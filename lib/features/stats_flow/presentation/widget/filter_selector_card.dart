import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_icons.dart';

class FilterSelectorCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const FilterSelectorCard({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade200),
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
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 2.h),
                CommonText(
                  text: value,
                  fontSize: 13.sp,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(width: 8.w),
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
