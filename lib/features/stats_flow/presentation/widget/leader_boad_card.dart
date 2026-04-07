import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_images.dart';

class LeaderboardItemData {
  final String rank;
  final String name;
  final String academy;
  final String academyPhoto;
  final String score;

  LeaderboardItemData({
    required this.rank,
    required this.name,
    required this.academy,
    required this.score, required this.academyPhoto,
  });
}

class LeaderboardCard extends StatelessWidget {
  final String topPlayerName;
  final String topPlayerAcademy;
  final String topPlayerScore;
  final String? topPlayerImage;
  final List<LeaderboardItemData> otherPlayers;
  final VoidCallback onViewFullList;
  final String academyPhoto;

  const LeaderboardCard({
    super.key,
    required this.topPlayerName,
    required this.topPlayerAcademy,
    required this.topPlayerScore,
    this.topPlayerImage,
    required this.otherPlayers,
    required this.onViewFullList,
    required this.academyPhoto,
  });

  @override
  Widget build(BuildContext context) {
    const String strViewFullList = "View Full List";

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, right: 1.w, top: 16.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.playerSeason),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text: "1",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4.h),
                        CommonText(
                          text: topPlayerName,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 6.r,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.asset(
                                  academyPhoto,
                                  fit: BoxFit.cover,
                                  height: 12.h,
                                  width: 12.w,
                                ),
                              ),
                            ),
                            SizedBox(width: 3.w),
                            CommonText(
                              text: topPlayerAcademy,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white, // AppColors.white
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        CommonText(
                          text: topPlayerScore,
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                if (topPlayerImage != null)
                  Container(
                    width: 117.w,
                    height: 120.h,
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        topPlayerImage!,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: otherPlayers
                  .map((player) => _buildPlayerRow(player))
                  .toList(),
            ),
          ),

          // 3. View Full List Button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: OutlinedButton(
              onPressed: onViewFullList,
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                side: BorderSide(color: Colors.grey.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: CommonText(
                text: strViewFullList,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(LeaderboardItemData player) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          CommonText(
            text: player.rank,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(width: 12.w),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            academyPhoto,
            fit: BoxFit.cover,
            height: 24.h,
            width: 24.w,
          ),
        ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: player.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                CommonText(
                  text: player.academy,
                  fontSize: 14.sp,
                  color: AppColors.color6B6B6B,
                ),
              ],
            ),
          ),
          CommonText(
            text: player.score,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
