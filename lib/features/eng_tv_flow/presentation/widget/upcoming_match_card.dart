import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../../../component/text/common_text.dart'; // Apnar project-er path onujayi

class UpcomingMatchCard extends StatelessWidget {
  final String date;
  final String time;
  final String matchTitle;
  final String coverageTime;
  final VoidCallback onNotificationTap;

  const UpcomingMatchCard({
    super.key,
    required this.date,
    required this.time,
    required this.matchTitle,
    required this.coverageTime,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: date.toUpperCase(),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: time,
                  fontSize: 10.sp,
                  color: AppColors.color6B6B6B,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),

          Container(
            height: 40.h,
            width: 1.5,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            color: Colors.grey.shade200,
          ),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: matchTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.sp,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: CommonText(
                        text: coverageTime,
                        fontSize: 12.sp,
                        color: AppColors.color6B6B6B,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,

              child: GestureDetector(
                onTap: onNotificationTap,
                child: SvgPicture.asset(
                  AppIcons.notificationM,
                  height: 36.h,
                  width: 36.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
