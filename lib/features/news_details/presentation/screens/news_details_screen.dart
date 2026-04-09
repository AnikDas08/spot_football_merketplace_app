import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_news.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.newsDetails.toUpperCase()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: .symmetric(horizontal: 28.w, vertical: 32.h),
              width: 1.sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: .fill,
                  image: AssetImage(AppImages.newsDetailsBg),
                ),
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: AppString.transfer,
                    fontSize: 16.sp,
                    fontWeight: FontWeight(510),
                    color: AppColors.white,
                  ),
                  CommonText(
                    text: AppString.engCommunityAcademyStarOfTheWeek,
                    fontSize: 32.sp,
                    fontWeight: FontWeight(590),
                    maxLines: 3,
                    color: AppColors.white,
                    textAlign: .start,
                  ),
                  CommonText(
                    text: "04 Jan 2025",
                    fontSize: 16.sp,
                    fontWeight: FontWeight(510),
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            Image.asset(TempImage.newsDetails, fit: .fill, width: 1.sw),
            Padding(
              padding: .all(16),
              child: SizedBox(
                width: 1.sw,
                child: Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: .circular(16.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      spacing: 10,
                      children: [
                        CommonText(
                          text: AppString
                              .thisWeekWereProudToCelebrateLeoAsOurStarOfTheWeek,
                          fontSize: 16.sp,
                          fontWeight: FontWeight(510),
                          color: AppColors.color373737,
                          maxLines: 2,
                          textAlign: .start,
                          letterSpacing: 1.sp,
                        ),
                        CommonText(
                          text: AppString
                              .leoHasShownOutstandingDedicationEffortAndAFantasticAttitudeBothOnAndOffTheField,
                          fontSize: 16.sp,
                          fontWeight: FontWeight(510),
                          color: AppColors.color373737,
                          maxLines: 7,
                          textAlign: .start,
                          letterSpacing: 1.sp,
                        ),
                        CommonText(
                          text: AppString.whetherItsHisEnergyDuring,
                          fontSize: 16.sp,
                          fontWeight: FontWeight(510),
                          color: AppColors.color373737,
                          maxLines: 7,
                          textAlign: .start,
                          letterSpacing: 1.sp,
                        ),
                        CommonText(
                          text: AppString
                              .keepUpTheAmazingWorkLeoYourHardWorkIsPayingOffWeExcitedToSeeYourContinuedProgress,
                          fontSize: 16.sp,
                          fontWeight: FontWeight(510),
                          color: AppColors.color373737,
                          maxLines: 7,
                          textAlign: .start,
                          letterSpacing: 1.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: .all(16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: AppString.related,
                    fontSize: 20.sp,
                    fontWeight: FontWeight(590),
                    textAlign: .start,
                  ),
                  NewsCard(),
                  NewsCard(),
                  NewsCard(),
                  NewsCard(),
                ],
              ),
            ),
            Padding(
              padding: .all(16),
              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  CommonText(
                    text: AppString.latestVideos,
                    fontSize: 20.sp,
                    fontWeight: FontWeight(590),
                    textAlign: .start,
                  ),
                  LatestVideoCard(),
                  LatestVideoCard(),
                  LatestVideoCard(),
                  LatestVideoCard(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
