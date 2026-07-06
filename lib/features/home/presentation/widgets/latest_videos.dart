import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/component/custom_shimmer/custom_shimmer.dart';
import 'package:untitled/config/api/api_end_point.dart';

import '../controllers/banner_controller.dart';

class LatestVideos extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  const LatestVideos({super.key, this.title, this.titleColor});

  @override
  State<LatestVideos> createState() => _LatestVideosState();
}

class _LatestVideosState extends State<LatestVideos> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  final RxInt _currentPage = 0.obs;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());

    return Obx(() {
      if (bannerController.isLoading.value && bannerController.bannerVideos.isEmpty) {
        return _buildShimmer();
      }

      if (bannerController.bannerVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CommonText(
              text: widget.title != null
                  ? widget.title.toString().toUpperCase()
                  : AppString.latestVideos.toUpperCase(),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              color: widget.titleColor,
            ),
          ),
          SizedBox(height: 16.h),
          
          /// Carousel Slider using PageView
          SizedBox(
            width: double.infinity,
            height: 460.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: bannerController.bannerVideos.length,
              onPageChanged: (index) => _currentPage.value = index,
              itemBuilder: (context, index) {
                final video = bannerController.bannerVideos[index];
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.05)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 450.h,
                          width: double.infinity,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: LatestVideoCard(
                    videoId: video.id,
                    imagePath: video.videoUrl.isNotEmpty
                        ? "${ApiEndPoint.imageUrl}${video.thumbnail}"
                        : 'https://images.unsplash.com/photo-1551958219-acbc630e2914?w=600',
                    title: video.title,
                    category: video.category,
                    description: video.description,
                    time: video.publishDateTime,
                    duration: "0:00", // Hardcoded as API doesn't provide it
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 16.h),

          /// Custom Pagination Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              bannerController.bannerVideos.length,
              (index) => _buildDot(index == _currentPage.value),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.grey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomShimmer.rectangular(height: 24.h, width: 150.w),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 450.h,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.92),
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: const LatestVideoCard(
                imagePath: "",
                title: "",
                category: "",
                description: "",
                time: "",
                duration: "",
                isLoading: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
