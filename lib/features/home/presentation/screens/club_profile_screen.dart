import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../../match_info/presentation/controllers/tabs_controller.dart';
import '../controllers/club_profile_controller.dart';
import '../widgets/league_context_widget.dart';
import '../widgets/league_header_widget.dart';
import '../widgets/recent_result.dart';
import '../widgets/upcoming_fixtures.dart';
import 'package:google_fonts/google_fonts.dart';

class ClubProfileScreen extends StatelessWidget {
  ClubProfileScreen({super.key});
  final TabsController tabsController = Get.find<TabsController>();

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available and handles arguments
    final controller = Get.put(ClubProfileController());
    
    // Refresh for new arguments if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        controller.fetchTeamDashboard(Get.arguments);
      }
    });

    return Scaffold(
      appBar: const SecondaryAppBar(title: "Club profile"),
      body: GetBuilder<ClubProfileController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }

          // Group players by position
          final Map<String, List<dynamic>> groupedPlayers = {};
          for (var player in controller.teamPlayers) {
            final pos = player['position'] ?? 'Other';
            if (!groupedPlayers.containsKey(pos)) {
              groupedPlayers[pos] = [];
            }
            groupedPlayers[pos]!.add(player);
          }

          final positionOrder = ['Goalkeeper', 'Defender', 'Midfielder', 'Forward', 'Other'];
          final sortedPositions = groupedPlayers.keys.toList()
            ..sort((a, b) {
              int idxA = positionOrder.indexOf(a);
              int idxB = positionOrder.indexOf(b);
              if (idxA == -1) idxA = 99;
              if (idxB == -1) idxB = 99;
              return idxA.compareTo(idxB);
            });

          return RefreshIndicator(
            onRefresh: () async {
              final String? teamId = Get.arguments;
              if (teamId != null) {
                await controller.fetchTeamDashboard(teamId);
              } else {
                await controller.fetchMatches();
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeagueHeaderWidget(
                    teamName: controller.teamData?['teamName'],
                    teamLogo: controller.teamData?['teamLogo'],
                    subtitle: controller.teamData?['stadiumName'] != null 
                        ? "${controller.teamData!['stadiumName']}, founded 1902"
                        : null,
                  ),
                  SizedBox(height: 28.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: LeagueContextWidget(
                      position: controller.position,
                      points: controller.points,
                      gd: controller.goalDifference,
                    ),
                  ),
                  SizedBox(height: 28.h),

                  RecentResult(matches: controller.recentMatches),
                  SizedBox(height: 20.h),
                  
                  UpcomingFixtures(fixtures: controller.upcomingMatches),
                  SizedBox(height: 20.h),



                  if (sortedPositions.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Total squads',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: sortedPositions.length,
                    itemBuilder: (context, index) {
                      final pos = sortedPositions[index];
                      final players = groupedPlayers[pos]!;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: pos,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.color6B6B6B,
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
                              itemCount: players.length,
                              separatorBuilder: (_, __) => Divider(
                                color: AppColors.colorCCCCCC,
                                height: 1,
                                thickness: 1,
                                indent: 16.w,
                                endIndent: 16.w,
                              ),
                              itemBuilder: (context, playerIndex) {
                                final player = players[playerIndex];
                                return _PlayerRow(
                                  id: player['userId'] ?? player['_id'],
                                  name: "${player['firstName'] ?? ""} ${player['lastName'] ?? ""}".trim(),
                                  imageUrl: player['profile'],
                                  position: player['position'] ?? "",
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
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
      ),
    );
  }
}

class _PlayerRow extends StatelessWidget {
  final String id;
  final String name;
  final String? imageUrl;
  final String position;

  const _PlayerRow({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.playerProfile, arguments: id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? CommonImage(
                      imageSrc: imageUrl!,
                      width: 52.w,
                      height: 52.h,
                      fill: BoxFit.cover,
                    )
                  : Image.asset(
                      TempImage.playerWithFootball,
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
                    text: name,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 3),
                  CommonText(
                    text: position,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color6B6B6B,
                  ),
                ],
              ),
            ),

            SvgPicture.asset(
              AppIcons.arrowRight,
              colorFilter: const ColorFilter.mode(
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
