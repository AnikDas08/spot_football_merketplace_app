import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import '../controller/seasson_stats_controller.dart';
import '../model/season_leaderboard_model.dart';
import '../widget/leader_boad_card.dart';
import '../widget/season_selector_button.dart';

class SeasonStatsScreen extends StatelessWidget {
  const SeasonStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SeassonStatsController controller = Get.put(SeassonStatsController());

    return Scaffold(
      appBar: SecondaryAppBar(title: 'Season stats'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              Obx(() => SeasonSelectorButton(
                    seasonValue: controller.selectedSeason.value,
                    onTap: () {
                      controller.chooseSeason(context);
                    },
                  )),
              SizedBox(height: 24.h),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor));
                }

                final data = controller.leaderboardData.value;
                if (data == null) {
                  return const Center(child: CommonText(text: "No data available"));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.goal != null && data.goal!.isNotEmpty) ...[
                      CommonText(
                        text: "goals".toUpperCase(),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 16.h),
                      _buildLeaderboardCard(data.goal!),
                      SizedBox(height: 28.h),
                    ],
                    if (data.assist != null && data.assist!.isNotEmpty) ...[
                      CommonText(
                        text: "Most Assists".toUpperCase(),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 16.h),
                      _buildLeaderboardCard(data.assist!),
                      SizedBox(height: 20.h),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard(List<LeaderboardEntry> entries) {
    final topPlayer = entries.first;
    final otherPlayers = entries.skip(1).map((e) {
      return LeaderboardItemData(
        rank: e.rank.toString(),
        name: e.fullName,
        academy: "Academy", // API doesn't seem to provide academy name in leaderboard
        score: e.totalCount.toString(),
        academyPhoto: TempImage.stats3, // Placeholder
        playerImage: e.profile,
      );
    }).toList();

    return LeaderboardCard(
      topPlayerName: topPlayer.fullName,
      topPlayerAcademy: "Academy", // Placeholder
      topPlayerScore: topPlayer.totalCount.toString(),
      topPlayerImage: topPlayer.profile,
      academyPhoto: TempImage.stats3,
      otherPlayers: otherPlayers,
      onViewFullList: () {},
    );
  }
}
