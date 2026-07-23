import 'package:eng_sports/features/home/presentation/widgets/upcoming_fixture_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../navbar/controller/navbar_controller.dart';
import '../../data/match_model.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingFixtures extends StatelessWidget {
  final List<MatchModel> fixtures;
  final bool isLoading;
  final Color? titleColor;
  final Color? viewAllColor;

  const UpcomingFixtures({
    super.key,
    required this.fixtures,
    this.isLoading = false,
    this.titleColor,
    this.viewAllColor,
  });

  @override
  Widget build(BuildContext context) {
    final navBarController = Get.find<NavBarController>();
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

    // Show only first 5 fixtures as requested
    final displayFixtures = fixtures.length > 5 ? fixtures.take(5).toList() : fixtures;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Upcoming fixtures",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.primaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  navBarController.selectedIndex.value = 1; // Index for Fixtures tab
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppString.viewAll,
                      style: GoogleFonts.playfairDisplay(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: viewAllColor ?? AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      AppIcons.arrowRight,
                      height: 18.h,
                      colorFilter: viewAllColor != null
                          ? ColorFilter.mode(viewAllColor!, BlendMode.srcIn)
                          : ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayFixtures.length,
              itemBuilder: (context, index) {
                final fixture = displayFixtures[index];

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
