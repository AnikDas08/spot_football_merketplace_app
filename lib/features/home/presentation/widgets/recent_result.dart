import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/recent_result_card.dart';
import '../../../../utils/constants/app_string.dart';

class RecentResult extends StatelessWidget {
  final String time;
  final String date;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  const RecentResult({
    super.key,
    required this.time,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.recentResult.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: const FontWeight(590),
          ),
          SizedBox(height: 16.h),

          RecentResultCard(
            time: time,
            date: date,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            homeScore: homeScore,
            awayScore: awayScore,
          ),
        ],
      ),
    );
  }
}