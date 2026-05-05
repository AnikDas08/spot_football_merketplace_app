import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/temp_image.dart';
import '../controller/team_sheet_controller.dart';

class TeamSheetScreen extends StatelessWidget {
  const TeamSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TeamSheetController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SecondaryAppBar(title: 'TEAM SHEET'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() => _buildHeroBanner(controller)),
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
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 8.h),
                            Obx(() => _buildDropdown(
                                controller.selectedTeam.value,
                                controller.teams,
                                    (val) => controller.updateTeam(val!))),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: 'FORMATION SETUP',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 8.h),
                            Obx(() => _buildDropdown(
                                controller.selectedFormation.value,
                                controller.formations,
                                    (val) => controller.updateFormation(val!))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Obx(() => _buildFormationCard(controller)),
                  SizedBox(height: 24.h),
                  CommonText(
                    text: 'SUBSTITUTES',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 16.h),
                  Obx(() => _buildSubstitutesList(context, controller)),
                  SizedBox(height: 32.h),
                  _buildConfirmButton(controller),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(TeamSheetController controller) {
    return Container(
      width: double.infinity,
      height: 220.h,
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
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: AppColors.white.withAlpha(400),
                      width: 1.5.w,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: 'Team Sheet',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: controller.selectedFormation.value,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      maxLines: 2,
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

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CommonText(text: item, fontSize: 14.sp, color: Colors.black),
            );
          }).toList(),
          onChanged: onChanged,
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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Formation Setup',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                CommonText(
                  text: controller.selectedFormation.value,
                  fontSize: 16.sp,
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
                          final playerData = controller.currentLineup[currentIndex];
                          return _buildPlayerNode(
                            playerData?['initial'],
                            pos,
                            name: playerData?['name'],
                            onTap: () => _showPlayerSelection(controller, pos, index: currentIndex),
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

  Widget _buildPlayerNode(String? initial, String position, {String? name, required VoidCallback onTap}) {
    bool isEmpty = initial == null;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(
            painter: isEmpty ? DashedCirclePainter(color: Colors.white) : null,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isEmpty ? Colors.white.withOpacity(0.2) : const Color(0xFFF57C00),
                border: isEmpty ? null : Border.all(color: Colors.white, width: 1.5),
              ),
              child: isEmpty
                  ? const Icon(Icons.add, color: Colors.white, size: 22)
                  : Center(
                child: CommonText(
                  text: initial,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: name ?? '',
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            maxLines: 1,
          ),
          CommonText(
            text: position,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  Widget _buildSubstitutesList(BuildContext context, TeamSheetController controller) {
    final List<String> subPos = ['ST', 'CM', 'CB', 'GK'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(subPos.length, (index) {
        final playerData = controller.substitutes[index];
        return GestureDetector(
          onTap: () => _showPlayerSelection(controller, subPos[index], isSub: true, index: index),
          child: Container(
            width: (MediaQuery.of(context).size.width - 32.w - 36.w) / 4,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (playerData == null) ...[
                  CustomPaint(
                    painter: DashedCirclePainter(color: Colors.grey.shade400),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: const Icon(Icons.add, color: Colors.black54, size: 20),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CommonText(text: subPos[index], fontSize: 13.sp, fontWeight: FontWeight.w700),
                ] else ...[
                  CircleAvatar(
                    radius: 18.r,
                    backgroundColor: const Color(0xFFF57C00),
                    child: CommonText(
                      text: playerData['initial']!,
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  CommonText(
                    text: playerData['name']!,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                  ),
                  CommonText(text: playerData['pos']!, fontSize: 10.sp, color: Colors.grey),
                ],
              ],
            ),
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
        onPressed: () => controller.confirmLineup(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
        child: CommonText(
          text: 'Confirm Lineup',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showPlayerSelection(TeamSheetController controller, String position, {bool isSub = false, required int index}) {
    Get.bottomSheet(
      Container(
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
                CommonText(text: 'Select Player for $position', fontSize: 18.sp, fontWeight: FontWeight.w700),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: controller.roster.length,
                separatorBuilder: (context, i) => Divider(height: 1.h, color: Colors.grey.withOpacity(0.2)),
                itemBuilder: (context, i) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.iconBgYellow,
                      child: CommonText(text: controller.roster[i]['initial']!, fontWeight: FontWeight.w700, color: Colors.black87),
                    ),
                    title: CommonText(text: controller.roster[i]['name']!, textAlign: TextAlign.start, fontWeight: FontWeight.w600, fontSize: 15.sp),
                    subtitle: CommonText(text: 'Position: ${controller.roster[i]['pos']}', textAlign: TextAlign.start, fontSize: 12.sp, color: Colors.grey),
                    onTap: () {
                      controller.assignPlayer(index, controller.roster[i], isSub: isSub);
                      Get.back();
                    },
                  );
                },
              ),
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
