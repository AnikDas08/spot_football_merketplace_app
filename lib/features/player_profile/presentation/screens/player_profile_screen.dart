import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/latest_news.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';

import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../services/storage/storage_services.dart';
import '../controllers/player_profile_controller.dart';
import '../widgets/eng_record_widget.dart';
import '../widgets/personal_details_widget.dart';
import '../widgets/player_header_widget.dart';
import '../widgets/recent_performance.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is initialized
    final controller = Get.put(PlayerProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.playerProfile),
      body: GetBuilder<PlayerProfileController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }

          if (controller.dashboardData == null) {
            return const Center(child: Text("No player data found"));
          }

          final player = controller.playerData;
          final stats = controller.dashboardData!['stats'];
          final matches = controller.dashboardData!['recentMatches'];

          final firstName = player?['firstName'] ?? "";
          final lastName = player?['lastName'] ?? "";
          final fullName = "$firstName $lastName".trim();

          final bool isManager = LocalStorage.role.toUpperCase() == "MANAGER";
          final dynamic args = Get.arguments;
          final bool isFromMyChildren = (args is Map) && (args['isFromMyChildren'] ?? false);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlayerHeaderWidget(
                  playerName: fullName.isNotEmpty ? fullName : (player?['userName'] ?? "Player"),
                  position: player?['position'] ?? "N/A",
                  profileImage: player?['profile'],
                ),
                SizedBox(height: 16.h),
                PersonalDetailsWidget(playerData: player),
                
                // Submit Offer Button for Managers only
                if (isManager)
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: CommonButton(
                      titleText: "Submit Offer",
                      isLoading: controller.isOfferingTrial,
                      onTap: () => controller.offerTrial(),
                    ),
                  ),

                SizedBox(height: 16.h),
                EngRecordWidget(stats: stats),
                SizedBox(height: 16.h),
                RecentPerformance(matches: matches),
                
                if (!isFromMyChildren) ...[
                  SizedBox(height: 16.h),
                  const LatestNews(),
                  SizedBox(height: 24.h),
                  const LatestVideos(),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
