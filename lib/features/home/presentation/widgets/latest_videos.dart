import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/config/api/api_end_point.dart';

import '../controllers/banner_controller.dart';

class LatestVideos extends StatelessWidget {
  const LatestVideos({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.find<BannerController>();

    return Obx(() {
      if (bannerController.isLoading.value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 220.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w),
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemBuilder: (context, index) => CustomShimmer.rectangular(
                  height: 220.h,
                  width: 170.w,
                ),
              ),
            ),
          ],
        );
      }

      if (bannerController.bannerVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CommonText(
              text: AppString.latestVideos.toUpperCase(),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 220.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: bannerController.bannerVideos.length,
              padding: EdgeInsets.only(left: 16.w),
              itemBuilder: (context, index) {
                final video = bannerController.bannerVideos[index];
                return LatestVideoCard(
                  videoId: video.id,
                  imageHeight: 130.h,
                  titleFontSize: 14.sp,
                  timeFontSize: 14.sp,
                  imagePath: video.videoUrl.isNotEmpty 
                      ? "${ApiEndPoint.imageUrl}${video.thumbnail}"
                      : 'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600',
                  title: video.title,
                  time: video.publishDateTime, // Or format it if needed
                  duration: "7:00", // Hardcoded as API doesn't provide it
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 12.w);
              },
            ),
          ),
        ],
      );
    });
  }
}
