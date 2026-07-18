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
          borderRadius: BorderRadius.circular(14),
          child: Stack(

            fit: StackFit.expand,

            children: [

              Image.network(
                "${ApiEndPoint.imageUrl}${videoModel.thumbnail}", // Fallback or if videoUrl can be used for thumbnail
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.network(
                   'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty-300x240.jpg',
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
                      fontSize: 14,
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),

                    SizedBox(height: 2.h),


                    CommonText(
                      text: videoModel.category,
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),


                    SizedBox(height: 4.h),

                    CommonText(
                      text: videoModel.status,
                      color: AppColors.white,
                      fontSize: 14,
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
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppColors.colorEABB00,
                            width: 1.2,
                          ),
                        ),
                        child: CommonText(
                          text: AppString.watchEngLive,
                          color: AppColors.white,
                          fontSize: 12,
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
