import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class TrialOfferCard extends StatelessWidget {
  final String playerImageUrl;
  final String title;
  final String matchPercentage;
  final String description;
  final VoidCallback onOfferTap;

  const TrialOfferCard({
    super.key,
    required this.playerImageUrl,
    required this.title,
    required this.matchPercentage,
    required this.description,
    required this.onOfferTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16, left: 16),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x1A000000),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Player Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  playerImageUrl,
                  width: 72.w,
                  height: 72.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),

              // 2. Details Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CommonText(
                            text:  title.toUpperCase(),

                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                            maxLines: 2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // Match Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4F7E6),
                            // Light green background
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '$matchPercentage MATCH',
                            style: TextStyle(
                              color: const Color(0xFF13C371),
                              // Darker green text
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    CommonText(text:
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                        fontSize: 13.sp,
                        color: AppColors.color6B6B6B,
                       textAlign: TextAlign.start,

                    ),
                  ],
                ),
              ),
            ],
          ),

          // Divider line
          Padding(padding: EdgeInsets.symmetric(vertical: 16.h)),

          // 3. Offer Trial Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: CommonButton(titleText: 'OFFER TRIAL',
              borderColor: AppColors.primaryColor,
              buttonColor: AppColors.primaryColor,
              onTap: onOfferTap,

            ),
          ),
        ],
      ),
    );
  }
}
