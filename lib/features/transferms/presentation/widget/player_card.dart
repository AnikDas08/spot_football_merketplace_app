import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class PlayerCard extends StatelessWidget {
  final String imageUrl;
  final String status;
  final String position;
  final int age;
  final String playerName;
  final String academyName;
  final String price;
  final VoidCallback? onTap;

  const PlayerCard({
    super.key,
    required this.imageUrl,
    required this.status,
    required this.position,
    required this.age,
    required this.playerName,
    required this.academyName,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w,
        height: 195.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            // Background Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 280.w,
                height: 195.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => CustomShimmer.rectangular(height: 195.h),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
            
            // Gradient Overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),

            // Card Content
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: CommonText(
                      text: status,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),

                  // Position and Age
                  Text(
                    '$position • $age Yrs',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.6,
                    ),
                  ),

                  // Player Name
                  CommonText(
                    text: playerName,
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  SizedBox(height: 6.h),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        child: CommonText(
                          text: academyName,
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      CommonText(
                        text: '$price Coins',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
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
