import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/presentation/widgets/news_card.dart';
import 'package:untitled/features/news/presentation/controller/news_controller.dart';


import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  final RxInt _currentPage = 0.obs;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value && controller.newsList.isEmpty) {
            return _buildShimmer();
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
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 16.h),
              
              /// Carousel Slider using PageView
              SizedBox(
                width: .infinity,
                height: 460.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: controller.newsList.length,
                  onPageChanged: (index) => _currentPage.value = index,
                  itemBuilder: (context, index) {
                    final news = controller.newsList[index];
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
                      child: NewsCard(
                        newsModel: news,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16.h),

              /// Custom Pagination Dots
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.newsList.length,
                  (index) => _buildDot(index == _currentPage.value),
                ),
              )),
            ],
          );
        });
      },
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              child: NewsCard(isLoading: true),
            ),
          ),
        ),
      ],
    );
  }
}
