import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/player_profile/presentation/widgets/performance_card.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';

class RecentPerformance extends StatelessWidget {
  const RecentPerformance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .all(16),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          CommonText(
            text: AppString.recentPerformance.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: FontWeight(590),
            color: AppColors.primaryColor,
          ),
          Column(
            spacing: 10,
            children: [
              PerformanceCard(
                date: AppString.oct12,
                homeTeam: AppString.titansSc,
                awayTeam: AppString.arsenal,
                homeScore: 2,
                awayScore: 4,
                time: "2:00 pm",
              ),
              PerformanceCard(
                date: AppString.oct12,
                homeTeam: AppString.titansSc,
                awayTeam: AppString.arsenal,
                homeScore: 2,
                awayScore: 4,
                time: "2:00 pm",
              ),
              PerformanceCard(
                date: AppString.oct12,
                homeTeam: AppString.titansSc,
                awayTeam: AppString.arsenal,
                homeScore: 2,
                awayScore: 4,
                time: "2:00 pm",
              ),
              PerformanceCard(
                date: AppString.oct12,
                homeTeam: AppString.titansSc,
                awayTeam: AppString.arsenal,
                homeScore: 2,
                awayScore: 4,
                time: "2:00 pm",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
