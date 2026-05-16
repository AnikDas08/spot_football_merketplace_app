import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/utils/constants/app_string.dart';

import 'package:untitled/utils/constants/temp_image.dart';

class LatestVideos extends StatelessWidget {
  const LatestVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CommonText(
            text: AppString.latestVideos.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(

          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: EdgeInsets.only(left: 16.w),
            itemBuilder: (context, index) {
              return LatestVideoCard(
                imageHeight: 100.h,
                titleFontSize: 14.sp,
                timeFontSize: 14.sp,
                imagePath: index % 2 == 0 ? TempImage.stats1 : TempImage.stats2,
                title: AppString.top10GoalsWeek24,
                time: AppString.threeHourAgoEngOriginal,
                duration: AppString.duration7m,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 12.w);
            },
          ),
        ),
      ],
    );
  }
}
