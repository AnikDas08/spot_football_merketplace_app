import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/stats_flow/presentation/controller/stats_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/temp_image.dart';
import '../widget/player_statcard.dart';
import '../widget/season_stats_button.dart';

class StatsScreen extends StatelessWidget {
   StatsScreen({super.key});
  final StatsController controller = Get.find<StatsController>();

  @override
  Widget build(BuildContext context) {
    String selectedAge = "12";
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



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        text: "Statistics",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(height: 4.h),
                      CommonText(
                        text: "2024/25 Top Stats",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.color373737,
                      ),
                    ],
                  ),

                  Obx(() => PopupMenuButton<String>(
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
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFF2F2F2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
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
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                              CommonText(
                                text: controller.selectedAge.value, // Controller theke value ashche
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.keyboard_arrow_up_rounded, size: 18, color: Colors.black),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Colors.black),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
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
