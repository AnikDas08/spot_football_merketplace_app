import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';

class RecentResultCard extends StatelessWidget {
  final String id;
  final String date;
  final String time;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String? homeLogo;
  final String? awayLogo;
  final double? width;

  const RecentResultCard({
    super.key,
    required this.id,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.time,
    this.homeLogo,
    this.awayLogo,
    this.width,
    this.isLive = false,
  });

  final bool isLive;

  bool get isLiveMatch => isLive || date.toUpperCase() == 'LIVE';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.matchInfo,
          arguments: {
            'id': id,
            'isUpcoming': isLiveMatch ? true : false,
          },
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    CommonText(
                      text: date,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isLiveMatch ? AppColors.color19CA77 : AppColors.primaryColor,
                      bottom: 12,
                    ),
                    Row(
                      children: [
                        // Home Team
                        Expanded(
                          child: Column(
                            children: [
                              CommonImage(
                                imageSrc: homeLogo ?? "",
                                width: 40.w,
                                height: 40.h,
                                fill: BoxFit.contain,
                              ),
                              const SizedBox(height: 4),
                              CommonText(
                                maxLines: 1,
                                text: homeTeam,
                                fontSize: 12,
                                fontWeight: const FontWeight(500),
                                color: AppColors.primaryColor,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Score pill
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CommonText(
                            text: '$homeScore - $awayScore',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),

                        // Away Team
                        Expanded(
                          child: Column(
                            children: [
                              CommonImage(
                                imageSrc: awayLogo ?? "",
                                width: 40.w,
                                height: 40.h,
                                fill: BoxFit.contain,
                              ),
                              const SizedBox(height: 4),
                              CommonText(
                                maxLines: 1,
                                text: awayTeam,
                                fontSize: 12,
                                fontWeight: const FontWeight(500),
                                color: AppColors.primaryColor,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isLiveMatch)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.color19CA77,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8.r),
                      ),
                    ),
                    child: const CommonText(
                      text: "LIVE",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
