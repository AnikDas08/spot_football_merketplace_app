import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../home/presentation/widgets/news_card.dart';
import '../controller/news_controller.dart';

class AllNewsScreen extends StatelessWidget {
  const AllNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();
    final dynamic args = Get.arguments;
    final String title = (args is Map && args.containsKey('title')) 
        ? args['title'] 
        : AppString.latestNews;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: title.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.newsList.isEmpty) {
          return const Center(child: Text("No news available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchNews(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(16.w),
                  itemCount: controller.newsList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final news = controller.newsList[index];
                    return BlurReveal(
                      duration: const Duration(milliseconds: 500),
                      initialBlur: 5,
                      child: NewsCard(newsModel: news),
                    );
                  },
                ),
              ),
              if (controller.isMoreLoading.value)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                ),
            ],
          ),
        );
      }),
    );
  }
}
