import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled/features/player_profile/presentation/widgets/performance_card.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';

class RecentPerformance extends StatelessWidget {
  final List<dynamic>? matches;

  const RecentPerformance({super.key, this.matches});

  @override
  Widget build(BuildContext context) {
    if (matches == null || matches!.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.recentPerformance.toUpperCase(),
            fontSize: 20,
            fontWeight: const FontWeight(590),
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 10),
          Column(
            children: matches!.map((match) {
              final date = match['matchDate'] != null 
                  ? DateTime.parse(match['matchDate']) 
                  : DateTime.now();
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PerformanceCard(
                  date: DateFormat('MMM dd').format(date).toUpperCase(),
                  time: DateFormat('hh:mm a').format(date),
                  homeTeam: match['homeTeam']?['teamName'] ?? 'TBA',
                  awayTeam: match['awayTeam']?['teamName'] ?? 'TBA',
                  homeScore: match['homeScore'] ?? 0,
                  awayScore: match['awayScore'] ?? 0,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
