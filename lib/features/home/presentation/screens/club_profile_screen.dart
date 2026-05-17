import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/common_appbar/secondary_appbar.dart';

import '../controllers/club_profile_controller.dart';
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
          ],
        ),
      ),
    );
  }
}
