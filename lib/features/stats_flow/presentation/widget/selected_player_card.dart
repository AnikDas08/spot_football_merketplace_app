import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_colors.dart';
import '../model/player_model.dart';

class SelectedPlayerCard extends StatelessWidget {
  final PlayerModel player;
  const SelectedPlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColors.colorEABB00, width: 1.w),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Image.asset(
            player.image,
            height: 160.h,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              player.name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}