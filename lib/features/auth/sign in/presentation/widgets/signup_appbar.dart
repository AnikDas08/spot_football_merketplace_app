import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_images.dart';

class SignupAppbar extends StatelessWidget implements PreferredSizeWidget {

  const SignupAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        bottom: 10.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        children: [

          /// ⬅️ Custom Back Button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.color2A2A2A,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// CENTER LOGO ⭐
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Image.asset(
                  AppImages.appLogo,
                  height: 30.h,
                ),
              ),
            ),
          ),

          /// RIGHT SIDE EMPTY TO BALANCE BACK BUTTON
          SizedBox(width: 90.w), // Adjust this based on back button width
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}