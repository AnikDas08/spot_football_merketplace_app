import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/component/button/common_button.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class ContractDurationResultCard extends StatelessWidget {
  final String durationTitle;
  final String yearsText;
  final String dateText;
  final String iconPath;

  const ContractDurationResultCard({
    super.key,
    this.durationTitle = "CONTRACT DURATION",
    required this.yearsText,
    required this.dateText,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFC5B4FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(AppIcons.calendar),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonText(
                  text: durationTitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
                Row(
                  children: [
                    CommonText(
                      text: yearsText,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 2.w),
                    CommonText(
                      text: "($dateText)",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.color6B6B6B,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SvgPicture.asset(iconPath, width: 40.w, height: 40.w),




        ],
      ),
    );
  }
}
