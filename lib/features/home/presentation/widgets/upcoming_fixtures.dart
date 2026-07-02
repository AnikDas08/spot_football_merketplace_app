import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixture_card.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/match_model.dart';

class UpcomingFixtures extends StatelessWidget {
  final List<MatchModel> fixtures;
  final bool isLoading;

  const UpcomingFixtures({
    super.key,
    required this.fixtures,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomShimmer.rectangular(height: 24.h, width: 180.w),
            SizedBox(height: 12.h),
            Column(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: CustomShimmer.rectangular(height: 90.h),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (fixtures.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "UPCOMING FIXTURES",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
            fontFamily: 'Montserrat',
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 250.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fixtures.length,
              itemBuilder: (context, index) {
                final fixture = fixtures[index];

                String formattedDate = fixture.matchDate != null
                    ? DateFormat('MMM dd').format(fixture.matchDate!).toUpperCase()
                    : 'TBA';
                String formattedTime = fixture.matchDate != null
                    ? DateFormat('HH:mm a').format(fixture.matchDate!)
                    : '';

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: UpcomingFixtureCard(
                    id: fixture.id,
                    date: formattedDate,
                    homeTeam: fixture.homeTeam.teamName,
                    awayTeam: fixture.awayTeam.teamName,
                    time: formattedTime,
                    homeLogo: fixture.homeTeam.teamLogo,
                    awayLogo: fixture.awayTeam.teamLogo,
                    venue: fixture.venueName,
                    width: 320.w,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
