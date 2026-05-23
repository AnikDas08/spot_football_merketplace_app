import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class PlayerStatCard extends StatelessWidget {
  final String playerImageUrl;
  final String statLabel;
  final String statValue;

  const PlayerStatCard({
    super.key,
    required this.playerImageUrl,
    required this.statLabel,
    required this.statValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 136.h,
            decoration: BoxDecoration(
              color:  Color(0xFFF5F5F5),
            ),
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              child: Image.asset(playerImageUrl),
            ),
          ),

          SizedBox(height: 6.h),

          Column(
            children: [
              CommonText(
                text: statLabel,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,

                color: AppColors.color6B6B6B,
              ),

              SizedBox(height: 2.h),

              CommonText(
                text: statValue,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
