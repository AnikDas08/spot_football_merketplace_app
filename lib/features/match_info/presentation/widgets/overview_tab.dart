import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/match_info/presentation/controllers/match_info_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../../../team_sheet/data/team_sheet_models.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final matchController = Get.find<MatchInfoController>();

    return Obx(() {
      final match = matchController.match.value;
      final currentSelection = matchController.selectedTeamIndex.value == 0
          ? matchController.homeSelection.value
          : matchController.awaySelection.value;
          
      if (match == null) return const SizedBox.shrink();

      final List<String> teams = [match.homeTeam.teamName, match.awayTeam.teamName];
      final venue = currentSelection?.match != null 
          ? (currentSelection!.match is Map ? currentSelection.match['venueName'] : match.venueName)
          : match.venueName;
      
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),

            // Team toggle
            Container(
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

            SizedBox(height: 16.h),

            // Match Details (Venue & Referee)
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: "MATCH INFO",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 12.h),
                  _InfoRow(
                    label: "Venue",
                    value: venue ?? "Unknown Venue",
                    icon: Icons.location_on_outlined,
                  ),
                  const Divider(),
                  _InfoRow(
                    label: "Referee",
                    value: match.referee?.userName ?? "TBA",
                    icon: Icons.person_outline,
                    imageUrl: match.referee?.profile,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Key Events (Placeholder as not in API)
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: AppString.keyEvents,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 12.h),
                  _KeyEventRow(
                    iconImage: TempImage.football,
                    playerName: "Live Match Events",
                    description: "Match events will appear here during live play.",
                    minute: "-",
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Formation Setup
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
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
                          text: 'Formation Setup',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                        CommonText(
                          text: '${currentSelection?.teamFormation ?? "9"} aside',
                          fontSize: 18.sp,
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
                              child: Image.asset(
                                AppImages.stadium,
                                fit: BoxFit.cover,
                              ),
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
            SizedBox(height: 16.h),
          ],
        ),
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
            
            final p = starters.firstWhereOrNull((player) => player.positionIndex == nodeIdx);
            
            // Map long names to short codes if needed, or just use initials
            String displayPos = posName;
            if (posName.contains('Goalkeeper')) displayPos = 'GK';
            else if (posName == 'Defender') displayPos = 'DF';
            else if (posName == 'Midfielder') displayPos = 'CM';
            else if (posName == 'Forward' || posName == 'Striker') displayPos = 'ST';

            return _PlayerNode(
              initial: p != null ? (p.player.firstName?[0] ?? p.player.userName?[0] ?? "P").toUpperCase() : displayPos, 
              name: p != null ? (p.player.firstName ?? "Player") : "", 
              position: posName,
              imageUrl: p?.player.profile,
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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final String? imageUrl;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          imageUrl != null
              ? ClipOval(
                  child: CommonImage(
                    imageSrc: imageUrl!,
                    width: 36.w,
                    height: 36.w,
                  ),
                )
              : Icon(icon, color: AppColors.primaryColor, size: 24.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: label,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
              ),
              CommonText(
                text: value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _KeyEventRow extends StatelessWidget {
  final String iconImage;
  final String playerName;
  final String description;
  final String minute;

  const _KeyEventRow({
    required this.playerName,
    required this.description,
    required this.minute,
    required this.iconImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconImage),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: playerName,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
              CommonText(
                text: description,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
              ),
            ],
          ),
        ),
        CommonText(
          text: minute,
          fontSize: 14.sp,
          fontWeight: const FontWeight(590),
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class _PlayerNode extends StatelessWidget {
  final String initial;
  final String name;
  final String position;
  final String? imageUrl;

  const _PlayerNode({
    required this.initial,
    required this.name,
    required this.position,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45.w,
          height: 45.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: name.isEmpty ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF57C00),
            border: name.isEmpty ? null : Border.all(color: AppColors.white, width: 2),
          ),
          child: name.isEmpty 
              ? const SizedBox.shrink() 
              : ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CommonImage(imageSrc: imageUrl!, width: 45.w, height: 45.w, fill: BoxFit.cover)
                      : Center(
                          child: CommonText(
                            text: initial,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: 70.w,
          child: CommonText(
            text: name,
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CommonText(
          text: position,
          fontSize: 8.sp,
          textAlign: TextAlign.center,
          color: AppColors.white.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}
