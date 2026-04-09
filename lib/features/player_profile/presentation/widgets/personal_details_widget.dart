import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

class PersonalDetailsWidget extends StatelessWidget {
  const PersonalDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              CommonText(
                text: 'PERSONAL DETAILS',
                fontSize: 20.sp,
                fontWeight: FontWeight(590),
                color: AppColors.primaryColor,
              ),
              Image.asset(AppImages.approved, width: 54.w, height: 32.h),
            ],
          ),
          SizedBox(height: 16.h),
          _item('Nationality', 'Italy'),
          _item('Club', 'TITANS FC'),
          _item('Position', 'Forward'),
          _item('ENG Debut', '7 August 2025'),
          _item('ENG Coins', '100000'),
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        children: [
          Expanded(
            child: CommonText(
              text: title,
              fontSize: 15.sp,
              fontWeight: FontWeight(510),
              color: AppColors.color373737,
              textAlign: TextAlign.start,
            ),
          ),
          CommonText(
            text: value,
            fontSize: 15.sp,
            fontWeight: FontWeight(510),
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
