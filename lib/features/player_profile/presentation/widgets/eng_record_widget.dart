import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

import '../../../../utils/constants/app_string.dart';

class EngRecordWidget extends StatelessWidget {
  const EngRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
            fontSize: 20.sp,
            fontWeight: FontWeight(650),
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
            children: const [
              _RecordCard(
                svgIcon: AppImages.goal,
                title: 'GOALS',
                value: '24',
                sub: '+3 this month',
                color: AppColors.yellow,
              ),
              _RecordCard(
                title: 'ASSISTS',
                value: '12',
                sub: 'Top 5% League',
                color: AppColors.yellow,
                svgIcon: AppImages.assist,
              ),
              _RecordCard(
                svgIcon: AppImages.matches,

                title: 'MATCHES',
                value: '18',
                sub: '1,620 mins',
                color: AppColors.yellow,
              ),
              _RecordCard(
                svgIcon: AppImages.rating,
                title: 'AVG RATING',
                value: '8.5',
                sub: 'MVP Form',
                color: AppColors.green,
                textColor: AppColors.yellow,
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
      alignment: .bottomRight,
      children: [
        Positioned(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: SvgPicture.asset(
                svgIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.background,
                  BlendMode.srcIn,
                ),
                width: 80.w,
                height: 80.h,
              ),
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
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight(590),
              ),
              SizedBox(height: 6.h),
              CommonText(
                text: value,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                color: textColor ?? AppColors.primaryColor,
              ),
              const Spacer(),
              CommonText(
                text: sub,
                fontSize: 12.sp,
                fontWeight: FontWeight(590),
                color: AppColors.yellow,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
