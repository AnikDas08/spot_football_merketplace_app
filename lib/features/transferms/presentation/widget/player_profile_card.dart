import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class PlayerProfileCard extends StatelessWidget {
  final String playerName;
  final String playerRole;
  final String playerAcademy;
  final String playerImageUrl;
  final bool isCheckCard;

  const PlayerProfileCard({
    super.key,
    required this.playerName,
    required this.playerRole,
    required this.playerAcademy,
    required this.playerImageUrl, required this.isCheckCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(playerImageUrl, fit: BoxFit.contain),
            ),
          ),

          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              // Takes minimal height necessary specs
              children: [
                CommonText(
                  text: playerName,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),

                SizedBox(height: 5.h),

                CommonText(
                  text: "$playerRole | $playerAcademy",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),





        ],
      ),
    );
  }
}
