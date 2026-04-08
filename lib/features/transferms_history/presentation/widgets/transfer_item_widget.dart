import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

import '../../../../utils/constants/temp_image.dart';

class TransferItemWidget extends StatelessWidget {
  const TransferItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 4.w, color: AppColors.yellow),
        ),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            padding: .all(10),
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(TempImage.playerWithFootball, fit: .contain),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CommonText(
                      text: 'FORWARD',
                      fontSize: 10.sp,
                      color: AppColors.green,
                      fontWeight: FontWeight(700),
                    ),
                    SizedBox(width: 6.w),
                    CommonText(
                      text: '• VOLTAGE UNITED FC',
                      fontSize: 10,
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight(590),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: 'Marcus Vane',
                  fontSize: 18.sp,
                  fontWeight: FontWeight(700),
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    CommonText(
                      text: '€68.5M',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 110.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: CommonText(
                        text: 'Completed',
                        fontSize: 11,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
