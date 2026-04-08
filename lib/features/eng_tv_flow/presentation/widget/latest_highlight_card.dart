import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import '../../../../component/text/common_text.dart'; // Apnar project-er common text

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
    required this.duration, required this.isCheck, this.leagueName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      height: 186.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                child: Image.asset(
                  imagePath,
                  height: 132.h,
                  width: 160.w,
                  fit: BoxFit.cover,
                ),
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

          CommonText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            color: AppColors.primaryColor,
          ),

         isCheck? CommonText(
            text: "$time - $source",
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
          ):CommonText(
           text: leagueName??"",
           fontSize: 14.sp,
           fontWeight: FontWeight.w600,
           color: AppColors.primaryColor,
           maxLines: 1,
         ),
        ],
      ),
    );
  }
}
