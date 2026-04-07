import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';


class TransferFeeCard extends StatelessWidget {
  final String feeAmount;
  final String subTitle;
  final String? title;

  const TransferFeeCard({
    super.key,
    required this.feeAmount,
    required this.subTitle,
    this.title = "TRANSFER FEE",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CommonText(
            text: title!,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),

          CommonText(
            text: feeAmount,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),

          SizedBox(height: 8.h),

          CommonText(
            text: subTitle,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color6B6B6B,
          ),
        ],
      ),
    );
  }
}