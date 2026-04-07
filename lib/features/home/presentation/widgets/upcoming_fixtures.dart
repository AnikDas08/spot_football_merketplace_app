import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixture_card.dart';
import 'package:untitled/utils/constants/app_string.dart';

class UpcomingFixtures extends StatelessWidget {
  const UpcomingFixtures({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CommonText(
            text: AppString.upcomingFixtures.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: FontWeight(590),
          ),
          SizedBox(height: 12.h),
          Column(
            spacing: 10,
            crossAxisAlignment: .start,
            children: [
              ...List.generate(
                10,
                (index) => UpcomingFixtureCard(
                  date: "OCT 24",
                  homeTeam: AppString.titansSc,
                  awayTeam: AppString.vortexFc,
                  homeScore: 3,
                  awayScore: 1,
                  time: "20:00 PM",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
