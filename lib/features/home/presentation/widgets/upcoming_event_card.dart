import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 415.h,
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(21),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CommonImage(
                  imageSrc: TempImage.upcomingEvent,
                  width: double.infinity,
                  height: 270.h,
                  fill: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CommonText(
                    text: AppString.limitedSlots,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),

          CommonText(
            text: AppString.summerFootballTournament2026,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
          CommonText(
            text: AppString.ageGroupUnder12_16,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: CommonText(
              text: AppString.viewDetails,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
