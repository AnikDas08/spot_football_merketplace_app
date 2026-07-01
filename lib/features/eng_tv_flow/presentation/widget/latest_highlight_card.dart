import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class LatestHighlightCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? leagueName;
  final String time;
  final bool isCheck;
  final String source;
  final String duration;

  const LatestHighlightCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.source,
    required this.duration, 
    required this.isCheck, 
    this.leagueName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 186.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CommonImage(
                imageSrc: imagePath,
                height: 125.h,
                width: 160.w,
                fill: BoxFit.cover,
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CommonText(
                    text: duration,
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: CommonText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              maxLines: 1,
              color: AppColors.primaryColor,
            ),
          ),

         isCheck? Padding(
           padding: EdgeInsets.symmetric(horizontal: 8.w),
           child: CommonText(
              text: "$time - $source",
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color6B6B6B,
            ),
         ):Padding(
           padding: EdgeInsets.symmetric(horizontal: 8.w),
           child: CommonText(
             text: leagueName??"",
             fontSize: 14.sp,
             fontWeight: FontWeight.w600,
             color: AppColors.primaryColor,
             maxLines: 1,
           ),
         ),
        ],
      ),
    );
  }
}
