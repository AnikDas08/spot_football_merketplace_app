import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/temp_image.dart';
class PlayerHeaderWidget extends StatelessWidget {
  final String playerName;
  final String position;
  final String? profileImage;

  const PlayerHeaderWidget({
    super.key,
    this.playerName = 'Emerson Royal',
    this.position = 'Forward',
    this.profileImage,
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
                      fontSize: 16,
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
          child: profileImage != null && profileImage!.isNotEmpty
              ? CommonImage(
                  imageSrc: profileImage!,
                  height: 230.h,
                  width: 200.w,
                  fill: BoxFit.contain,
                )
              : Image.asset(
                  TempImage.playerWithFootball,
                  height: 230.h,
                  fit: BoxFit.fill,
                ),
        ),
      ],
    );
  }
}
