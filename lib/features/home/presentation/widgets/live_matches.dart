import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/features/home/presentation/widgets/recent_result_card.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/match_model.dart';

class LiveMatches extends StatelessWidget {
  final List<MatchModel> matches;
  final bool isLoading;

  const LiveMatches({
    super.key,
    required this.matches,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: List.generate(1, (index) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: CustomShimmer.rectangular(height: 80.h),
          )),
        ),
      );
    }

    if (matches.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CommonText(
                text: "LIVE MATCHES",
                fontSize: 20.sp,
                fontWeight: const FontWeight(590),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: RecentResultCard(
                  id: match.id,
                  time: "",
                  date: "LIVE",
                  homeTeam: match.homeTeam.teamName,
                  awayTeam: match.awayTeam.teamName,
                  homeScore: match.homeScore,
                  awayScore: match.awayScore,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
