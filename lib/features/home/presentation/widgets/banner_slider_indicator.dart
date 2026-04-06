import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled/utils/constants/app_colors.dart';

import '../controllers/banner_controller.dart';

class BannerSliderIndicator extends StatelessWidget {
  const BannerSliderIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.find<BannerController>();
    return Center(
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            bannerController.heroSlides.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: bannerController.currentPage.value == index
                    ? AppColors
                          .black // Gold for active
                    : AppColors.colorCCCCCC,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
