import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class VideoNewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String timeAgo;
  final String imageUrl;
  final VoidCallback? onTap;

  const VideoNewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CommonText(
                    text: title.toUpperCase(),

                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,

                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),

                SizedBox(width: 16.w),

                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.asset(
                        imageUrl,
                        width: 120.w,
                        height: 66.h,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(4.r),
                      height: 14.h,
                      width: 21.w,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 12.sp,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 8.h),
            CommonText(
              text: description.toUpperCase(),

              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color6B6B6B,

              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),

            SizedBox(height: 8.h),
            CommonText(
              text: timeAgo.toUpperCase(),

              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.color6B6B6B,

              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Container(
              height: 1.h,
              decoration: BoxDecoration(color: Color(0xFFF3F3F3)),
            ),

          ],
        ),
      ),
    );
  }
}
