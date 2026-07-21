import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';

class EngRecordWidget extends StatelessWidget {
  final Map<String, dynamic>? stats;

  const EngRecordWidget({super.key, this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats == null) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.engRecord,
            fontSize: 20,
            fontWeight: const FontWeight(650),
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 16.h),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.2,
            children: [
              _RecordCard(
                svgIcon: AppImages.goal,
                title: 'GOALS',
                value: '${stats!['goals'] ?? 0}',
                sub: 'Lifetime',
                color: AppColors.yellow,
              ),
              _RecordCard(
                title: 'ASSISTS',
                value: '${stats!['assists'] ?? 0}',
                sub: 'Lifetime',
                color: AppColors.yellow,
                svgIcon: AppImages.assist,
              ),
              _RecordCard(
                svgIcon: AppImages.matches,
                title: 'YELLOW CARDS',
                value: '${stats!['yellowCards'] ?? 0}',
                sub: 'Total',
                color: AppColors.yellow,
              ),
              _RecordCard(
                svgIcon: AppImages.rating,
                title: 'RED CARDS',
                value: '${stats!['redCards'] ?? 0}',
                sub: 'Total',
                color: AppColors.red,
                textColor: AppColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final Color color;
  final Color? textColor;
  final String svgIcon;

  const _RecordCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.color,
    this.textColor,
    required this.svgIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              svgIcon,
              colorFilter: const ColorFilter.mode(
                AppColors.background,
                BlendMode.srcIn,
              ),
              width: 80.w,
              height: 80.h,
            ),
          ),
        ),
        Container(
          width: 1.sw,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: color, width: 4.h),
            ),
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: title,
                fontSize: 10,
                color: AppColors.textSecondaryColor,
                fontWeight: const FontWeight(590),
              ),
              SizedBox(height: 6.h),
              CommonText(
                text: value,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: textColor ?? AppColors.primaryColor,
              ),
              const Spacer(),
              CommonText(
                text: sub,
                fontSize: 12,
                fontWeight: const FontWeight(590),
                color: color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
