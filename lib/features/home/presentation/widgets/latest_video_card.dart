import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class LatestVideoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String duration;
  final double? width;
  final double? imageHeight;
  final double? titleFontSize;
  final double? timeFontSize;

  const LatestVideoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.duration,
    this.width,
    this.imageHeight,
    this.titleFontSize,
    this.timeFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.videoStreamScreen);
      },
      child: SizedBox(
        width: width ?? 170.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CommonImage(
                  imageSrc: imagePath,
                  width: width ?? MediaQuery.of(context).size.width,
                  height: imageHeight ?? 220.h,
                  fill: BoxFit.cover,
                  borderRadius: 12.r,
                ),
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 20,
                    color: AppColors.black,
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  right: 12.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: CommonText(
                      text: duration,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    textAlign: .start,
                    text: title,
                    fontSize: titleFontSize ?? 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    textAlign: .start,
                    text: time,
                    fontSize: timeFontSize ?? 10.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color6B6B6B,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
