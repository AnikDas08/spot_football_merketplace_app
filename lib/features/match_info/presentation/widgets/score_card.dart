import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 240.h,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Live badge
              // Teams + Score row
              Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.color19CA77,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 6,
                      children: [
                        Container(
                          width: 7.w,
                          height: 7.h,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        CommonText(
                          text: "LIVE 74'",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Home team
                      Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              color: AppColors.color3F3F3,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.asset(TempImage.titanFlag),
                          ),
                          SizedBox(height: 6.h),
                          CommonText(
                            text: "TITANS FC",
                            fontSize: 13.sp,
                            fontWeight: FontWeight(590),
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),

                      // Score
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 6,
                        children: [
                          CommonText(
                            text: "2",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: ":",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                          CommonText(
                            text: "1",
                            fontSize: 42.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),

                      // Away team
                      Column(
                        children: [
                          Container(
                            width: 72.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              color: AppColors.color3F3F3,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Image.asset(TempImage.phoenixFlag),
                          ),
                          SizedBox(height: 6.h),
                          CommonText(
                            text: "PHOENIX\nUTDS",
                            fontSize: 13.sp,
                            fontWeight: FontWeight(590),
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Venue + Attendance row
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          padding: EdgeInsets.all(4),

                          decoration: BoxDecoration(
                            color: AppColors.color373737,
                            borderRadius: .circular(2.r),
                          ),
                          child: Image.asset(AppIcons.arenaIcon),
                        ),
                        CommonText(
                          text: AppString.theApexArenaVancouver,
                          fontSize: 12.sp,
                          fontWeight: FontWeight(510),
                          color: AppColors.primaryColor,
                        ),
                      ],
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
