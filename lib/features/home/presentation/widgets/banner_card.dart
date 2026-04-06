import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/data/slider_model.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

import '../../../../utils/constants/app_images.dart';

class BannerCard extends StatelessWidget {
  final SliderModel sliderModel;
  const BannerCard({super.key, required this.sliderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 0),
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
              AppImages.banner,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(color: Colors.grey[900]),
            ),

            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.75),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1.2,
                      ),
                    ),

                    child: CommonText(
                      text: AppString.watchEngLive,
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
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
