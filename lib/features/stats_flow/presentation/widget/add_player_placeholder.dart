import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/utils/constants/app_icons.dart';

import '../../../../component/text/common_text.dart';
import '../../../../utils/constants/app_colors.dart';

class AddPlayerPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final String textLeft;

  final String textRight;

  const AddPlayerPlaceholder({
    super.key,
    this.width,
    this.height,
    required this.onTap,
    this.textLeft = "Click",
    this.textRight = "to add player",
  });

  @override
  Widget build(BuildContext context) {
    final double defaultHeight = 200.h;

    final double standardRadius = 12.r;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(standardRadius),

      child: Container(
        height: height ?? defaultHeight,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(standardRadius),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                AppIcons.addButton,

                width: 40.w,
                height: 40.h,
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.black,

                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(standardRadius),
                  bottomRight: Radius.circular(standardRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: textLeft,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 6.w),

                  SvgPicture.asset(
                    AppIcons.addButton,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  CommonText(
                    text: textRight,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}
