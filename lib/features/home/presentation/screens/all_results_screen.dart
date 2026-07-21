import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../utils/constants/app_colors.dart';
import '../controllers/club_profile_controller.dart';
import 'package:intl/intl.dart';

import '../widgets/recent_result_card.dart';

class AllResultsScreen extends StatelessWidget {
  const AllResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClubProfileController>();
    final dynamic args = Get.arguments;
    final String title = (args is Map && args.containsKey('title')) 
        ? args['title'] 
        : "RECENT RESULTS";

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: title.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.recentMatches.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.recentMatches.isEmpty) {
          return const Center(child: Text("No results available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchMatches(),
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.recentMatches.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final match = controller.recentMatches[index];
              String formattedDate = match.matchDate != null 
                  ? DateFormat('MMM dd').format(match.matchDate!).toUpperCase()
                  : 'TBA';
              String formattedTime = match.matchDate != null 
                  ? DateFormat('HH:mm a').format(match.matchDate!)
                  : '';

              return BlurReveal(
                duration: const Duration(milliseconds: 500),
                initialBlur: 5,
                child: RecentResultCard(
                  id: match.id,
                  time: formattedTime,
                  date: formattedDate,
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
        );
      }),
    );
  }
}
