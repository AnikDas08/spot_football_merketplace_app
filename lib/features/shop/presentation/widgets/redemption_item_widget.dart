import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class RedemptionItemWidget extends StatelessWidget {
  const RedemptionItemWidget({super.key});

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
            text: 'ENG WRIST BAND',
            fontSize: 14.sp,
            fontWeight: FontWeight(590),
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 8.h),
          Divider(),
          SizedBox(height: 8.h),
          Image.asset(
            TempImage.product,
            height: 70.h,
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonText(
                text: 'Total Coins: ',
                fontSize: 16.sp,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w400,
              ),
              CommonText(
                text: '5000',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.yellow,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: CommonText(
              text: 'Redeem',
              fontSize: 15.sp,
              fontWeight: FontWeight(510),
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}