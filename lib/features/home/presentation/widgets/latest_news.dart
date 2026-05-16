import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/api/api_end_point.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/news/presentation/controller/news_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_string.dart';

class LatestNews extends StatelessWidget {
  const LatestNews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonText(
                text: AppString.latestNews.toUpperCase(),
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              if (controller.isLoading.value && controller.newsList.isEmpty) {
                return SizedBox(
                  height: 248.h,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              
              if (controller.newsList.isEmpty) {
                return SizedBox(
                  height: 248.h,
                  child: const Center(child: CommonText(text: "No News Available")),
                );
              }

              return SizedBox(
                height: 248.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.newsList.length,
                  padding: EdgeInsets.only(left: 16.w),
                  itemBuilder: (context, index) {
                    final news = controller.newsList[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: NewsCard(
                        width: 230.w,
                        newsModel: news,
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
