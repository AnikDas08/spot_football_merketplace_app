import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/common_appbar.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/latest_news.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/player_profile/presentation/widgets/performance_card.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/text/common_text.dart';
import '../controllers/player_profile_controller.dart';
import '../widgets/eng_record_widget.dart';
import '../widgets/personal_details_widget.dart';
import '../widgets/player_header_widget.dart';
import '../widgets/recent_performance.dart';

class PlayerProfileScreen extends StatelessWidget {
  const PlayerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.playerProfile),
      body: GetBuilder<PlayerProfileController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const PlayerHeaderWidget(),
                SizedBox(height: 16.h),
                const PersonalDetailsWidget(),
                SizedBox(height: 16.h),
                const EngRecordWidget(),
                SizedBox(height: 16.h),
                RecentPerformance(),
                SizedBox(height: 16.h),
                LatestNews(),
                SizedBox(height: 24.h),
                LatestVideos(),
              ],
            ),
          );
        },
      ),
    );
  }
}


