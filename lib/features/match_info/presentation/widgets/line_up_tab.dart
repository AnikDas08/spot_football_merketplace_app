import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../team_sheet/data/team_sheet_models.dart';
import '../controllers/match_info_controller.dart';


class LineupsTab extends StatefulWidget {
  const LineupsTab({super.key});

  @override
  State<LineupsTab> createState() => _LineupsTabState();
}

class _LineupsTabState extends State<LineupsTab> {
  final matchController = Get.find<MatchInfoController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final match = matchController.match.value;
      if (match == null) return const SizedBox.shrink();

      final currentSelection = matchController.selectedTeamIndex.value == 0
          ? matchController.homeSelection.value
          : matchController.awaySelection.value;

      final List<String> teams = [match.homeTeam.teamName, match.awayTeam.teamName];
      
      // Group players by position exactly as in club_profile_screen
      final Map<String, List<SelectedPlayer>> groupedPlayers = {};
      if (currentSelection != null) {
        for (var player in currentSelection.players) {
          final pos = player.position;
          if (!groupedPlayers.containsKey(pos)) {
            groupedPlayers[pos] = [];
          }
          groupedPlayers[pos]!.add(player);
        }
      }

      final positionOrder = ['Goalkeeper', 'Defender', 'Midfielder', 'Forward', 'Other'];
      final sortedPositions = groupedPlayers.keys.toList()
        ..sort((a, b) {
          int idxA = positionOrder.indexWhere((e) => a.contains(e));
          int idxB = positionOrder.indexWhere((e) => b.contains(e));
          if (idxA == -1) idxA = 99;
          if (idxB == -1) idxB = 99;
          return idxA.compareTo(idxB);
        });

      final formation = currentSelection?.teamFormation ?? "9";
      final starters = currentSelection?.players.where((p) => !p.substitute).toList() ?? [];
      
      final horizontalLayout = _getHorizontalLayout(formation);
 
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
                  final isSelected = matchController.selectedTeamIndex.value == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => matchController.changeSelectedTeam(index),
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

          // Player list grouped by position
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                // Stadium Visual (Horizontal)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(text: 'Tactical Lineup', fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                            CommonText(text: "$formation aside", fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12.r),
                        child: AspectRatio(
                          aspectRatio: 335 / 220,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(AppImages.stadium, fit: BoxFit.cover),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: horizontalLayout.map((column) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: column.map((posInfo) {
                                      final int nodeIdx = posInfo['index'] as int;
                                      final String posLabel = posInfo['label'] as String;
                                      final p = starters.firstWhereOrNull((player) => player.positionIndex == nodeIdx);
                                      
                                      return _PitchNode(
                                        name: p != null ? "${p.player.firstName ?? ""} ${p.player.lastName ?? ""}".trim() : "",
                                        initial: p != null ? (p.player.firstName?[0] ?? p.player.userName?[0] ?? "P").toUpperCase() : posLabel.substring(0, 1),
                                        imageUrl: p?.player.profile,
                                        position: posLabel,
                                        id: p?.player.id,
                                      );
                                    }).toList(),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
                CommonText(
                  text: 'PLAYER LIST',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),

                if (currentSelection == null || currentSelection.players.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("No players selected for this team.")),
                  )
                else
                  ...sortedPositions.map((pos) {
                    final players = groupedPlayers[pos]!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        CommonText(
                          text: pos,
                          fontSize: 18.sp,
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
                              final p = players[playerIndex];
                              return _PlayerRow(
                                id: p.player.id,
                                name: "${p.player.firstName ?? ""} ${p.player.lastName ?? ""}".trim().isNotEmpty 
                                    ? "${p.player.firstName ?? ""} ${p.player.lastName ?? ""}".trim() 
                                    : (p.player.userName ?? "Player"),
                                imageUrl: p.player.profile,
                                position: p.position,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      );
    });
  }

  List<List<Map<String, dynamic>>> _getHorizontalLayout(String formation) {
    final count = int.tryParse(formation) ?? 9;
    if (count == 5) {
      return [
        [{'label': 'Goalkeeper', 'index': 4}],
        [{'label': 'Defender', 'index': 3}],
        [{'label': 'Midfielder', 'index': 1}, {'label': 'Midfielder', 'index': 2}],
        [{'label': 'Forward', 'index': 0}],
      ];
    } else if (count == 7) {
      return [
        [{'label': 'Goalkeeper', 'index': 6}],
        [{'label': 'Defender', 'index': 4}, {'label': 'Defender', 'index': 5}],
        [{'label': 'Midfielder', 'index': 1}, {'label': 'Midfielder', 'index': 2}, {'label': 'Midfielder', 'index': 3}],
        [{'label': 'Forward', 'index': 0}],
      ];
    } else {
      // 9 Aside
      return [
        [{'label': 'Goalkeeper', 'index': 8}],
        [{'label': 'Defender', 'index': 5}, {'label': 'Defender', 'index': 6}, {'label': 'Defender', 'index': 7}],
        [{'label': 'Midfielder', 'index': 2}, {'label': 'Midfielder', 'index': 3}, {'label': 'Midfielder', 'index': 4}],
        [{'label': 'Forward', 'index': 0}, {'label': 'Forward', 'index': 1}],
      ];
    }
  }
}

class _PitchNode extends StatelessWidget {
  final String name;
  final String initial;
  final String? imageUrl;
  final String position;
  final String? id;

  const _PitchNode({required this.name, required this.initial, this.imageUrl, required this.position, this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id != null) Get.toNamed(AppRoutes.playerProfile, arguments: id);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: name.isEmpty ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF57C00),
              border: name.isEmpty ? null : Border.all(color: Colors.white, width: 1.5),
            ),
            child: name.isEmpty 
              ? const SizedBox.shrink() 
              : ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CommonImage(imageSrc: imageUrl!, width: 45.w, height: 45.w, fill: BoxFit.cover)
                      : Center(child: CommonText(text: initial, fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: 70.w,
            child: CommonText(
              text: name,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CommonText(text: position, fontSize: 9.sp, fontWeight: FontWeight.w500, textAlign: TextAlign.center, color: Colors.white.withValues(alpha: 0.9)),
        ],
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 3),
                  CommonText(
                    text: position,
                    fontSize: 14.sp,
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
