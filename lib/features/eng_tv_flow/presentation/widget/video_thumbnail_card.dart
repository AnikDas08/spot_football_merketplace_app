import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../../../component/text/common_text.dart';

class VideoThumbnailCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String duration;
  final VoidCallback onWatchNow;

  // Hard-coded strings converted to constant variables
  static const String labelVideo = "Video";
  static const String labelWatchNow = "Watch Now";

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
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(thumbnail),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
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
                    Colors.white.withValues(alpha: 0.7),
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
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: labelVideo, // Static Variable
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.circle, size: 8.sp, color: AppColors.yellow),
                    SizedBox(width: 8.w),
                    CommonText(
                      text: duration, // From API
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                CommonButton(
                  onTap: onWatchNow,
                  titleText: labelWatchNow, // Static Variable
                  titleWeight: FontWeight.w500,
                  titleSize: 18,
                  buttonHeight: 48,
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
    );
  }
}