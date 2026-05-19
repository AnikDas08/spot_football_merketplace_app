import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/home/data/video_model.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/config/api/api_end_point.dart';

class BannerCard extends StatelessWidget {
  final VideoModel videoModel;
  const BannerCard({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.videoStreamScreen, arguments: videoModel.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.colorEABB00, width: 2.5.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Assuming the video has a thumbnail or using a placeholder since API didn't show thumbnail field
              Image.network(
                "${ApiEndPoint.imageUrl}${videoModel.videoUrl}", // Fallback or if videoUrl can be used for thumbnail
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                   'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600',
                   fit: BoxFit.cover,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.transparent,
                      AppColors.black.withAlpha(76),
                      AppColors.black.withAlpha(191),
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),

              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: videoModel.title,
                      fontSize: 14.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: videoModel.category,
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: videoModel.status,
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                         Get.toNamed(AppRoutes.videoStreamScreen, arguments: videoModel.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withAlpha(38),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.white.withAlpha(153),
                            width: 1.2,
                          ),
                        ),
                        child: CommonText(
                          text: AppString.watchEngLive,
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
