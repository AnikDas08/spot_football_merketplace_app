import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../home/presentation/controllers/banner_controller.dart';
import '../../../home/presentation/widgets/latest_videos.dart';

class EngTvScreen extends StatelessWidget {
  const EngTvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> sectionBgColors =  [
      Colors.white,
      AppColors.black,
    ];

    return SafeArea(
      child: GetBuilder<BannerController>(
        builder: (controller) {
          if (controller.isLoading.value && controller.bannerVideos.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }

          final categories = controller.allCategories;
          if (categories.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => controller.fetchEngTvCategories(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 0.8.sh,
                  child: const Center(
                    child: CommonText(text: "No categories available"),
                  ),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchInitialHomeData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dynamic categories from API
                  ...List.generate(categories.length, (index) {
                    final category = categories[index];
                    
                    return Obx(() {
                      final videosInCat = controller.categoryVideosMap[category.id] ?? [];
                      final isCatLoading = controller.categoryLoadingMap[category.id] ?? false;
                      
                      if (isCatLoading && videosInCat.isEmpty) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.yellow));
                      }

                      if (videosInCat.isEmpty) return const SizedBox.shrink();

                      final bgColor = sectionBgColors[index % sectionBgColors.length];
                      final titleColor = bgColor == AppColors.black ? Colors.white : null;

                      // Use the first video of the first category as Featured if needed
                      // Or just show all categories as sections
                      return _buildSection(
                        backgroundColor: bgColor,
                        child: LatestVideos(
                          title: category.name,
                          titleColor: titleColor,
                          videos: videosInCat,
                        ),
                      );
                    });
                  }),
                  
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required Widget child,
    required Color backgroundColor,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: child,
    );
  }
}
