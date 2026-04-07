import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/features/home/presentation/widgets/latest_video_card.dart';
import 'package:untitled/utils/constants/app_string.dart';

class LatestVideos extends StatelessWidget {
  const LatestVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          CommonText(
            text: AppString.latestNews.toUpperCase(),
            fontSize: 20.sp,
            fontWeight: FontWeight(590),
          ),

          Column(
            crossAxisAlignment: .start,
            children: [
              ...List.generate(
                5,
                (index) => LatestVideoCard(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
