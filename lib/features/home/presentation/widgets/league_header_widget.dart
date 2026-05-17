import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';

class LeagueHeaderWidget extends StatelessWidget {
  const LeagueHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff8E7BFF), Color(0xffFF6EC7)],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              TempImage.league,
              width: 88.w,
              height: 88.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: 'PHOENIX UTDS',
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.white.withValues(alpha: 0.8),
                      size: 20.r,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: CommonText(
                        text: 'The writes, founded 1902',
                        fontSize: 18.sp,
                        color: AppColors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}