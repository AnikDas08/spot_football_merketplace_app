import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/recent_result_card.dart';

import '../../../../utils/constants/app_string.dart';

class RecentResult extends StatelessWidget {
  const RecentResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CommonText(
            text: AppString.recentResult.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: const FontWeight(590),
          ),
          SizedBox(height: 20.h),
          Column(
            spacing: 10,
            crossAxisAlignment: .start,
            children: [
             ...List.generate(6, (index) =>  RecentResultCard(
               time: "20:00 PM",
               date: "OCT 24",
               homeTeam: "Titans SC",
               awayTeam: "Vortex FC",
               homeScore: 1,
               awayScore: 2,
             ),)
            ],
          ),
        ],
      ),
    );
  }
}
