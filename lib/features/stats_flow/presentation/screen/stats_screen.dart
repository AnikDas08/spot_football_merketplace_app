import 'package:eng_sports/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../controller/stats_controller.dart';
import '../widget/player_statcard.dart';
import '../widget/season_stats_button.dart';

class StatsScreen extends StatelessWidget {
  StatsScreen({super.key});
  final StatsController controller = Get.find<StatsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Statistics",
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      fontFamily: 'Montserrat',
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: "2026/27 Top Stats",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.color373737,
                      fontFamily: 'Montserrat',
                    ),
                  ],
                ),

                Obx(
                  () => PopupMenuButton<String>(
                    onSelected: (String value) {
                      controller.updateAge(value);
                    },
                    itemBuilder: (BuildContext context) {
                      return controller.ageOptions.map((String age) {
                        return PopupMenuItem<String>(
                          value: age,
                          child: Text("Under $age"),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: AppColors.colorEABB00,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonText(
                                text: "Under",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              CommonText(
                                text: controller.selectedAge.value,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                AppIcons.topArrow,
                                width: 12.w,
                                height: 6.h,
                              ),
                              SizedBox(height: 6.h),
                              SvgPicture.asset(
                                AppIcons.bottomArrow,
                                width: 12.w,
                                height: 6.w,
                                placeholderBuilder: (BuildContext context) =>
                                    Container(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }

              final data = controller.summaryData.value;
              if (data == null) return const SizedBox.shrink();

              // Top Goal Scorer
              final topScorer = data['topGoalScorer'];
              final String scorerName = topScorer is Map
                  ? "${topScorer['firstName'] ?? ""} ${topScorer['lastName'] ?? ""}"
                        .trim()
                  : "N/A";
              final String scorerGoals = topScorer is Map
                  ? (topScorer['totalGoals']?.toString() ?? "0")
                  : "0";
              final String scorerImage = topScorer is Map
                  ? (topScorer['profile'] ?? "")
                  : "";

              // Top Assist Player
              final topAssist = data['topAssistPlayer'];
              final String assistName = topAssist is Map
                  ? "${topAssist['firstName'] ?? ""} ${topAssist['lastName'] ?? ""}"
                        .trim()
                  : "N/A";
              final String assistCount = topAssist is Map
                  ? (topAssist['totalAssists']?.toString() ?? "0")
                  : "0";
              final String assistImage = topAssist is Map
                  ? (topAssist['profile'] ?? "")
                  : "";

              // Top Goal Team
              final topGoalTeam = data['topGoalTeam'];
              final String goalTeamName = topGoalTeam is Map
                  ? (topGoalTeam['teamName'] ?? "N/A")
                  : "N/A";
              final String goalTeamCount = topGoalTeam is Map
                  ? (topGoalTeam['totalGoals']?.toString() ?? "0")
                  : "0";
              final String goalTeamImage = topGoalTeam is Map
                  ? (topGoalTeam['teamLogo'] ?? "")
                  : "";

              // Top Assist Team
              final topAssistTeam = data['topAssistTeam'];
              final String assistTeamName = topAssistTeam is Map
                  ? (topAssistTeam['teamName'] ?? "N/A")
                  : "N/A";
              final String assistTeamCount = topAssistTeam is Map
                  ? (topAssistTeam['totalAssists']?.toString() ?? "0")
                  : "0";
              final String assistTeamImage = topAssistTeam is Map
                  ? (topAssistTeam['teamLogo'] ?? "")
                  : "";

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PlayerStatCard(
                          playerImageUrl:
                              "assets/images/stats/3CCF78AC-5996-4DEE-A291-FAB18ECB9451.png",
                          playerName: scorerName,
                          statLabel: "TOP SCORER",
                          statValue: scorerGoals,
                        ),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: PlayerStatCard(
                          playerImageUrl:
                              "assets/images/stats/54563295-99D9-4C11-8B3A-8159D5E05850.png",
                          playerName: assistName,
                          statLabel: "ASSISTS",
                          statValue: assistCount,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: PlayerStatCard(
                          playerImageUrl:
                              "assets/images/stats/62DB453E-73F7-4757-97B0-DCFCAB786ECE.png",
                          playerName: goalTeamName,
                          statLabel: "CLEAN SHEETS",
                          statValue: "0", // Placeholder
                        ),
                      ),
                      SizedBox(width: 16.h),
                      Expanded(
                        child: PlayerStatCard(
                          playerImageUrl:
                              "assets/images/stats/98CEEB47-57C4-4639-87E8-C9E6EDEA9CAE.png",
                          playerName: assistTeamName,
                          statLabel: "OVERALL",
                          statValue: "100%", // Placeholder
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            SizedBox(height: 24.h),

            SeasonStatsButton(
              title: "Season Stats",

              onTap: () {
                Get.toNamed(AppRoutes.seasonStatsScreen);
              },
            ),

            SizedBox(height: 16.h),

            SeasonStatsButton(
              title: "Player Comparison",
              onTap: () {
                Get.toNamed(AppRoutes.playerComparisonScreen);
              },
            ),
            40.height
          ],
        ),
      ),
    );
  }
}
