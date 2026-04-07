import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';

import '../../../../utils/constants/app_colors.dart';

class RecentResultCard extends StatelessWidget {
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  const RecentResultCard({
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

            // Score pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CommonText(
                text: '$homeScore - $awayScore',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),

            const SizedBox(width: 12),

            // Away team name
            Expanded(
              child: CommonText(
                maxLines: 2,
                text: awayTeam.toUpperCase(),
                fontSize: 14.sp,
                fontWeight: FontWeight(590),
                color: AppColors.primaryColor,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
