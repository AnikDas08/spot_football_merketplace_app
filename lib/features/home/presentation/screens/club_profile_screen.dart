import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/button/common_button.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../match_info/presentation/widgets/line_up_tab.dart';
import '../../../match_info/presentation/widgets/overview_tab.dart';
import '../controllers/club_profile_controller.dart';
import '../widgets/latest_news.dart';
import '../widgets/latest_videos.dart';
import '../widgets/league_context_widget.dart';
import '../widgets/league_header_widget.dart';
import '../widgets/recent_result.dart';
import '../widgets/upcoming_fixtures.dart';

class ClubProfileScreen extends StatelessWidget {
  const ClubProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ClubProfileController();
    return Scaffold(
      appBar: SecondaryAppBar(title: "Club profile"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeagueHeaderWidget(),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: LeagueContextWidget(),
            ),
            SizedBox(height: 28.h),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {

                return Padding(
                  padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h),
                  child: RecentResult(
                    time: "18:30 PM",
                    date: "NOV 12",
                    homeTeam: "Phoenix UTDS",
                    awayTeam: "Lions FC",
                    homeScore: 3,
                    awayScore: 0,
                  ),
                );
              },
            ),            SizedBox(height: 20.h),
            UpcomingFixtures(fixtures: controller.upcomingFixturesList),


            // Tab bar
            Obx(
                  () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    children: List.generate(tabsController.tabs.length, (index) {
                      final isSelected =
                          tabsController.selectedTab.value == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            tabsController.selectedTab.value = index;
                          },
                          child: AnimatedContainer(
                            margin: .symmetric(horizontal: 5.w),
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: CommonText(
                              text: tabsController.tabs[index],
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight(590),
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.primaryColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Tab content
            Obx(
                  () => Expanded(
                child: IndexedStack(
                  index: tabsController.selectedTab.value,
                  children: [

                    // Overview tab

                    const SizedBox.expand(child: OverviewTab()),

                    // Lineups tab

                    const SizedBox.expand(child: LineupsTab()),
                    // Related tab
                    SizedBox.expand(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const LatestNews(),
                            const SizedBox(height: 16),
                            Padding(
                              padding: .symmetric(horizontal: 16),
                              child: CommonButton(
                                buttonColor: AppColors.transparent,
                                titleColor: AppColors.primaryColor,
                                borderColor: AppColors.primaryColor,
                                onTap: () {},
                                titleSize: 18.sp,
                                titleText: AppString.moreNews,
                                titleWeight: FontWeight(510),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            LatestVideos(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
