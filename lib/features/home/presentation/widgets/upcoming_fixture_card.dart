import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../utils/constants/app_colors.dart';

class UpcomingFixtureCard extends StatelessWidget {
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;

  const UpcomingFixtureCard({
    super.key,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Column(
                children: [
                  CommonText(
                    text: date,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                  CommonText(
                    text: time,
                    fontSize: 10.sp,
                    fontWeight: FontWeight(510),
                    color: AppColors.textSecondaryColor,
                  ),
                ],
              ),
            ),

            // Vertical divider
            Container(
              width: 3.w,
              height: 36.h,
              color: AppColors.colorCCCCCC,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),

            // Home team name
            Expanded(
              child: CommonText(
                maxLines: 2,
                text: homeTeam.toUpperCase(),
                fontSize: 14.sp,
                fontWeight: FontWeight(590),
                color: AppColors.primaryColor,
                textAlign: TextAlign.left,
              ),
            ),

            const SizedBox(width: 12),
            CommonText(
              textAlign: .left,
              text: AppString.vs,
              fontSize: 10.sp,
              fontWeight: FontWeight(590),
            ),

            const SizedBox(width: 20),

            // Away team name
            Expanded(
              child: CommonText(
                maxLines: 2,
                text: awayTeam.toUpperCase(),
                fontSize: 14.sp,
                fontWeight: FontWeight(590),
                color: AppColors.primaryColor,
                textAlign: TextAlign.left,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: .symmetric(horizontal: 16),
                padding: .all(8),
                width: 35.w,
                height: 32.h,
                decoration: BoxDecoration(
                  borderRadius: .circular(4.r),
                  color: AppColors.primaryColor,
                ),
                child: SvgPicture.asset(
                  AppIcons.ticket,
                  width: 13.33.w,
                  height: 10.67.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
