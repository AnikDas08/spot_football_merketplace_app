import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/features/home/presentation/widgets/latest_news.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/news/data/models/news_model.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsModel? news = Get.arguments as NewsModel?;

    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.newsDetails.toUpperCase()),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 32.h),
              width: 1.sw,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(AppImages.newsDetailsBg),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: news?.category ?? AppString.transfer,
                    fontSize: 16.sp,
                    fontWeight:  FontWeight.w500,
                    color: AppColors.white,
                  ),
                  CommonText(
                    text: news?.title ?? AppString.engCommunityAcademyStarOfTheWeek,
                    fontSize: 32.sp,
                    fontWeight:  FontWeight.w600,
                    maxLines: 3,
                    color: AppColors.white,
                    textAlign: TextAlign.start,
                  ),
                  CommonText(
                    text: news != null 
                        ? DateFormat('dd MMM yyyy').format(news.publishDateTime)
                        : "04 Jan 2025",
                    fontSize: 16.sp,
                    fontWeight:  FontWeight.w500,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            CommonImage(
              imageSrc: news != null 
                  ? "${ApiEndPoint.imageUrl}${news.image}" 
                  : TempImage.newsDetails,
              fill: BoxFit.fill,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: 1.sw,
                child: Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: news?.description ?? AppString.thisWeekWereProudToCelebrateLeoAsOurStarOfTheWeek,
                          fontSize: 16.sp,
                          fontWeight:  FontWeight.w500,
                          color: AppColors.color373737,
                          textAlign: TextAlign.start,
                          letterSpacing: 1.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const LatestNews(),
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
