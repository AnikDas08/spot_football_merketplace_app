import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/home/data/slider_model.dart';
import 'package:untitled/features/navbar/controller/navbar_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../utils/constants/app_images.dart';

class BannerCard extends StatelessWidget {
  final SliderModel sliderModel;
  const BannerCard({super.key, required this.sliderModel});

  @override
  Widget build(BuildContext context) {
    final NavBarController navBarController = Get.find<NavBarController>();
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.videoStreamScreen);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.colorEABB00, width: 2.5.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.asset(
                TempImage.banner,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: AppColors.colorCCCCCC),
              ),

              // Dark gradient overlay
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
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),

              // Text content
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonText(
                      text: sliderModel.title,
                      fontSize: 14.sp,
                      color: AppColors.white,
                      fontWeight: .w800,
                    ),
                    SizedBox(height: 2.h),
                    CommonText(
                      text: sliderModel.subtitle,
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: .w600,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: sliderModel.countdown,
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: .w800,
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.videoStreamScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
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
