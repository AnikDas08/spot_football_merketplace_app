import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/news/presentation/controller/news_controller.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: AppString.latestNews.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.newsList.isEmpty) {
          return const Center(child: Text("No news available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchNews(),
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.newsList.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final news = controller.newsList[index];
              return NewsCard(newsModel: news);
            },
          ),
        );
      }),
    );
  }
}
