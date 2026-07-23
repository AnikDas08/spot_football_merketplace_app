import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../home/presentation/widgets/latest_news.dart';
import '../../../home/presentation/widgets/latest_videos.dart';
import '../../../news/presentation/controller/news_controller.dart';
import '../controllers/match_info_controller.dart';
import '../controllers/tabs_controller.dart';
import '../widgets/line_up_tab.dart';
import '../widgets/overview_tab.dart';
import '../widgets/score_card.dart';


class MatchInfoScreen extends StatefulWidget {
  const MatchInfoScreen({super.key});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  final TabsController tabsController = Get.find<TabsController>();
  final MatchInfoController matchController = Get.put(MatchInfoController());

  @override
  void initState() {
    super.initState();
    final dynamic args = Get.arguments;
    if (args != null && args['id'] != null) {
      matchController.fetchMatchDetails(args['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlurReveal(
      child: Scaffold(
        appBar: SecondaryAppBar(title: AppString.matchInfo),
        body: Obx(() {
          if (matchController.isLoading.value) {
            return const MatchInfoShimmer(); // ইউটিউব স্টাইল শিমার লোডিং
          }

          final match = matchController.match.value;
          if (match == null) {
            return const Center(child: Text("No match data found"));
          }

          return Column(
            children: [
              ScoreCard(
                homeTeam: match.homeTeam.teamName,
                homeLogo: match.homeTeam.teamLogo,
                homeTeamId: match.homeTeam.id,
                awayTeam: match.awayTeam.teamName,
                awayLogo: match.awayTeam.teamLogo,
                awayTeamId: match.awayTeam.id,
                homeScore: "${match.homeScore}",
                awayScore: "${match.awayScore}",
                status: match.status,
                isLive: match.status.toLowerCase() == 'live',
                venue: match.venueName,
              ),

              SizedBox(height: 16.h),

              // Tab bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  padding: const EdgeInsets.all(4),
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
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
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
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : const FontWeight(590),
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

              SizedBox(height: 16.h),

              // Tab content
              Expanded(
                child: Obx(() => BlurReveal(
                  key: ValueKey(tabsController.selectedTab.value),
                  duration: const Duration(milliseconds: 500),
                  initialBlur: 10,
                  child: IndexedStack(
                    index: tabsController.selectedTab.value,
                    children: [
                      const SizedBox.expand(child: OverviewTab()),
                      const SizedBox.expand(child: LineupsTab()),
                      GetBuilder<NewsController>(
                        init: NewsController(),
                        builder: (newsController) {
                          return Obx(() {
                            if (newsController.newsList.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  const LatestNews(),

                                  SizedBox(height: 20.h),
                                ],
                              ),
                            );
                          });
                        },
                      ),
                      const LatestVideos(),
                    ],
                  ),
                )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
