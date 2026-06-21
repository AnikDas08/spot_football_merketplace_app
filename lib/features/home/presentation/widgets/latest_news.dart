import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/news/presentation/controller/news_controller.dart';


import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_string.dart';

class LatestNews extends StatelessWidget {
  const LatestNews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value && controller.newsList.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 248.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    padding: EdgeInsets.only(left: 16.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: NewsCard(
                          width: 230.w,
                          isLoading: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          
          if (controller.newsList.isEmpty) {
            return const SizedBox.shrink();
          }

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
              SizedBox(
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
              ),
            ],
          );
        });
      },
    );
  }
}
