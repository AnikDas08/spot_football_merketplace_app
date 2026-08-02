import 'package:eng_sports/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
import 'package:google_fonts/google_fonts.dart';

class LeagueHeaderWidget extends StatelessWidget {
  final String? teamName;
  final String? teamLogo;
  final String? subtitle;

  const LeagueHeaderWidget({
    super.key,
    this.teamName,
    this.teamLogo,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.banner),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // 1. Top-only Gradient Layer for text contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6],
              ),
            ),
          ),
          // 2. Content Layer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: teamLogo != null && teamLogo!.isNotEmpty
                      ? CommonImage(
                          imageSrc: teamLogo!,
                          width: 88.w,
                          height: 88.h,
                          fill: BoxFit.cover,
                        )
                      : Image.asset(
                          TempImage.league,
                          width: 88.w,
                          height: 88.h,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teamName ?? 'Phoenix Utds',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 20.r,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: CommonText(
                              text: subtitle ?? 'Founded 1902',
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
