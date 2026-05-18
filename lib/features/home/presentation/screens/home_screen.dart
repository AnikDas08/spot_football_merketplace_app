import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/features/drawer/presentation/screen/app_drawer.dart';
import 'package:untitled/features/home/presentation/widgets/latest_videos.dart';
import 'package:untitled/features/home/presentation/widgets/league_preview.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixtures.dart';

import '../../../../component/text/common_text.dart';
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
    final controller = ClubProfileController();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: CommonAppbar(title: AppString.community),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CommonText(
                    text: AppString.home,
                    fontSize: 20.sp,
                    fontWeight: FontWeight(590),
                  ),
                ),
                SizedBox(height: 20.h),
                BannerSlider(),
                SizedBox(height: 12.h),
                LatestNews(),
                SizedBox(height: 20.h),
                UpcomingEvents(),
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 0.w, right: 0.w, bottom: 14.h),
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
                ),
                SizedBox(height: 20.h),
                UpcomingFixtures(fixtures: controller.upcomingFixturesList),
                SizedBox(height: 20.h),
                LeaguePreview(),
                SizedBox(height: 20.h),
                LatestVideos(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
