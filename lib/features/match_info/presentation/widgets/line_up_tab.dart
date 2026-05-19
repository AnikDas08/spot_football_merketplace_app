import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../utils/constants/app_icons.dart';
import '../controllers/match_info_controller.dart';

class LineupPlayerModel {
  final int number;
  final String name;
  final String nationality;
  final String imageUrl;

  const LineupPlayerModel({
    required this.number,
    required this.name,
    required this.nationality,
    required this.imageUrl,
  });
}

class LineupGroupModel {
  final String title;
  final List<LineupPlayerModel> players;

  const LineupGroupModel({required this.title, required this.players});
}

class LineupsTab extends StatefulWidget {
  const LineupsTab({super.key});

  @override
  State<LineupsTab> createState() => _LineupsTabState();
}

class _LineupsTabState extends State<LineupsTab> {
  int _selectedTeam = 0;
  final matchController = Get.find<MatchInfoController>();

  final List<LineupGroupModel> _lineups = [
    LineupGroupModel(
      title: 'Goalkeeper',
      players: [
        LineupPlayerModel(
          number: 13,
          name: 'Guglielmo Vicario',
          nationality: 'Italy',
          imageUrl: TempImage.playerWithFootball,
        ),
      ],
    ),
    LineupGroupModel(
      title: 'Defenders',
      players: [
        LineupPlayerModel(
          number: 12,
          name: 'Emerson Royal',
          nationality: 'Italy',
          imageUrl: TempImage.playerWithFootball,
        ),
        LineupPlayerModel(
          number: 23,
          name: 'Pedro Porro',
          nationality: 'Italy',
          imageUrl: TempImage.playerWithFootball,
        ),
        LineupPlayerModel(
          number: 33,
          name: 'Ben Davies',
          nationality: 'Italy',
          imageUrl: TempImage.playerWithFootball,
        ),
        LineupPlayerModel(
          number: 38,
          name: 'Destiny Udogie',
          nationality: 'Italy',
          imageUrl: TempImage.playerWithFootball,
        ),
      ],
    ),
    LineupGroupModel(
      title: 'Midfielders',
      players: [
        LineupPlayerModel(
          number: 8,
          name: 'Yves Bissouma',
          nationality: 'Mali',
          imageUrl: TempImage.playerWithFootball,
        ),
        LineupPlayerModel(
          number: 17,
          name: 'Rodrigo Bentancur',
          nationality: 'Uruguay',
          imageUrl: TempImage.playerWithFootball,
        ),
      ],
    ),
    LineupGroupModel(
      title: 'Forwards',
      players: [
        LineupPlayerModel(
          number: 7,
          name: 'Son Heung-min',
          nationality: 'South Korea',
          imageUrl: TempImage.playerWithFootball,
        ),
        LineupPlayerModel(
          number: 10,
          name: 'James Maddison',
          nationality: 'England',
          imageUrl: TempImage.playerWithFootball,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final match = matchController.match.value;
      if (match == null) return const SizedBox.shrink();

      final List<String> teams = [match.homeTeam.teamName, match.awayTeam.teamName];

      return Column(
        children: [
          // Team toggle
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: List.generate(teams.length, (index) {
                  final isSelected = _selectedTeam == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTeam = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: CommonText(
                          text: teams[index].toUpperCase(),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.white : AppColors.primaryColor,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          // Player list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: _lineups.length,
              itemBuilder: (context, groupIndex) {
                final group = _lineups[groupIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    CommonText(
                      text: group.title,
                      fontSize: 20.sp,
                      fontWeight: const FontWeight(590),
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withAlpha(10),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: group.players.length,
                        separatorBuilder: (_, __) => Divider(
                          color: AppColors.colorCCCCCC,
                          height: 1,
                          thickness: 1,
                          indent: 16.w,
                          endIndent: 16.w,
                        ),
                        itemBuilder: (context, playerIndex) {
                          final player = group.players[playerIndex];
                          return _PlayerRow(player: player);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class _PlayerRow extends StatelessWidget {
  final LineupPlayerModel player;

  const _PlayerRow({required this.player});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.playerProfile);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            SizedBox(
              width: 28.w,
              child: CommonText(
                text: '${player.number}',
                fontSize: 15.sp,
                fontWeight: const FontWeight(590),
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(width: 8.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                player.imageUrl,
                width: 52.w,
                height: 52.h,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: player.name,
                    fontSize: 15.sp,
                    fontWeight: const FontWeight(590),
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 3.h),
                  CommonText(
                    text: player.nationality,
                    fontSize: 14.sp,
                    fontWeight: const FontWeight(510),
                    color: AppColors.color6B6B6B,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              AppIcons.arrowRight,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
