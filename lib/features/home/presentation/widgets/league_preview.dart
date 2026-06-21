import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../data/point_table_model.dart';

class LeaguePreview extends StatelessWidget {
  final bool isSeeAll;
  final List<PointTableModel> standings;
  final bool isLoading;
  final String? leagueName;
  final String? season;
  final bool showHeader;

  const LeaguePreview({
    super.key,
    this.isSeeAll = false,
    required this.standings,
    this.isLoading = false,
    this.leagueName,
    this.season,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading && standings.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSeeAll && showHeader)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonText(
                    text: AppString.leaguePreview.toUpperCase(),
                    fontWeight: const FontWeight(600),
                    fontSize: 20.sp,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.leaguePreview);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
          if (leagueName != null) ...[
            if (showHeader) SizedBox(height: 8.h),
            CommonText(
              text: '$leagueName ${season ?? ""}',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.color6B6B6B,
            ),
          ],
          if (!isSeeAll && showHeader) SizedBox(height: 12.h),
          if (!showHeader) SizedBox(height: 8.h),
          if (isLoading)
            CustomShimmer.rectangular(height: 200.h)
          else
            _StandingsTable(standings: standings, isSeeAll: isSeeAll),
        ],
      ),
    );
  }
}

class _StandingsTable extends StatelessWidget {
  final List<PointTableModel> standings;
  final bool isSeeAll;

  const _StandingsTable({required this.standings, this.isSeeAll = false});

  @override
  Widget build(BuildContext context) {
    final displayList = isSeeAll ? standings : standings.take(5).toList();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(
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
                      fontWeight: const FontWeight(510),
                      color: AppColors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 22.w)  ,
                      child: CommonText(
                        text: 'Club',
                        fontSize: 14.sp,
                        fontWeight: const FontWeight(510),
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                    child: CommonText(
                      text: 'PL',
                      fontSize: 14.sp,
                      fontWeight: const FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 36.w,
                    child: CommonText(
                      text: 'GD',
                      fontSize: 14.sp,
                      fontWeight: const FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 36.w,
                    child: CommonText(
                      text: 'PTS',
                      fontSize: 14.sp,
                      fontWeight: const FontWeight(510),
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayList.length,
            separatorBuilder: (_, _) => Divider(height: 1, color: AppColors.background),
            itemBuilder: (context, index) {
              final item = displayList[index];
              return _StandingRow(item: item, position: index + 1);
            },
          ),
        ],
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final PointTableModel item;
  final int position;

  const _StandingRow({required this.item, required this.position});

  @override
  Widget build(BuildContext context) {
    final gdText = item.goalDifference >= 0
        ? '+${item.goalDifference}'
        : '${item.goalDifference}';

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.clubProfileScreen, arguments: item.team.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            SizedBox(
              width: 30.w,
              child: CommonText(
                text: '$position.',
                fontSize: 16.sp,
                fontWeight: const FontWeight(510),
                color: AppColors.primaryColor,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CommonImage(
                    imageSrc: item.team.teamLogo ?? '',
                    width: 20.w,
                    height: 20.h,
                    fill: BoxFit.contain,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CommonText(
                      text: item.team.teamName,
                      fontSize: 14.sp,
                      fontWeight: const FontWeight(510),
                      color: AppColors.primaryColor,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30.w,
              child: CommonText(
                text: '${item.played}',
                fontSize: 16.sp,
                fontWeight: const FontWeight(510),
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 36.w,
              child: CommonText(
                text: gdText,
                fontSize: 16.sp,
                fontWeight: const FontWeight(510),
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 36.w,
              child: CommonText(
                text: '${item.points}',
                fontSize: 16.sp,
                fontWeight: const FontWeight(510),
                color: AppColors.primaryColor,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
