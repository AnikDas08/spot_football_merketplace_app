import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../data/league_preview_model.dart';

class LeaguePreview extends StatelessWidget {
  final bool isSeeAll;
  const LeaguePreview({super.key, this.isSeeAll = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (!isSeeAll)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: AppString.leaguePreview.toUpperCase(),
                  fontWeight: const FontWeight(600),
                  fontSize: 20.sp,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.leaguePreview);
                  },
                  child: Row(
                    children: [
                      CommonText(
                        text: AppString.viewAll,
                        fontWeight: const FontWeight(500),
                        fontSize: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(AppIcons.arrowRight),
                    ],
                  ),
                ),
              ],
            ),
          if (!isSeeAll) SizedBox(height: 12.h),
          Column(
            children: [
              _StandingsTable(
                standings: [
                  ...List.generate(
                    isSeeAll ? 15 : 5,
                    (index) => LeaguePreviewModel(
                      position: index + 1,
                      clubName: AppString.arsenal,
                      clubLogoUrl: TempImage.arsenalFlag,
                      played: 20,
                      goalDifference: 25,
                      points: 45,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StandingsTable extends StatelessWidget {
  final List<LeaguePreviewModel> standings;

  const _StandingsTable({required this.standings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.background, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 30.w,
                    child: CommonText(
                      text: 'Pos',
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.white,
                    ),
                  ),
                  Expanded(
                    child: CommonText(
                      text: 'Club',
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 130.w),
                  SizedBox(
                    width: 36.w,
                    child: CommonText(
                      text: 'PL',
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                    child: CommonText(
                      text: 'GD',
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 36.w,
                    child: CommonText(
                      text: 'PTS',
                      fontSize: 14.sp,
                      fontWeight: FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rows
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: standings.length,
            separatorBuilder: (_, _) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final item = standings[index];
              return _StandingRow(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final LeaguePreviewModel item;

  const _StandingRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final gdText = item.goalDifference >= 0
        ? '+${item.goalDifference}'
        : '${item.goalDifference}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          SizedBox(
            width: 36.w,
            child: CommonText(
              text: '${item.position}.',
              fontSize: 16.sp,
              fontWeight: FontWeight(510),
              color: AppColors.primaryColor,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 20.w),
                Image.asset(
                  item.clubLogoUrl,
                  width: 17.w,
                  height: 20.h,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Container(
                    width: 17.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: AppColors.colorCCCCCC,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                CommonText(
                  text: item.clubName,
                  fontSize: 16.sp,
                  fontWeight: FontWeight(510),
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 36.w,
            child: CommonText(
              text: '${item.played}',
              fontSize: 16.sp,
              fontWeight: FontWeight(510),
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 40.w,
            child: CommonText(
              text: gdText,
              fontSize: 16.sp,
              fontWeight: FontWeight(510),
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 36.w,
            child: CommonText(
              text: '${item.points}',
              fontSize: 16.sp,
              fontWeight: FontWeight(510),
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
