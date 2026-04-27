import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';


import 'package:untitled/utils/constants/app_icons.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        spacing: 12,
        children: [
          // Key Events
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                CommonText(
                  text: AppString.keyEvents,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                _KeyEventRow(
                  iconImage: TempImage.football,
                  iconColor: AppColors.color6B6B6B,
                  playerName: AppString.mVane,
                  description: AppString.clinialFinishFromTheBox,
                  minute: "62'",
                ),
                Divider(color: AppColors.colorCCCCCC, height: 1),
                _KeyEventRow(
                  iconImage: TempImage.football1,
                  iconColor: AppColors.color19CA77,
                  playerName: AppString.kTanaka,
                  description: AppString.tacticalFoulInMidfield,
                  minute: "41'",
                ),
              ],
            ),
          ),

          // Match Summary
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                CommonText(
                  text: AppString.matchSummary,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
                CommonText(
                  maxLines: 4,
                  textAlign: .start,
                  text: AppString.theTitans,
                  fontSize: 12.sp,
                  fontWeight: FontWeight(510),
                  color: AppColors.primaryColor,
                ),
                // Expert Insight
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border(
                      left: BorderSide(
                        color: AppColors.color19CA77,
                        width: 3.w,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      CommonText(
                        text: AppString.expertInsight,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                      CommonText(
                        text: AppString.expectedGoals,
                        fontSize: 13.sp,
                        fontWeight: FontWeight(510),
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

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
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
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
                        text: '4-3-3 Attacking',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: .circular(12.r)
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: AspectRatio(
                    aspectRatio: 335 / 440,
                    child: Stack(
                      children: [
                        // Background Stadium SVG
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: SvgPicture.asset(
                             AppImages.stadium,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Players
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Forwards (Row 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _PlayerNode(initial: 'M', name: 'Marcus', position: 'ST'),
                                _PlayerNode(initial: 'J', name: 'James', position: 'ST'),
                                _PlayerNode(initial: 'R', name: 'Ryan', position: 'ST'),
                                _PlayerNode(initial: 'D', name: 'David', position: 'ST'),
                              ],
                            ),
                            // Midfielders (Row 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _PlayerNode(initial: 'T', name: 'Tom', position: 'CM'),
                                _PlayerNode(initial: 'C', name: 'Chris', position: 'CM'),
                                _PlayerNode(initial: 'T', name: 'Tom', position: 'CM'),
                              ],
                            ),
                            // Defenders (Row 3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _PlayerNode(initial: 'B', name: 'Ben', position: 'CB'),
                                _PlayerNode(initial: 'T', name: 'Tom', position: 'CB'),
                                _PlayerNode(initial: 'J', name: 'Jake', position: 'CB'),
                              ],
                            ),
                            // Goalkeeper (Row 4)
                            _PlayerNode(initial: 'M', name: 'Mike', position: 'GK'),
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
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
      child: child,
    );
  }
}

class _KeyEventRow extends StatelessWidget {
  final String iconImage;
  final Color iconColor;
  final String playerName;
  final String description;
  final String minute;

  const _KeyEventRow({
    required this.iconColor,
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
            color: iconColor.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconImage),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
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
                fontWeight: FontWeight.w400,
                color: AppColors.colorCCCCCC,
              ),
            ],
          ),
        ),
        CommonText(
          text: minute,
          fontSize: 14.sp,
          fontWeight: FontWeight(590),
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class _FormationRow extends StatelessWidget {
  final List<String> positions;
  final int? highlightIndex;

  const _FormationRow({required this.positions, this.highlightIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(positions.length, (index) {
        final isHighlighted = highlightIndex == index;
        return Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: isHighlighted
                ? AppColors.colorEABB00
                : const Color(0xFF6C63FF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CommonText(
              text: positions[index],
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        );
      }),
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
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFA726),
                Color(0xFFFB8C00),
              ],
            ),
            border: Border.all(color: AppColors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: CommonText(
              text: initial,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: name,
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        CommonText(
          text: position,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white.withOpacity(0.8),
        ),
      ],
    );
  }
}

