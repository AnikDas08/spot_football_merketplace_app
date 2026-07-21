import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../../utils/constants/temp_image.dart';
import '../../../home/presentation/widgets/latest_news.dart';
import '../../../home/presentation/widgets/latest_videos.dart';
import '../../../news/data/models/news_model.dart';
import '../../../news/presentation/controller/news_controller.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final NewsModel? news = Get.arguments as NewsModel?;
    if (news != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.find<NewsController>().fetchSingleNews(news.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.newsDetails.toUpperCase()),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          final NewsModel? news =
              controller.singleNews.value ?? (Get.arguments as NewsModel?);

          if (controller.isDetailLoading.value &&
              controller.singleNews.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                    vertical: 32.h,
                  ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                      CommonText(
                        text:
                            news?.title ??
                            AppString.engCommunityAcademyStarOfTheWeek,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        maxLines: 3,
                        color: AppColors.white,
                        textAlign: TextAlign.start,
                      ),
                      CommonText(
                        text: news != null
                            ? DateFormat(
                                'dd MMM yyyy',
                              ).format(news.publishDateTime)
                            : "04 Jan 2025",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text:
                                  news?.description ??
                                  AppString
                                      .thisWeekWereProudToCelebrateLeoAsOurStarOfTheWeek,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
                const LatestVideos(),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
