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
import '../controllers/match_info_controller.dart';

class LineupPlayerModel {
  final String id;
  final int number;
  final String name;
  final String nationality;
  final String imageUrl;

  const LineupPlayerModel({
    required this.id,
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

  List<LineupGroupModel> _buildLineups(List<dynamic> players) {
    final Map<String, List<LineupPlayerModel>> grouped = {
      'Goalkeeper': [],
      'Defenders': [],
      'Midfielders': [],
      'Forwards': [],
      'Others': [],
    };

    for (var player in players) {
      final String pos = (player['playerPosition'] ?? 'Other').toString();
      final model = LineupPlayerModel(
        id: player['userId'] ?? player['_id'],
        number: 0, // Number not in API
        name: "${player['firstName'] ?? ""} ${player['lastName'] ?? ""}".trim(),
        nationality: "", // Nationality not in API
        imageUrl: player['profile'] ?? "",
      );

      if (pos.contains('Goalkeeper')) {
        grouped['Goalkeeper']!.add(model);
      } else if (pos.contains('Defender')) {
        grouped['Defenders']!.add(model);
      } else if (pos.contains('Midfielder')) {
        grouped['Midfielders']!.add(model);
      } else if (pos.contains('Forward') || pos.contains('Striker')) {
        grouped['Forwards']!.add(model);
      } else {
        grouped['Others']!.add(model);
      }
    }

    return grouped.entries
        .where((e) => e.value.isNotEmpty)
        .map((e) => LineupGroupModel(title: e.key, players: e.value))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final match = matchController.match.value;
      final selection = matchController.selectionData.value;
      if (match == null) return const SizedBox.shrink();

      final List<String> teams = [match.homeTeam.teamName, match.awayTeam.teamName];
      
      List<dynamic> currentPlayers = [];
      if (selection != null) {
        if (_selectedTeam == 0) {
          currentPlayers = selection['homeTeam']?['players'] ?? [];
        } else {
          currentPlayers = selection['awayTeam']?['players'] ?? [];
        }
      }

      final List<LineupGroupModel> dynamicLineups = _buildLineups(currentPlayers);

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
            child: dynamicLineups.isEmpty 
              ? const Center(child: Text("No players selected for this team."))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: dynamicLineups.length,
                  itemBuilder: (context, groupIndex) {
                    final group = dynamicLineups[groupIndex];
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
        Get.toNamed(AppRoutes.playerProfile, arguments: player.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          children: [
            if (player.number > 0) ...[
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
            ],
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: player.imageUrl.isNotEmpty
                ? CommonImage(
                    imageSrc: player.imageUrl,
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
                    text: player.name,
                    fontSize: 15.sp,
                    fontWeight: const FontWeight(590),
                    color: AppColors.primaryColor,
                  ),
                  if (player.nationality.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: CommonText(
                        text: player.nationality,
                        fontSize: 14.sp,
                        fontWeight: const FontWeight(510),
                        color: AppColors.color6B6B6B,
                      ),
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
