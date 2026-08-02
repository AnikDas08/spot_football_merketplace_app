import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../component/image/common_image.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_images.dart';

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
        // 1. Background Image Layer
        Container(
          height: 250.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.playerSeason),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // 2. Dark Shadow Overlay (Top to Bottom)
        Container(
          height: 250.h,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.8),
                Colors.transparent,
              ],
            ),
          ),
        ),

        // 3. Text Content Layer (On Top of Shadow)
        Container(
          height: 250.h,
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    CommonText(
                      text: playerName,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.h),
                    CommonText(
                      text: position,
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w400,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 4. Player Cutout Profile Image
        Positioned(
          right: 0,
          bottom: 0,
          child: CommonImage(
            imageSrc: profileImage ?? "",
            height: 230.h,
            width: 200.w,
            fill: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
