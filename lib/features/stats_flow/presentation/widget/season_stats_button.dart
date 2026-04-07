import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class SeasonStatsButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? title;

  const SeasonStatsButton({super.key, required this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CommonText(
              text: title ?? "Season Stats",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),

            SvgPicture.asset(
              AppIcons.arrowR,
              width: 24.w,
              height: 24.w,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
