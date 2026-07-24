import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/banner_controller.dart';
import '../widgets/latest_video_card.dart';

class AllVideosScreen extends StatelessWidget {
  const AllVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerController>();
    final dynamic args = Get.arguments;
    final String title = (args is Map && args.containsKey('title')) 
        ? args['title'] 
        : AppString.latestVideos;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: SecondaryAppBar(title: title.toUpperCase()),
      body: Obx(() {
        if (controller.isLoading.value && controller.bannerVideos.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.bannerVideos.isEmpty) {
          return const Center(child: Text("No videos available"));
        }

        return RefreshIndicator(
          onRefresh: () => controller.fetchBannerVideos(),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(16.w),
                  itemCount: controller.bannerVideos.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final video = controller.bannerVideos[index];
                    return BlurReveal(
                      duration: const Duration(milliseconds: 500),
                      initialBlur: 5,
                      child: LatestVideoCard(
                        videoId: video.id,
                        imagePath: video.videoUrl.isNotEmpty
                            ? "${ApiEndPoint.imageUrl}${video.thumbnail}"
                            : 'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600',
                        title: video.title,
                        category: video.category,
                        description: video.description,
                        time: video.publishDateTime,
                        duration: "0:00",
                      ),
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
