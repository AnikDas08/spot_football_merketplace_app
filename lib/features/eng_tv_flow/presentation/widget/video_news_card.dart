import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../component/video/dynamic_video_thumbnail.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
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
                    child: DynamicVideoThumbnail(
                      videoUrl: videoUrl ?? "",
                      thumbnailUrl: imageUrl,
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
                      color: Colors.black.withValues(alpha: 0.8),
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
            text: description,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: timeAgo,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 1.h,
            decoration: const BoxDecoration(color: Color(0xFFF3F3F3)),
          ),
        ],
      ),
    );
  }
}
