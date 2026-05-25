import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/home/presentation/widgets/league_preview.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixtures.dart';
import '../../../../component/text/common_text.dart';
import '../controllers/banner_controller.dart';
import '../controllers/club_profile_controller.dart';
import '../widgets/banner_slider.dart';
import '../widgets/latest_news.dart';
import '../widgets/recent_result.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../../component/common_appbar/common_appbar.dart';
import '../widgets/upcoming_events.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClubProfileController());
    final bannerController = Get.put(BannerController());
    
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CommonAppbar(title: AppString.community),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchMatches();
          await controller.fetchPointTable();
          await bannerController.fetchBannerVideos();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: GetBuilder<ClubProfileController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonText(
                        text: AppString.home,
                        fontSize: 20.sp,
                        fontWeight: const FontWeight(590),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    const BannerSlider(),

                    SizedBox(height: 12.h),

                    const LatestNews(),

                    SizedBox(height: 20.h),

                    const UpcomingEvents(),

                    SizedBox(height: 20.h),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CommonText(
                        text: AppString.recentResult.toUpperCase(),
                        fontSize: 20.sp,
                        fontWeight: const FontWeight(590),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    RecentResult(
                      matches: controller.recentMatches,
                      isLoading: controller.isLoading.value,
                    ),

                    SizedBox(height: 20.h),

                    UpcomingFixtures(
                      fixtures: controller.upcomingMatches,
                      isLoading: controller.isLoading.value,
                    ),

                    SizedBox(height: 20.h),

                    LeaguePreview(
                      standings: controller.pointTable,
                      isLoading: controller.isLoading.value,
                    ),

                    SizedBox(height: 20.h),

                    const LatestVideos(),

                    SizedBox(height: 20.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
