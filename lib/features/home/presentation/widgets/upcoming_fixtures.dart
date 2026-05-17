import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/upcoming_fixture_card.dart';

import '../../data/fixture_model.dart';

class UpcomingFixtures extends StatelessWidget {
  final List<UpcomingFixtureModel> fixtures;

  const UpcomingFixtures({
    super.key,
    required this.fixtures,
  });

  @override
  Widget build(BuildContext context) {
    if (fixtures.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "UPCOMING FIXTURES",
            fontSize: 20.sp,
            fontWeight: const FontWeight(590),
          ),
          SizedBox(height: 12.h),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fixtures.length,
            itemBuilder: (context, index) {
              final fixture = fixtures[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: UpcomingFixtureCard(
                  date: fixture.date,
                  homeTeam: fixture.homeTeam,
                  awayTeam: fixture.awayTeam,
                  time: fixture.time,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}