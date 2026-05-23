import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../data/event_response.dart';

class UpcomingEventCard extends StatelessWidget {
  final EventModel event;
  const UpcomingEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String imageUrl = event.image;
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = '${ApiEndPoint.imageUrl}$imageUrl';
    }

    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: double.infinity,
                  height: 270.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CustomShimmer.rectangular(
                    height: 270.h,
                    width: double.infinity,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 270.h,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CommonText(
                    text: AppString.limitedSlots,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          CommonText(
            text: event.title,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          CommonText(
            text: event.location,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: CommonText(
              text: AppString.viewDetails,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
