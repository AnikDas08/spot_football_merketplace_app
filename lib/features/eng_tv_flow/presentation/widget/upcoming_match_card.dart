import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';

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
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
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
                  text: date,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: time,
                  fontSize: 10,
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
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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
                        fontSize: 12,
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
