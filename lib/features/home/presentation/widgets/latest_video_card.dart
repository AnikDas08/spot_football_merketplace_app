import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

class LatestVideoCard extends StatelessWidget {
  const LatestVideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.videoStreamScreen);
      },
      child: Card(
        color: AppColors.white,
        child: Container(
          padding: .all(10),
          child: Row(
            crossAxisAlignment: .start,
            spacing: 10,
            children: [
              Stack(
                alignment: .bottomLeft,
                children: [
                  Image.asset(TempImage.videoThumbnail),
                  Positioned(
                    child: Container(
                      padding: .all(2),
                      width: 50.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: .only(
                          topRight: .circular(5.37.r),
                          bottomLeft: .circular(6.71.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            color: AppColors.white,
                            size: 18,
                          ),
                          CommonText(
                            text: "01:52",
                            color: AppColors.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(height: 10.h),
                    CommonText(
                      textAlign: .start,
                      maxLines: 2,
                      text: AppString.thingsYouMayHaveMissedFromMatchweek20,
                      fontSize: 16.sp,
                      fontWeight: FontWeight(510),
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
