import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/home/presentation/widgets/league_preview.dart';
import 'package:untitled/features/home/presentation/widgets/live_matches.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixtures.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
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
import '../widgets/book_scout_section.dart';
import '../widgets/eng_tv_home_section.dart';

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
      backgroundColor: const Color(0xFFF3F3F3), // Neutral light background for gaps
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
                    const BannerSlider(),
                    SizedBox(height: 12.h),

                    _buildSection(
                      backgroundColor: Colors.white,
                      child: GetBuilder<NewsController>(
                        builder: (newsController) {
                          return Obx(() {
                            if (newsController.isLoading.value ||
                                newsController.newsList.isNotEmpty) {
                              return const LatestNews();
                            }
                            return const SizedBox.shrink();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),

                    GetBuilder<EventController>(
                      builder: (eventController) {
                        if (eventController.isLoading.value ||
                            eventController.eventList.isNotEmpty) {
                          return _buildSection(
                            backgroundColor: AppColors.primaryColor,
                            child: const UpcomingEvents(titleColor: Colors.white),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: 12.h),

                    if (controller.isLoading.value ||
                        controller.liveMatches.isNotEmpty) ...[
                      _buildSection(
                        backgroundColor: Colors.white,
                        child: LiveMatches(
                          matches: controller.liveMatches,
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],

                    _buildSection(
                      backgroundColor: Colors.white,
                      child: const BookScoutSection(titleColor: AppColors.primaryColor),
                    ),
                    SizedBox(height: 12.h),

                    if (controller.isLoading.value ||
                        controller.recentMatches.isNotEmpty) ...[
                      _buildSection(
                        backgroundColor: Colors.white,
                        child: RecentResult(
                          matches: controller.recentMatches,
                          isLoading: controller.isLoading.value,
                          titleColor: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],

                    _buildSection(
                      backgroundColor: AppColors.black,
                      child: const EngTvHomeSection(
                        titleColor: Colors.white,
                        viewAllColor: AppColors.colorEABB00,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    if (controller.isLoading.value) ...[
                      _buildSection(
                        backgroundColor: Colors.white,
                        child: LeaguePreview(standings: const [], isLoading: true),
                      ),
                      SizedBox(height: 12.h),
                    ] else ...[
                      ...controller.allLeagues.asMap().entries.map((entry) {
                        int index = entry.key;
                        var leagueData = entry.value;
                        return Column(
                          children: [
                            _buildSection(
                              backgroundColor: Colors.white,
                              padding: index == 0 
                                  ? EdgeInsets.symmetric(vertical: 32.h)
                                  : EdgeInsets.only(bottom: 32.h),
                              child: LeaguePreview(
                                standings: leagueData.standings,
                                leagueName: leagueData.league.leagueName,
                                season: leagueData.league.season,
                                showHeader: index == 0,
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                        );
                      }),
                    ],

                    GetBuilder<BannerController>(
                      builder: (bannerController) {
                        return Obx(() {
                          if (bannerController.isLoading.value ||
                              bannerController.bannerVideos.isNotEmpty) {
                            return _buildSection(
                              backgroundColor: AppColors.black,
                              child: const LatestVideos(titleColor: Colors.white),
                            );
                          }
                          return const SizedBox.shrink();
                        });
                      },
                    ),
                    SizedBox(height: 12.h),

                    if (controller.isLoading.value ||
                        controller.upcomingMatches.isNotEmpty) ...[
                      _buildSection(
                        backgroundColor: Colors.white,
                        child: UpcomingFixtures(
                          fixtures: controller.upcomingMatches,
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required Widget child,
    required Color backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: 32.h),
      child: child,
    );
  }
}
