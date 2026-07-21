import 'package:eng_sports/features/home/presentation/widgets/recent_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../data/match_model.dart';

class LiveMatches extends StatelessWidget {
  final List<MatchModel> matches;
  final bool isLoading;
  final Color? titleColor;

  const LiveMatches({
    super.key,
    required this.matches,
    this.isLoading = false,
    this.titleColor,
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
          CommonText(
            text: "LIVE MATCHES",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: titleColor,
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
                  homeLogo: match.homeTeam.teamLogo,
                  awayLogo: match.awayTeam.teamLogo,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
