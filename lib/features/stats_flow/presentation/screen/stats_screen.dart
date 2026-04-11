import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/temp_image.dart';
import '../widget/player_statcard.dart';
import '../widget/season_stats_button.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(title: 'STATS'),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
        child: SingleChildScrollView(
          physics:  ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "Statistics",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 8.h),

              CommonText(
                text: "2024/25 Top Stats",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),

              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: PlayerStatCard(
                      playerImageUrl: TempImage.stats1,
                      statLabel: "Goals",
                      statValue: "21",
                    ),
                  ),
                  SizedBox(width: 16.h),

                  Expanded(
                    child: PlayerStatCard(
                      playerImageUrl: TempImage.stats2,
                      statLabel: "Most Assists",
                      statValue: "8",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: PlayerStatCard(
                      playerImageUrl: TempImage.stats3,
                      statLabel: "Goals",
                      statValue: "65",
                    ),
                  ),
                  SizedBox(width: 16.h),

                  Expanded(
                    child: PlayerStatCard(
                      playerImageUrl: TempImage.stats4,
                      statLabel: "Clean Sheets",
                      statValue: "120",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              SeasonStatsButton(
                title: "Season Stats",

                onTap: () {
                  Get.toNamed(AppRoutes.seasonStatsScreen);
                },
              ),

              SizedBox(height: 16.h),

              SeasonStatsButton(title: "Player Comparison", onTap: () {
                Get.toNamed(AppRoutes.playerComparisonScreen);


              }),
            ],
          ),
        ),
      ),
    );
  }
}
