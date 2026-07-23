import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';

class LatestVideoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String category;
  final String description;
  final String time;
  final String duration;
  final String? videoId;
  final double? width;
  final double? height;
  final bool isLoading;

  const LatestVideoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.category,
    required this.description,
    required this.time,
    required this.duration,
    this.videoId,
    this.width,
    this.height,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: width ?? double.infinity,
        height: height ?? 450.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.grey.shade200,
        ),
        child: CustomShimmer.rectangular(
          height: height ?? 450.h,
          width: width ?? double.infinity,
        ),
      );
    }

    return Container(
      width: width ?? double.infinity,
      height: height ?? 450.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: CommonImage(
                imageSrc: imagePath,
                width: double.infinity,
                height: double.infinity,
                fill: BoxFit.cover,
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.95),
                    ],
                    stops: const [0.4, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            /// Play Button in Center
            Center(
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ),

            /// Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Info Row (Category & Time)
                  CommonText(
                    text: "$category  •  $time",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                  SizedBox(height: 8.h),

                  /// Title
                  CommonText(
                    text: title,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'PlayfairDisplay',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    bottom: 12.h,
                  ),

                  /// Description
                  CommonText(
                    text: description,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.8),
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    bottom: 24.h,
                  ),

                  /// Watch Button
                  GestureDetector(
                    onTap: () {
                      if (videoId != null) {
                        Get.toNamed(AppRoutes.videoStreamScreen, arguments: videoId);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor, // Reverted to Primary Black
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppString.labelWatchNow,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
