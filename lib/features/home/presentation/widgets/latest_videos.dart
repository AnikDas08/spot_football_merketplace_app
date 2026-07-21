import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../component/blur_reveal/blur_reveal.dart';
import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_icons.dart';
import '../../../../utils/constants/app_string.dart';
import '../controllers/banner_controller.dart';

import '../../data/video_model.dart';
import 'latest_video_card.dart';

class LatestVideos extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  final List<VideoModel>? videos;
  const LatestVideos({super.key, this.title, this.titleColor, this.videos});

  @override
  State<LatestVideos> createState() => _LatestVideosState();
}

class _LatestVideosState extends State<LatestVideos> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  final RxInt _currentPage = 0.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final bannerController = Get.find<BannerController>();
        final sourceVideos = widget.videos ?? bannerController.bannerVideos;
        final int totalItems = sourceVideos.length > 5 ? 5 : sourceVideos.length;

        if (totalItems > 1) {
          int nextPage = _currentPage.value + 1;
          if (nextPage >= totalItems) {
            nextPage = 0;
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          } else {
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());

    return BlurReveal(
      key: ValueKey('${widget.title ?? 'latest_videos'}_reveal'),
      duration: const Duration(milliseconds: 800),
      initialBlur: 10,
      child: Obx(() {
        final sourceVideos = widget.videos ?? bannerController.bannerVideos;

        if (bannerController.isLoading.value && sourceVideos.isEmpty) {
          return _buildShimmer();
        }

        if (sourceVideos.isEmpty) {
          return const SizedBox.shrink();
        }

        final displayList = sourceVideos.length > 5 ? sourceVideos.take(5).toList() : sourceVideos;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonText(
                      text: widget.title != null
                          ? widget.title.toString().toUpperCase()
                          : AppString.latestVideos.toUpperCase(),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: widget.titleColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.allVideos, arguments: {
                        'title': widget.title ?? AppString.latestVideos,
                        'videos': widget.videos,
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CommonText(
                          text: AppString.viewAll,
                          fontWeight: const FontWeight(500),
                          fontSize: 14,
                          color: widget.titleColor == AppColors.white ? AppColors.yellow : AppColors.primaryColor,
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(
                          AppIcons.arrowRight,
                          colorFilter: ColorFilter.mode(
                            widget.titleColor == AppColors.white ? AppColors.yellow : AppColors.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            /// Carousel Slider using PageView
            SizedBox(
              width: double.infinity,
              height: 460.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: displayList.length,
                onPageChanged: (index) => _currentPage.value = index,
                itemBuilder: (context, index) {
                  final video = displayList[index];
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      try {
                        if (_pageController.hasClients && _pageController.page != null) {
                          value = _pageController.page! - index;
                          value = (1 - (value.abs() * 0.05)).clamp(0.0, 1.0);
                        }
                      } catch (_) {}
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
                displayList.length,
                (index) => _buildDot(index == _currentPage.value),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDot(bool isActive) {
    final bool isDarkBackground = widget.titleColor == AppColors.white;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: isActive ? 24.w : 8.w,
      decoration: BoxDecoration(
        color: isActive
            ? (isDarkBackground ? AppColors.yellow : AppColors.primaryColor)
            : (isDarkBackground
                ? AppColors.white.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.3)),
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
