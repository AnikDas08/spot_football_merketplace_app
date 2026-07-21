import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class PlayerStatCard extends StatelessWidget {
  final String playerImageUrl;
  final String statLabel;
  final String statValue;
  final String? playerName;

  const PlayerStatCard({
    super.key,
    required this.playerImageUrl,
    required this.statLabel,
    required this.statValue,
    this.playerName,
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
              color: const Color(0xFFF5F5F5),
            ),
            child: CommonImage(
              imageSrc: playerImageUrl,
              width: double.infinity,
              height: 136.h,
              fill: BoxFit.cover,
            ),
          ),

          SizedBox(height: 6.h),

          Column(
            children: [
              if (playerName != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: CommonText(
                    text: playerName!,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              CommonText(
                text: statLabel,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.color6B6B6B,
              ),

              SizedBox(height: 2.h),

              CommonText(
                text: statValue,
                fontSize: 24,
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
