import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/common_appbar/secondary_appbar.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class MyChildrenScreen extends StatelessWidget {
  const MyChildrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SecondaryAppBar(title: AppString.myChildren),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            _buildActiveAthletesHeader(),
            SizedBox(height: 24.h),
            _buildChildCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAthletesHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.yellow,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: AppString.activeAthletes,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            bottom: 8,
          ),
          CommonText(
            text: AppString.manageYourChildrenSports,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundImage: const AssetImage(TempImage.profile),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Emerson Royal",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _buildBadge("John Doe"),
                        SizedBox(width: 8.w),
                        _buildBadge("Tigers FC", isTeam: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: AppString.nextGame,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondaryColor,
                    ),
                    CommonText(
                      text: "Sat, 10:00 AM",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.myProfile),
                  child: Row(
                    children: [
                      CommonText(
                        text: AppString.viewProfile,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 4.w),
                      const Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, {bool isTeam = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isTeam ? const Color(0xFFE8F9F1) : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isTeam) ...[
            const Icon(Icons.sports_soccer, size: 14, color: Color(0xFF19CA77)),
            SizedBox(width: 4.w),
          ],
          CommonText(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isTeam ? const Color(0xFF19CA77) : AppColors.textSecondaryColor,
          ),
        ],
      ),
    );
  }
}
