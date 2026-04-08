import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.8.sw,
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfile(),
              SizedBox(height: 36.h),
              _buildMenuItem(
                icon: AppIcons.editProfile,
                label: AppString.editProfile,
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              _buildMenuItem(
                icon: AppIcons.rewards,
                label: AppString.rewardsRedemption,
                onTap: () => Get.toNamed(AppRoutes.shopScreen),
              ),
              _buildMenuItem(
                icon: AppIcons.subscription,
                label: AppString.mySubscriptions,
                onTap: () => Get.toNamed(AppRoutes.mySubscription),
              ),
              _buildMenuItem(
                icon: AppIcons.transferHistory,
                label: AppString.myTransfersHistory,
                onTap: () => Get.toNamed(AppRoutes.transferHistoryScreen),
              ),
              _buildMenuItem(
                icon: AppIcons.lockPassword,
                label: AppString.changePassword,
                onTap: () => Get.toNamed(AppRoutes.changePassword),
              ),
              _buildMenuItem(
                icon: AppIcons.infoPolicy,
                label: AppString.privacyPolicy,
                onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
              ),
              const Spacer(),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundImage: const AssetImage(TempImage.profile),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppIcons.editPencil,
                  width: 12.w,
                  height: 12.h,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        CommonText(
          text: 'Jane Cooper',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: 'janecooper@gmail.com',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryColor,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.iconBgYellow,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: const ColorFilter.mode(
                      AppColors.yellow,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonText(
                    text: label,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.start,
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.chevronRight,
                  width: 18.w,
                  height: 18.h,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(color: AppColors.colorCCCCCC.withValues(alpha: 0.5), height: 1),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.logoutRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        icon: SvgPicture.asset(
          AppIcons.logoutIcon,
          width: 20.w,
          height: 20.h,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
        label: CommonText(
          text: AppString.logout,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
