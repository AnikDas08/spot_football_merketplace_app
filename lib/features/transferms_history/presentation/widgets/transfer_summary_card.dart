import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';

class TransferSummaryCard extends StatelessWidget {
  const TransferSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'TOTAL EXPENDITURE',
            fontSize: 14.sp,
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight(510),
          ),
          SizedBox(height: 8.h),
          CommonText(
            text: '€42,500,000',
            fontSize: 32.sp,
            fontWeight: FontWeight(590),
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 14.h),
          Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: FractionallySizedBox(
              widthFactor: .6,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}