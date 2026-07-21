import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';

class BookScoutSection extends StatelessWidget {
  final Color? titleColor;
  const BookScoutSection({super.key, this.titleColor});

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://www.engsportsevents.co.uk/bookscout');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: "BOOK A SCOUT",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: titleColor,
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            height: 400.h,
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
                    child: CommonImage(
                      imageSrc: TempImage.playerWithFootball,
                      width: double.infinity,
                      height: double.infinity,
                      fill: BoxFit.contain,
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
                        /// Badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.colorEABB00,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: const CommonText(
                            text: "Professional Scouting",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        /// Headline
                        const CommonText(
                          text: "Showcase Your Talent to the Pros",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          bottom: 12,
                        ),

                        /// Description
                        CommonText(
                          text: "Book a professional scout to watch you play and provide expert feedback. Take the next step in your football career today.",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.8),
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          bottom: 24.h,
                          fontFamily: 'Montserrat',
                        ),

                        /// Book Button
                        GestureDetector(
                          onTap: _launchURL,
                          child: Container(
                            width: double.infinity,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor, // Reverted to Primary Black
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.colorEABB00, width: 1.w),
                            ),
                            alignment: Alignment.center,
                            child: const CommonText(
                              text: "Book Now",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
