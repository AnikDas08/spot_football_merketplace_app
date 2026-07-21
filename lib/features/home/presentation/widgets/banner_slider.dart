import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/custom_shimmer/custom_shimmer.dart';
import '../controllers/banner_controller.dart';
import 'banner_card.dart';
import 'banner_slider_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.find<BannerController>();
    return Obx(() {
      if (bannerController.isLoading.value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomShimmer.rectangular(height: 224.h),
        );
      }

      if (bannerController.bannerVideos.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          SizedBox(
            height: 224.h,
            child: PageView.builder(
              pageSnapping: false,
              padEnds: false,
              controller: bannerController.pageController,
              itemCount: bannerController.bannerVideos.length,
              itemBuilder: (context, index) {
                final video = bannerController.bannerVideos[index];
                return BannerCard(
                  videoModel: video,
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const BannerSliderIndicator(),
        ],
      );
    });
  }
}
