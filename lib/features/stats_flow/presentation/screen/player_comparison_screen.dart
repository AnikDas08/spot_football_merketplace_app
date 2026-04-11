import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';

import '../../../../component/text/common_text.dart';
import '../controller/player_comparison_controlller.dart';
import '../widget/add_player_placeholder.dart';
import '../widget/compareInfo_card.dart';
import '../widget/comparison_stats_table.dart';
import '../widget/filter_selector_card.dart';
import '../widget/selected_player_card.dart';

class PlayerComparisonScreen extends StatelessWidget {
  PlayerComparisonScreen({super.key});

  final controller = Get.put(PlayerComparisonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'player comparison'),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          physics:  ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 28.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: CommonText(
                  text: "SELECT TWO PLAYERS TO COMPARE THEIR STATS",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),

              SizedBox(height: 24.h),

              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: controller.player1.value == null
                          ? AddPlayerPlaceholder(
                              onTap: () => Get.toNamed(
                                AppRoutes.addPlayerScreen,
                                arguments: 1,
                              ),
                            )
                          : SelectedPlayerCard(
                              player: controller.player1.value!,
                            ),
                    ),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: controller.player2.value == null
                          ? AddPlayerPlaceholder(
                              onTap: () => Get.toNamed(
                                AppRoutes.addPlayerScreen,
                                arguments: 2,
                              ),
                            )
                          : SelectedPlayerCard(
                              player: controller.player2.value!,
                            ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.w),

              Obx(() {
                if (controller.player1.value != null) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FilterSelectorCard(
                              label: "Season",
                              value: "2024/25",
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: FilterSelectorCard(
                              label: "Season",
                              value: "2024/25",
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      ComparisonStatsTable(
                        player1: controller.player1.value,
                        player2: controller.player2.value,
                      ),
                    ],
                  );
                } else {
                  return const CompareInfoCard();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
