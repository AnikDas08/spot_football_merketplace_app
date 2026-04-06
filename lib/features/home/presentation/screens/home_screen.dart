import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/banner_slider.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import '../../../../component/common_appbar/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: CommonText(text: AppString.home, fontSize: 20.sp),
            ),
            SizedBox(height: 20.h),

            // Carousel
           BannerSlider(),

            SizedBox(height: 12.h),

            // Page Indicator

          ],
        ),
      ),
    );
  }
}

