import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/home/presentation/widgets/league_preview.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixtures.dart';
import '../../../../component/text/common_text.dart';
import '../../../news/presentation/controller/news_controller.dart';
import '../controllers/banner_controller.dart';
import '../controllers/club_profile_controller.dart';
import '../controllers/event_controller.dart';
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
    final newsController = Get.put(NewsController());
    final eventController = Get.put(EventController());
    
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CommonAppbar(title: AppString.community),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            controller.fetchMatches(),
            controller.fetchPointTable(),
            bannerController.fetchBannerVideos(),
            newsController.fetchNews(),
            eventController.fetchEvents(),
          ]);
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

                    GetBuilder<NewsController>(
                      builder: (newsController) {
                        return Obx(() {
                          if (newsController.isLoading.value || newsController.newsList.isNotEmpty) {
                            return Column(
                              children: [
                                SizedBox(height: 12.h),
                                const LatestNews(),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }
                    ),

                    GetBuilder<EventController>(
                      builder: (eventController) {
                        if (eventController.isLoading.value || eventController.eventList.isNotEmpty) {
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              const UpcomingEvents(),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }
                    ),

                    SizedBox(height: 20.h),

                    if (controller.isLoading.value || controller.recentMatches.isNotEmpty) ...[
                      RecentResult(
                        matches: controller.recentMatches,
                        isLoading: controller.isLoading.value,
                      ),
                      SizedBox(height: 20.h),
                    ],

                    if (controller.isLoading.value || controller.upcomingMatches.isNotEmpty) ...[
                      UpcomingFixtures(
                        fixtures: controller.upcomingMatches,
                        isLoading: controller.isLoading.value,
                      ),
                      SizedBox(height: 20.h),
                    ],

                    if (controller.isLoading.value) ...[
                      LeaguePreview(
                        standings: const [],
                        isLoading: true,
                      ),
                      SizedBox(height: 20.h),
                    ] else ...[
                      ...controller.allLeagues.asMap().entries.map((entry) {
                        int index = entry.key;
                        var leagueData = entry.value;
                        return Column(
                          children: [
                            LeaguePreview(
                              standings: leagueData.standings,
                              leagueName: leagueData.league.leagueName,
                              season: leagueData.league.season,
                              showHeader: index == 0,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }),
                    ],

                    GetBuilder<BannerController>(
                      builder: (bannerController) {
                        return Obx(() {
                          if (bannerController.isLoading.value || bannerController.bannerVideos.isNotEmpty) {
                            return Column(
                              children: [
                                const LatestVideos(),
                                SizedBox(height: 20.h),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      }
                    ),
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
