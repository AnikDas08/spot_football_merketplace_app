import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';



class CompareInfoCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text;

  const CompareInfoCard({super.key,  this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.colorEABB00, width: 1.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                AppIcons.question,
                width: 24.w,
                height: 24.h,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: CommonText(
                text:
                    text ??
                    "You can select the same player twice to compare their stats from different seasons.",
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryColor,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
