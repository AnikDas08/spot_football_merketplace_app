import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_news.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/match_info/presentation/controllers/tabs_controller.dart';
import 'package:untitled/features/match_info/presentation/widgets/line_up_tab.dart';
import 'package:untitled/features/match_info/presentation/widgets/overview_tab.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../widgets/score_card.dart';

class MatchInfoScreen extends StatelessWidget {
  const MatchInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TabsController tabsController = Get.find<TabsController>();
    
    // Extract arguments if passed from UpcomingFixtureCard
    final dynamic args = Get.arguments;
    final bool isUpcoming = args != null && args['isUpcoming'] == true;
    final String time = args != null ? args['time'] : "LIVE 74'";

    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.matchInfo),
      body: Column(
        children: [
          isUpcoming 
            ? ScoreCard(
                homeScore: "0",
                awayScore: "0",
                status: time,
                isLive: false,
              )
            : const ScoreCard(),

          SizedBox(height: 16.h),

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
    );
  }
}
