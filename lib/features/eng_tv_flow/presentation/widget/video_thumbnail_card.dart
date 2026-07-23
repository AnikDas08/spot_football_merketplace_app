import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../component/button/common_button.dart';
import '../../../../component/text/common_text.dart';

import '../../../../component/image/common_image.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';

class VideoThumbnailCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String duration;
  final VoidCallback onWatchNow;

  const VideoThumbnailCard({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.duration,
    required this.onWatchNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: Stack(
          children: [
            Positioned.fill(
              child: CommonImage(
                imageSrc: thumbnail,
                fill: BoxFit.cover,
              ),
            ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonText(
                  text: title, // From API
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: 'PlayfairDisplay',
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text:AppString. labelVideo, // Static Variable
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.circle, size: 6.sp, color: AppColors.yellow),
                    SizedBox(width: 8.w),
                    CommonText(
                      text: duration, // From API
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                CommonButton(
                  onTap: onWatchNow,
                  titleText: AppString. labelWatchNow, // Static Variable
                  titleWeight: FontWeight.w700,
                  titleSize: 14,
                  buttonHeight: 50,
                  buttonRadius: 16,
                  // Reverted to default Primary Black
                ),
              ],
            ),
          ),

          // Play Icon
          Positioned(
            top: 12.h,
            left: 12.w,
            child: SvgPicture.asset(
              AppIcons.play,
              height: 40.sp,
              width: 40.w,
            ),
          ),
        ],
      ),
    ));
  }
}