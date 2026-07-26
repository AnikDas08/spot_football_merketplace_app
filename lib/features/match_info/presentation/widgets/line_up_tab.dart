import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/temp_image.dart';
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
                border: Border.all(color: AppColors.colorEABB00, width: 1.w),
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
                          fontSize: 14,
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
                    border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withAlpha(10),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        decoration: const BoxDecoration(color: AppColors.primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: 'Tactical Lineup',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                            CommonText(
                              text: "$formation aside",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
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
                              _buildFormation(currentSelection),
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
                  fontSize: 20,
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
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.color6B6B6B,
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.colorEABB00, width: 1.w),
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

  Widget _buildFormation(SelectionData? selection) {
    if (selection == null) return const SizedBox.shrink();

    final starters = selection.players.where((p) => !p.substitute).toList();
    final String formation = selection.teamFormation;

    // Get columns left to right (GK -> Def -> Mid -> Fwd)
    final layoutWithIndices = _getHorizontalLayout(formation);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: layoutWithIndices.map((column) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: column.map((posInfo) {
            final int nodeIdx = posInfo['index'] as int;
            final String posName = posInfo['label'] as String;

            final p = starters
                .firstWhereOrNull((player) => player.positionIndex == nodeIdx);

            // Map long names to short codes if needed, or just use initials
            String displayPos = posName;
            if (posName.contains('Goalkeeper')) {
              displayPos = 'GK';
            } else if (posName == 'Defender') {
              displayPos = 'DF';
            } else if (posName == 'Midfielder') {
              displayPos = 'CM';
            } else if (posName == 'Forward' || posName == 'Striker') {
              displayPos = 'ST';
            }

            return _PitchNode(
              initial: p != null
                  ? (p.player.firstName?[0] ?? p.player.userName?[0] ?? "P")
                      .toUpperCase()
                  : displayPos,
              name: p != null ? (p.player.firstName ?? "Player") : "",
              position: posName,
              imageUrl: p?.player.profile,
              id: p?.player.id,
            );
          }).toList(),
        );
      }).toList(),
    );
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
  final String initial;
  final String name;
  final String position;
  final String? imageUrl;
  final String? id;

  const _PitchNode({
    required this.initial,
    required this.name,
    required this.position,
    this.imageUrl,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id != null) Get.toNamed(AppRoutes.playerProfile, arguments: id);
      },
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: name.isEmpty
              ? Colors.white.withValues(alpha: 0.2)
              : const Color(0xFFF57C00),
          border:
              name.isEmpty ? null : Border.all(color: AppColors.white, width: 2),
        ),
        child: name.isEmpty
            ? const SizedBox.shrink()
            : ClipOval(
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? CommonImage(
                        imageSrc: imageUrl!,
                        width: 45.w,
                        height: 45.w,
                        fill: BoxFit.cover,
                      )
                    : Center(
                        child: CommonText(
                          text: initial,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
              ),
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
              child: CommonImage(
                imageSrc: imageUrl ?? "",
                width: 52.w,
                height: 52.h,
                fill: BoxFit.cover,
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
