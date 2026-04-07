import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../component/text/common_text.dart';
import '../widgets/banner_slider.dart';
import '../widgets/latest_news.dart';
import '../widgets/recent_result.dart';
import '../../../../utils/constants/app_string.dart';
import '../../../../component/common_appbar/common_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CommonText(
                  text: AppString.home,
                  fontSize: 20.sp,
                  fontWeight: FontWeight(590),
                ),
              ),
              SizedBox(height: 20.h),
              BannerSlider(),
              SizedBox(height: 12.h),
              LatestNews(),
              SizedBox(height: 20.h),
              RecentResult()
            ],
          ),
        ),
      ),
    );
  }
}
