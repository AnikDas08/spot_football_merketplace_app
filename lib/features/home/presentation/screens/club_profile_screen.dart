import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../../match_info/presentation/controllers/tabs_controller.dart';
import '../../../match_info/presentation/widgets/line_up_tab.dart';
import '../controllers/club_profile_controller.dart';
import '../widgets/league_context_widget.dart';
import '../widgets/league_header_widget.dart';
import '../widgets/recent_result.dart';
import '../widgets/upcoming_fixtures.dart';

class ClubProfileScreen extends StatelessWidget {
  ClubProfileScreen({super.key});
  final TabsController tabsController = Get.find<TabsController>();
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
    final controller = ClubProfileController();

    return Scaffold(
      appBar: const SecondaryAppBar(title: "Club profile"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LeagueHeaderWidget(),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const LeagueContextWidget(),
            ),
            SizedBox(height: 28.h),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 0.w, right: 0.w, bottom: 0.h),
                  child: const RecentResult(
                    time: "18:30 PM",
                    date: "NOV 12",
                    homeTeam: "Phoenix UTDS",
                    awayTeam: "Lions FC",
                    homeScore: 3,
                    awayScore: 0,
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            UpcomingFixtures(fixtures: controller.upcomingFixturesList),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: _lineups.length,
              itemBuilder: (context, groupIndex) {
                final group = _lineups[groupIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: group.title,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
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

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
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
                fontWeight: FontWeight.w600,
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
                spacing: 3,
                children: [
                  CommonText(
                    text: player.name,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  CommonText(
                    text: player.nationality,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
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