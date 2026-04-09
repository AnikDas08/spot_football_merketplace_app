import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../utils/constants/app_colors.dart';

class PerformanceCard extends StatelessWidget {
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  const PerformanceCard({
    super.key,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.background, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              // Date
              SizedBox(
                width: 70.h,
                child: CommonText(
                  text: date,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),

              // Vertical divider
              Container(
                width: 3.w,
                height: 36.h,
                color: AppColors.colorCCCCCC,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    CommonText(
                      maxLines: 2,
                      text: AppString.vsRangerUnited,
                      fontSize: 14.sp,
                      fontWeight: FontWeight(590),
                      color: AppColors.primaryColor,
                      textAlign: TextAlign.left,
                    ),
                    CommonText(
                      maxLines: 2,
                      text: AppString.premierLeagueAway.toUpperCase(),
                      fontSize: 14.sp,
                      fontWeight: FontWeight(590),
                      color: AppColors.color6B6B6B,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Column(
                spacing: 5,
                children: [
                  Container(
                    padding: .symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: .circular(12.r),
                    ),
                    child: CommonText(
                      text: "9.2",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  CommonText(
                    text: AppString.twoGoal,
                    fontSize: 10.sp,
                    fontWeight: FontWeight(590),
                    color: AppColors.colorEABB00,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
