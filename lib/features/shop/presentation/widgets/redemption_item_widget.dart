import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class RedemptionItemWidget extends StatelessWidget {
  final String? title;
  final String? image;
  final String? coins;

  const RedemptionItemWidget({super.key, this.title, this.image, this.coins});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          CommonText(
            text: title ?? AppString.engWristBand,
            fontSize: 14.sp,
            fontWeight: const FontWeight(600),
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 8.h),
          const Divider(),
          SizedBox(height: 8.h),
          Image.asset(image ?? TempImage.product, height: 70.h),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: AppString.totalCoins,
                fontSize: 14.sp,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
              CommonText(
                text: coins ?? '5000',
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CommonText(
              text: AppString.redeem,
              fontSize: 15.sp,
              fontWeight: const FontWeight(600),
              color: AppColors.white,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
