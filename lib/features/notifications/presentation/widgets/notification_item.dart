import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final String alertType;
  final String timeAgo;
  final String title;
  final String subtitle;
  final Color color;
  final String iconImage;
  final VoidCallback? onViewDetails;

  const NotificationCard({
    super.key,
    required this.alertType,
    required this.timeAgo,
    required this.title,
    required this.subtitle,
    this.onViewDetails,
    required this.color,
    required this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 4.w),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon box
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: SvgPicture.asset(iconImage)),
            ),

            SizedBox(width: 12.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CommonText(
                        text: alertType,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: .circular(100.r),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      CommonText(
                        text: timeAgo,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    textAlign: .start,
                    maxLines: 2,
                    text: title,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    maxLines: 2,
                    text: subtitle,
                    textAlign: .start,
                    fontSize: 12.sp,
                    fontWeight: FontWeight(510),
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // View Details
            InkWell(
              onTap: onViewDetails,
              child: CommonText(
                maxLines: 2,
                text: 'VIEW\nDETAILS',
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
