import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../data/video_model.dart';
import '../../../../component/video/dynamic_video_thumbnail.dart';
import '../../../../utils/helpers/video_metadata_helper.dart';

class BannerCard extends StatelessWidget {
  final VideoModel videoModel;

  const BannerCard({
    super.key,
    required this.videoModel,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedCategory = VideoMetadataHelper.formatCategory(videoModel.category);

    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.videoStreamScreen, arguments: videoModel.id);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 5, bottom: 8, top: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.colorEABB00, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DynamicVideoThumbnail(
                videoUrl: "${ApiEndPoint.videoUrl}${videoModel.videoUrl}",
                thumbnailUrl: videoModel.thumbnail.isNotEmpty
                    ? "${ApiEndPoint.imageUrl}${videoModel.thumbnail}"
                    : '',
                fit: BoxFit.cover,
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
                left: 16.w,
                right: 16.w,
                bottom: 16.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: videoModel.title,
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: formattedCategory,
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.videoStreamScreen,
                            arguments: videoModel.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: AppColors.colorEABB00,
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          AppString.watchEngLive,
                          style: GoogleFonts.montserrat(
                            color: AppColors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
