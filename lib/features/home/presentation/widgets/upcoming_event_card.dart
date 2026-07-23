import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../data/event_response.dart';

class UpcomingEventCard extends StatelessWidget {
  final EventModel? event;
  final bool isLoading;

  const UpcomingEventCard({super.key, this.event, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading || event == null) {
      return Container(
        width: double.infinity,
        height: 450.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: Colors.grey.shade200,
        ),
      );
    }

    String imageUrl = event!.image;
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      imageUrl = '${ApiEndPoint.imageUrl}$imageUrl';
    }

    return Container(
      width: double.infinity,
      height: 450.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            /// Background Image
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
                ),
              ),
            ),

            /// Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.95),
                    ],
                    stops: const [0.4, 0.6, 1.0],
                  ),
                ),
              ),
            ),

            /// Content
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// Badge / Label
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.colorEABB00,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const CommonText(
                      text: "Upcoming event",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  /// Title
                  CommonText(
                    text: event!.title,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'PlayfairDisplay',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    bottom: 8.h,
                  ),

                  /// Location
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.white70, size: 14),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: CommonText(
                          text: event!.location,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.8),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  /// Action Button
                  GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('https://www.engsportsevents.co.uk/category/all-products');
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor, // Reverted to Primary Black
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppString.viewDetails,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
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
