import '../../../../utils/extensions/extension.dart';

import 'package:eng_sports/features/home/presentation/widgets/recent_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/match_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';

class LiveMatches extends StatelessWidget {
  final List<MatchModel> matches;
  final bool isLoading;
  final Color? titleColor;
  final Color? viewAllColor;

  const LiveMatches({
    super.key,
    required this.matches,
    this.isLoading = false,
    this.titleColor,
    this.viewAllColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: List.generate(1, (index) => Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: CustomShimmer.rectangular(height: 80.h),
          )),
        ),
      );
    }

    if (matches.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(


        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Live matches".toTitleCase(),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.primaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.allResults, arguments: {'title': "Live matches", 'type': 'live'});
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
                      colorFilter: ColorFilter.mode(
                        viewAllColor ?? AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 130.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: RecentResultCard(
                    id: match.id,
                    time: "",
                    date: "LIVE",
                    homeTeam: match.homeTeam.teamName,
                    awayTeam: match.awayTeam.teamName,
                    homeScore: match.homeScore,
                    awayScore: match.awayScore,
                    homeLogo: match.homeTeam.teamLogo,
                    awayLogo: match.awayTeam.teamLogo,
                    width: 320.w,
                    isLive: true,
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
