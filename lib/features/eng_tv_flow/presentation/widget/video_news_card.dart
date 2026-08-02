import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/video/dynamic_video_thumbnail.dart';

import 'package:intl/intl.dart';

class VideoNewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String timeAgo;
  final String imageUrl;
  final String? videoUrl; 

  const VideoNewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.imageUrl,
    this.videoUrl, 
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = timeAgo;
    try {
      DateTime dt = DateTime.parse(timeAgo);
      formattedDate = DateFormat('MMM dd, yyyy').format(dt);
    } catch (_) {}

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: DynamicVideoThumbnail(
                      videoUrl: videoUrl ?? "",
                      thumbnailUrl: imageUrl,
                      width: 130.w,
                      height: 74.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.r),
                    height: 18.h,
                    width: 18.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: description,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color6B6B6B,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 12.sp, color: AppColors.color6B6B6B),
                        SizedBox(width: 4.w),
                        CommonText(
                          text: formattedDate,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color6B6B6B,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 1.h,
            color: Colors.grey.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }
}
