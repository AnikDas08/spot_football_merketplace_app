import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class PlayerHeaderWidget extends StatelessWidget {
  final String playerName;
  final String position;

  const PlayerHeaderWidget({
    super.key,
    this.playerName = 'Emerson Royal',
    this.position = 'Forward',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 262.h,
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff8E7BFF), Color(0xffFF6EC7)],
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: playerName,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: position,
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: const FontWeight(500),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            TempImage.playerWithFootball,
            height: 230.h,
            fit: .fill,
          ),
        ),
      ],
    );
  }
}
