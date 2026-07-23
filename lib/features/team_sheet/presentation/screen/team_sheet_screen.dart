import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../controller/team_sheet_controller.dart';

class TeamSheetScreen extends StatelessWidget {
  const TeamSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamSheetController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'Team Sheet'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.upcomingMatches.isEmpty) {
          return const Center(child: Text("No upcoming matches found."));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroBanner(controller),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'SELECT TEAM',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              SizedBox(height: 8.h),
                              _buildTeamDropdown(controller),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: 'SELECT VENUE',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                              SizedBox(height: 8.h),
                              _buildVenueDropdown(controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: 'TEAM FORMAT (ASIDE)',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        SizedBox(height: 8.h),
                        _buildFormationDropdown(controller),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildFormationCard(controller),
                    SizedBox(height: 24.h),
                    CommonText(
                      text: 'SUBSTITUTES',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 16.h),
                    _buildSubstitutesList(context, controller),
                    SizedBox(height: 32.h),
                    _buildConfirmButton(controller),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeroBanner(TeamSheetController controller) {
    final currentMatch = controller.upcomingMatches.firstWhereOrNull(
      (m) => m.id == controller.selectedMatchId.value,
    );

    if (currentMatch == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 200.h,
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(AppImages.teamSheetBanner),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: currentMatch.venueName,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: "${currentMatch.homeTeam.teamName} vs ${currentMatch.awayTeam.teamName}",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamDropdown(TeamSheetController controller) {
    // Extract unique teams from matches
    final Map<String, String> teamMap = {};
    for (var m in controller.upcomingMatches) {
      teamMap[m.homeTeam.id] = m.homeTeam.teamName;
      teamMap[m.awayTeam.id] = m.awayTeam.teamName;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedTeamId.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: teamMap.entries.map((e) {
            return DropdownMenuItem<String>(
              value: e.key,
              child: Text(
                e.value,
                style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              controller.updateTeam(val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildVenueDropdown(TeamSheetController controller) {
    final teamMatches = controller.upcomingMatches.where(
      (m) => m.homeTeam.id == controller.selectedTeamId.value || m.awayTeam.id == controller.selectedTeamId.value
    ).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedMatchId.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: teamMatches.map((match) {
            final date = match.matchDate != null ? DateFormat('MMM dd').format(match.matchDate!) : "TBA";
            return DropdownMenuItem<String>(
              value: match.id,
              child: Text(
                "${match.venueName} ($date)",
                style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              controller.updateVenue(val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildFormationDropdown(TeamSheetController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedFormation.value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: controller.formations.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CommonText(text: "$item aside", fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
            );
          }).toList(),
          onChanged: (val) => controller.updateFormation(val!),
        ),
      ),
    );
  }

  Widget _buildFormationCard(TeamSheetController controller) {
    final layout = controller.getFormationLayout();
    int globalIndex = 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
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
                CommonText(
                  text: 'Formation Setup',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                CommonText(
                  text: "${controller.selectedFormation.value} aside",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            child: AspectRatio(
              aspectRatio: 335 / 440,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SvgPicture.asset(
                        AppImages.stadium,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: layout.map((row) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: row.map((pos) {
                                  final currentIndex = globalIndex++;
                                  final playerData = controller.fieldPlayers[currentIndex];
                                  return _buildPlayerNode(
                                    playerData?['initial'],
                                    pos,
                                    name: playerData?['name'],
                                    imageUrl: playerData?['profile'],
                                    index: currentIndex,
                                    controller: controller,
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
    );
  }

  Widget _buildPlayerNode(String? initial, String position, {String? name, String? imageUrl, required int index, required TeamSheetController controller}) {
    bool isEmpty = initial == null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () => _showPlayerSelection(controller, position, index: index),
              child: CustomPaint(
                painter: isEmpty ? DashedCirclePainter(color: Colors.white) : null,
                child: Container(
                  width: 45.w,
                  height: 45.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isEmpty ? Colors.white.withValues(alpha: 0.2) : const Color(0xFFF57C00),
                    border: isEmpty ? null : Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: isEmpty
                      ? const Icon(Icons.add, color: Colors.white, size: 20)
                      : ClipOval(
                          child: CommonImage(
                            imageSrc: imageUrl ?? "",
                            width: 45.w,
                            height: 45.w,
                            fill: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            if (!isEmpty)
              Positioned(
                top: -8.r,
                right: -8.r,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => controller.removePlayer(index),
                  child: Container(
                    padding: EdgeInsets.all(6.r), // Hit area increase
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 12.sp),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4.h),
        SizedBox(
          width: 70.w,
          child: CommonText(
            text: name ?? '',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        CommonText(
          text: position,
          fontSize: 9,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ],
    );
  }

  Widget _buildSubstitutesList(BuildContext context, TeamSheetController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        final playerData = controller.substitutes[index];
        final String subPos = playerData?['pos'] ?? (index == 0 ? 'GK' : 'ST');
        
        return Container(
          width: (MediaQuery.of(context).size.width - 32.w - 36.w) / 4,
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => _showPlayerSelection(controller, subPos, isSub: true, index: index),
                    child: (playerData == null) 
                      ? CustomPaint(
                          painter: DashedCirclePainter(color: Colors.grey.shade400),
                          child: Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            child: const Icon(Icons.add, color: Colors.black54, size: 18),
                          ),
                        )
                      : CircleAvatar(
                          radius: 18.r,
                          backgroundColor: const Color(0xFFF57C00),
                          child: ClipOval(
                            child: CommonImage(
                              imageSrc: playerData['profile'] ?? "",
                              width: 36.w,
                              height: 36.w,
                              fill: BoxFit.cover,
                            ),
                          ),
                        ),
                  ),
                  if (playerData != null)
                    Positioned(
                      top: -8.r,
                      right: -8.r,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => controller.removePlayer(index, isSub: true),
                        child: Container(
                          padding: EdgeInsets.all(6.r), // Hit area increase
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close, color: Colors.white, size: 10.sp),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: playerData?['name'] ?? subPos,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              CommonText(
                text: playerData != null ? (playerData['pos'] ?? '') : '', 
                fontSize: 9, 
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildConfirmButton(TeamSheetController controller) {
    return Container(
      width: double.infinity,
      height: 54.h,
      margin: EdgeInsets.only(bottom: 20.h),
      child: ElevatedButton(
        onPressed: controller.isSubmitting.value ? null : () => controller.confirmLineup(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
        child: controller.isSubmitting.value
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : CommonText(
                text: controller.existingSelectionId.isNotEmpty ? 'Update Selection' : 'Confirm Selection',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
      ),
    );
  }

  void _showPlayerSelection(TeamSheetController controller, String position, {bool isSub = false, required int index}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.65,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: 'Select Player for $position', fontSize: 18, fontWeight: FontWeight.w700),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                if (controller.isSquadLoading.value) {
                  return const ShimmerListLoading();
                }

                if (controller.filteredSquad.isEmpty) {
                  return const Center(child: Text("No players found in squad."));
                }

                return ListView.separated(
                  itemCount: controller.filteredSquad.length,
                  separatorBuilder: (context, i) => Divider(height: 1.h, color: Colors.grey.withValues(alpha: 0.2)),
                  itemBuilder: (context, i) {
                    final p = controller.filteredSquad[i];
                    final fullName = "${p['firstName'] ?? ""} ${p['lastName'] ?? ""}".trim();
                    final image = p['profile'] ?? "";
                    
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.iconBgYellow,
                        child: ClipOval(
                          child: CommonImage(
                            imageSrc: image,
                            width: 40.w,
                            height: 40.w,
                            fill: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: CommonText(
                        text: fullName.isNotEmpty ? fullName : (p['userName'] ?? "Player"), 
                        textAlign: TextAlign.start, 
                        fontWeight: FontWeight.w600, 
                        fontSize: 15,
                      ),
                      subtitle: CommonText(
                        text: 'Position: ${p['position'] ?? "N/A"}', 
                        textAlign: TextAlign.start, 
                        fontSize: 12, 
                        color: Colors.grey,
                      ),
                      onTap: () {
                        controller.assignPlayer(index, p, isSub: isSub);
                        Get.back();
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashWidth = 4,
    this.dashSpace = 3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    double currentAngle = 0;
    final double totalLength = 2 * pi * radius;
    final double angleStep = (dashWidth + dashSpace) / totalLength * 2 * pi;
    final double dashAngle = dashWidth / totalLength * 2 * pi;

    while (currentAngle < 2 * pi) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        dashAngle,
        false,
        paint,
      );
      currentAngle += angleStep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
