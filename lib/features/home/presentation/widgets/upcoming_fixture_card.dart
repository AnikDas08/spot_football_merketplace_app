import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';

import '../../../../component/image/common_image.dart';

class UpcomingFixtureCard extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final String? homeLogo;
  final String? awayLogo;
  final String? venue;
  final double? width;

  const UpcomingFixtureCard({
    super.key,
    required this.id,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.time,
    this.homeLogo,
    this.awayLogo,
    this.venue,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.matchInfo,
          arguments: {'id': id, 'isUpcoming': true, 'time': time},
        );
      },
      child: Container(
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.colorEABB00, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
            children: [
              /// Date Header
              CommonText(
                text: date,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                bottom: 16.h,
              ),

              Row(
                children: [
                  /// Home Team
                  Expanded(
                    child: Column(
                      children: [
                        CommonImage(
                          imageSrc: homeLogo ?? "",
                          height: 48.h,
                          width: 48.w,
                          fill: BoxFit.contain,
                        ),
                        SizedBox(height: 8.h),
                        CommonText(
                          text: homeTeam,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  /// Time / VS
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: CommonText(
                      text: time,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),

                  /// Away Team
                  Expanded(
                    child: Column(
                      children: [
                        CommonImage(
                          imageSrc: awayLogo ?? "",
                          height: 48.h,
                          width: 48.w,
                          fill: BoxFit.contain,
                        ),
                        SizedBox(height: 8.h),
                        CommonText(
                          text: awayTeam,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (venue != null && venue!.isNotEmpty) ...[
                SizedBox(height: 12.h),
                CommonText(
                  text: venue!,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  maxLines: 1,
                ),
              ],

              SizedBox(height: 16.h),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionBtn(
                      "Match Info",
                      AppColors.primaryColor, // Reverted to black
                      AppColors.white,
                      true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildActionBtn(
    String title,
    Color bg,
    Color textCol,
    bool hasBorder,
  ) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: hasBorder ? Border.all(color: AppColors.colorEABB00) : null,
      ),
      alignment: Alignment.center,
      child: CommonText(
        text: title,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: textCol,
      ),
    );
  }
}
