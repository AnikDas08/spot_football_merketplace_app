import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';

class ScoreCard extends StatelessWidget {
  final String homeTeam;
  final String? homeLogo;
  final String awayTeam;
  final String? awayLogo;
  final String homeScore;
  final String awayScore;
  final String status;
  final bool isLive;
  final String venue;

  const ScoreCard({
    super.key,
    required this.homeTeam,
    this.homeLogo,
    required this.awayTeam,
    this.awayLogo,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.isLive,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 240.h,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status Badge
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: isLive ? AppColors.color19CA77 : AppColors.background,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLive)
                        Container(
                          width: 7.w,
                          height: 7.h,
                          margin: EdgeInsets.only(right: 6.w),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      CommonText(
                        text: status,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: isLive ? AppColors.white : AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              // Score Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Home Team
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.clubProfileScreen);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.h,
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.color3F3F3,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: CommonImage(
                              imageSrc: homeLogo ?? '',
                              fill: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: homeTeam.toUpperCase(),
                            fontSize: 13.sp,
                            fontWeight: const FontWeight(590),
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Score
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonText(
                          text: homeScore,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: CommonText(
                            text: ":",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        CommonText(
                          text: awayScore,
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),

                  // Away Team
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.clubProfileScreen);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.h,
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.color3F3F3,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: CommonImage(
                              imageSrc: awayLogo ?? '',
                              fill: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: awayTeam.toUpperCase(),
                            fontSize: 13.sp,
                            fontWeight: const FontWeight(590),
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Venue Info
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.w,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.color373737,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: Image.asset(AppIcons.arenaIcon),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: CommonText(
                              text: venue,
                              fontSize: 12.sp,
                              fontWeight: const FontWeight(510),
                              color: AppColors.primaryColor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CommonText(
                      text: AppString.attendance,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorEABB00,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
