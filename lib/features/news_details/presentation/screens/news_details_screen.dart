import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/image/common_image.dart';
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
        physics: ClampingScrollPhysics(),
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
            CommonImage(
              imageSrc: TempImage.newsDetails,
              fill: BoxFit.fill,
              width: .infinity,
            ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CommonText(
                    text: AppString.related.toUpperCase(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 248.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    padding: EdgeInsets.only(left: 16.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: NewsCard(
                          width: 220.w,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CommonText(
                    text: AppString.latestVideos.toUpperCase(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 170.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    padding: EdgeInsets.only(left: 16.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: LatestVideoCard(
                          imageHeight: 130.h,
                          titleFontSize: 14.sp,
                          timeFontSize: 10.sp,
                          imagePath:
                              index % 2 == 0 ? TempImage.stats1 : TempImage.stats2,
                          title: AppString.top10GoalsWeek24,
                          time: AppString.threeHourAgoEngOriginal,
                          duration: AppString.duration7m,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
