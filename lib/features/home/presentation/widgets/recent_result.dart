import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../../data/match_model.dart';
import 'recent_result_card.dart';

class RecentResult extends StatelessWidget {
  final List<MatchModel> matches;
  final bool isLoading;
  final Color? titleColor;
  final Color? viewAllColor;

  const RecentResult({
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

    final displayMatches = matches.length > 5 ? matches.take(5).toList() : matches;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent results",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: titleColor ?? AppColors.primaryColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.allResults, arguments: {'title': "Recent results"});
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
              itemCount: displayMatches.length,
              itemBuilder: (context, index) {
                final match = displayMatches[index];

                String formattedDate = match.matchDate != null 
                    ? DateFormat('MMM dd').format(match.matchDate!).toUpperCase()
                    : 'TBA';
                String formattedTime = match.matchDate != null 
                    ? DateFormat('HH:mm a').format(match.matchDate!)
                    : '';

                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: RecentResultCard(
                    id: match.id,
                    time: formattedTime,
                    date: formattedDate,
                    homeTeam: match.homeTeam.teamName,
                    awayTeam: match.awayTeam.teamName,
                    homeScore: match.homeScore,
                    awayScore: match.awayScore,
                    homeLogo: match.homeTeam.teamLogo,
                    awayLogo: match.awayTeam.teamLogo,
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
