import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';

import '../../../../component/image/common_image.dart';

class UpcomingFixtureCard extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final String? homeLogo;
  final String? awayLogo;
  final String? venue;
  final double? width;
  final bool isDark;

  const UpcomingFixtureCard({
    super.key,
    required this.id,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
    this.homeLogo,
    this.awayLogo,
    this.venue,
    this.width,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.matchInfo,
          arguments: {'id': id, 'isUpcoming': true, 'time': time},
        );
      },
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.color2A2A2A : AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.colorEABB00, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.3) : AppColors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: .spaceBetween,
            children: [
              /// Date Header
              CommonText(
                text: date,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : AppColors.black,
                bottom: 16.h,
                fontFamily: 'Montserrat',
              ),

              Row(
                children: [
                  /// Home Team
                  Expanded(
                    child: Column(
                      children: [
                        CommonImage(
                          imageSrc: homeLogo ?? "",
                          height: 48.h,
                          width: 48.w,
                          fill: BoxFit.contain,
                        ),
                        SizedBox(height: 8.h),
                        CommonText(
                          text: homeTeam,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: isDark ? Colors.white : AppColors.black,
                        ),
                      ],
                    ),
                  ),

                  /// Time / VS
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black.withValues(alpha: 0.5) : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
                    ),
                    child: CommonText(
                      text: time,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : AppColors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  /// Away Team
                  Expanded(
                    child: Column(
                      children: [
                        CommonImage(
                          imageSrc: awayLogo ?? "",
                          height: 48.h,
                          width: 48.w,
                          fill: BoxFit.contain,
                        ),
                        SizedBox(height: 8.h),
                        CommonText(
                          text: awayTeam,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: isDark ? Colors.white : AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (venue != null && venue!.isNotEmpty) ...[
                SizedBox(height: 12.h),
                CommonText(
                  text: venue!,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white70 : Colors.grey,
                  maxLines: 1,
                ),
              ],

              SizedBox(height: 16.h),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionBtn(
                      "Match Info",
                      isDark ? AppColors.yellow : AppColors.primaryColor,
                      isDark ? AppColors.black : AppColors.white,
                      !isDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildActionBtn(
    String title,
    Color bg,
    Color textCol,
    bool hasBorder,
  ) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: hasBorder ? Border.all(color: AppColors.colorEABB00) : null,
      ),
      alignment: Alignment.center,
      child: CommonText(
        text: title,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textCol,
      ),
    );
  }
}
