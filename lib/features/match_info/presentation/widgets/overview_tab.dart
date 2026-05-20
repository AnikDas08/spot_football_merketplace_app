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

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final matchController = Get.find<MatchInfoController>();

    return Obx(() {
      final match = matchController.match.value;
      if (match == null) return const SizedBox.shrink();

      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
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
                    value: match.venueName ?? "Unknown Venue",
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
                          text: '4-3-3',
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
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _PlayerNode(initial: 'S', name: 'Striker', position: 'ST'),
                                  _PlayerNode(initial: 'S', name: 'Striker', position: 'ST'),
                                  _PlayerNode(initial: 'S', name: 'Striker', position: 'ST'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _PlayerNode(initial: 'M', name: 'Mid', position: 'CM'),
                                  _PlayerNode(initial: 'M', name: 'Mid', position: 'CM'),
                                  _PlayerNode(initial: 'M', name: 'Mid', position: 'CM'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _PlayerNode(initial: 'D', name: 'Def', position: 'CB'),
                                  _PlayerNode(initial: 'D', name: 'Def', position: 'CB'),
                                  _PlayerNode(initial: 'D', name: 'Def', position: 'CB'),
                                  _PlayerNode(initial: 'D', name: 'Def', position: 'CB'),
                                ],
                              ),
                              _PlayerNode(initial: 'G', name: 'Keeper', position: 'GK'),
                            ],
                          ),
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

  const _PlayerNode({
    required this.initial,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 45.w,
          height: 45.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFA726), Color(0xFFFB8C00)],
            ),
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: Center(
            child: CommonText(
              text: initial,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: name,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        CommonText(
          text: position,
          fontSize: 8.sp,
          color: AppColors.white.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}
