import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/features/home/presentation/widgets/recent_result_card.dart';
import '../../data/match_model.dart';

class RecentResult extends StatelessWidget {
  final List<MatchModel> matches;
  final bool isLoading;

  const RecentResult({
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];

          // Formatting Date and Time
          String formattedDate = match.matchDate != null 
              ? DateFormat('MMM dd').format(match.matchDate!).toUpperCase()
              : 'TBA';
          String formattedTime = match.matchDate != null 
              ? DateFormat('HH:mm a').format(match.matchDate!)
              : '';

          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: RecentResultCard(
              id: match.id, // সঠিক ID পাস করা হলো
              time: formattedTime,
              date: formattedDate,
              homeTeam: match.homeTeam.teamName,
              awayTeam: match.awayTeam.teamName,
              homeScore: match.homeScore,
              awayScore: match.awayScore,
            ),
          );
        },
      ),
    );
  }
}
