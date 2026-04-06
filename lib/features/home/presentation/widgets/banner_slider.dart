import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:untitled/features/home/presentation/widgets/banner_card.dart';
import 'package:untitled/features/home/presentation/widgets/banner_slider_indicator.dart';

import '../controllers/banner_controller.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.find<BannerController>();
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          height: 224.h,
          child: PageView.builder(
            pageSnapping: false,
            padEnds: false,
            controller: bannerController.pageController,
            itemCount: bannerController.heroSlides.length,
            itemBuilder: (context, index) {
              final slider = bannerController.heroSlides[index];
              return BannerCard(
                sliderModel: slider,
              );
            },
          ),
        ),
        BannerSliderIndicator(),
      ],
    );
  }
}
