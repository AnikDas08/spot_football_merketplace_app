import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/utils/constants/app_images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled/component/text/common_text.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_colors.dart';
import 'package:untitled/utils/constants/app_icons.dart';
import 'package:untitled/utils/constants/app_string.dart';
import 'package:untitled/utils/constants/temp_image.dart';

import '../../../../component/image/common_image.dart';
import '../../../../services/storage/storage_keys.dart';
import '../../../auth/sign in/presentation/controller/sign_in_controller.dart';
import '../../../navbar/controller/navbar_controller.dart';
import '../../../profile/presentation/controller/profile_controller.dart';

import 'package:untitled/component/blur_reveal/blur_reveal.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final String role = LocalStorage.role;

    return Drawer(
      width: 0.9.sw,
      backgroundColor: AppColors.white,
      child: BlurReveal(
        duration: const Duration(milliseconds: 600),
        initialBlur: 10,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildProfile(profileController),
                        SizedBox(height: 36.h),
                        if (!LocalStorage.isGuest) ...[
                          _buildMenuItem(
                            label: AppString.editProfile,
                            onTap: () => Get.toNamed(AppRoutes.editProfile),
                          ),
                        ],
                        if (!LocalStorage.isGuest) ...[
                          if (role == "REFEREE") ...[
                            _buildMenuItem(
                              label: "Referee Dashboard",
                              onTap: () =>
                                  Get.toNamed(AppRoutes.refereeDashboardScreen),
                            ),
                          ],
                          if (role == "PLAYER") ...[
                            _buildMenuItem(
                              label: AppString.myPlayer,
                              onTap: () => Get.toNamed(AppRoutes.myChildren),
                            ),
                            _buildMenuItem(
                              label: AppString.rewardsRedemption,
                              onTap: () => Get.toNamed(AppRoutes.shopScreen),
                            ),
                            _buildMenuItem(
                              label: AppString.mySubscriptions,
                              onTap: () => Get.toNamed(AppRoutes.mySubscription),
                            ),
                          ],
                          if (role == "MANAGER") ...[
                            _buildMenuItem(
                              label: "Team Sheet",
                              onTap: () => Get.toNamed(AppRoutes.teamSheetScreen),
                            ),
                            _buildMenuItem(
                              label: AppString.myTransfersHistory,
                              onTap: () =>
                                  Get.toNamed(AppRoutes.transferRequestScreen),
                            ),
                            _buildMenuItem(
                              label: AppString.trialListAvailable,
                              onTap: () =>
                                  Get.toNamed(AppRoutes.trialList),
                            ),
                          ],
                          _buildMenuItem(
                            label: AppString.changePassword,
                            onTap: () => Get.toNamed(AppRoutes.changePassword),
                          ),
                        ],
                        _buildMenuItem(
                          label: "Book a Scout",
                          onTap: () async {
                            final Uri url = Uri.parse('https://www.engsportsevents.co.uk/category/all-products');
                            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                        ),
                        if (LocalStorage.isGuest) ...[
                          _buildMenuItem(
                            label: "Fixtures",
                            onTap: () => Get.find<NavBarController>().selectedIndex.value = 1,
                          ),
                          _buildMenuItem(
                            label: "League Tables",
                            onTap: () => Get.find<NavBarController>().selectedIndex.value = 2,
                          ),
                          _buildMenuItem(
                            label: "ENG TV",
                            onTap: () => Get.find<NavBarController>().selectedIndex.value = 3,
                          ),
                          _buildMenuItem(
                            label: "Statistics",
                            onTap: () => Get.find<NavBarController>().selectedIndex.value = 4,
                          ),
                        ],
                        _buildMenuItem(
                          label: AppString.privacyPolicy,
                          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                        ),
                        _buildMenuItem(
                          label: AppString.termsOfServices,
                          onTap: () => Get.toNamed(AppRoutes.termsOfServices),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(ProfileController controller) {
    final data = controller.profileData;
    final bool isGuest = LocalStorage.isGuest;
    
    final String name = isGuest ? "Guest User" : (data['fullName'] ?? LocalStorage.myName);
    final String email = isGuest ? "" : (data['email'] ?? LocalStorage.myEmail);
    final String image = isGuest ? "" : (data['profile'] ?? LocalStorage.myImage);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.color6B6B6B.withValues(alpha: 0.1),
              child: ClipOval(
                child: CommonImage(
                  imageSrc: image.isEmpty ? AppImages.appLogo : image,
                  height: 100.r,
                  width: 100.r,
                  fill: image.isEmpty ? .contain : BoxFit.cover,
                ),
              ),
            ),
            if (!isGuest)
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
          text: name.isEmpty ? 'User Name' : name,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        CommonText(
          text: email.isEmpty ? '' : email,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondaryColor,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 8.w, top: 14.h, bottom: 14.h),
            child: Row(
              children: [
                Expanded(
                  child: CommonText(
                    text: label,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
    final bool isGuest = LocalStorage.isGuest;
    
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: () {
          if (isGuest) {
             LocalStorage.setBool(LocalStorageKeys.isGuest, false);
             Get.offAllNamed(AppRoutes.onboarding);
             return;
          }
          Get.dialog(
            AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await LocalStorage.removeAllPrefData();
                    Get.delete<SignInController>(force: true);
                    Get.offAllNamed(AppRoutes.onboarding);
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isGuest ? AppColors.primaryColor : AppColors.logoutRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        icon: isGuest 
          ? const Icon(Icons.login, color: Colors.white, size: 20)
          : SvgPicture.asset(
              AppIcons.logoutIcon,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
        label: CommonText(
          text: isGuest ? "Login / Sign Up" : AppString.logout,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
