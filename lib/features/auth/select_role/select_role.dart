import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/utils/constants/app_images.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../sign in/presentation/widgets/signup_appbar.dart';

class SelectRole extends StatelessWidget {
  SelectRole({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoleSelectController());

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              const CommonText(
                text: 'Select Your Role',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                bottom: 8,
              ),
              const CommonText(
                text:
                    'Please Select One Of The Following Which Applies To You - All Registrations Pending ENG Admin Approval',
                fontSize: 14,
                maxLines: 3,
                fontWeight: FontWeight.w400,
                color: AppColors.color6B6B6B,
                bottom: 24,
                textAlign: TextAlign.start,
              ),

              // --- Player Selection ---
              Obx(
                () => _RoleCard(
                  title: 'PLAYER',
                  subtitle: 'Register For A Club For The\n26/27 Season',
                  imagePath: AppImages.appLogo,
                  iconColor: const Color(0xFF19CA77),
                  isSelected: controller.selectedRole.value == 1,
                  onTap: () => controller.selectRole(1),
                ),
              ),

              SizedBox(height: 16.h),

              // --- Find a Team (Trial) ---
              Obx(
                () => _RoleCard(
                  title: 'FIND A TEAM (TRIAL)',
                  subtitle: 'Create a profile and get\ndiscovered by clubs',
                  imagePath: AppImages.appLogo,
                  iconColor: const Color(0xFF131B6A),
                  isSelected: controller.selectedRole.value == 3,
                  onTap: () => controller.selectRole(3),
                ),
              ),

              SizedBox(height: 16.h),

              // --- Manager Selection ---
              Obx(
                () => _RoleCard(
                  title: 'MANAGER',
                  subtitle: 'Manage team & transfers',
                  imagePath: AppImages.appLogo,
                  iconColor: const Color(0xFFFF0000),
                  isSelected: controller.selectedRole.value == 2,
                  onTap: () => controller.selectRole(2),
                ),
              ),

              SizedBox(height: 16.h),

              // --- Referee Selection ---
              Obx(
                () => _RoleCard(
                  title: 'REFEREE',
                  subtitle: 'Manage match reporting, disciplinary actions, and earn certifications within the global officiating network.',
                  imagePath: AppImages.appLogo,
                  iconColor: const Color(0xFFEABB00),
                  isSelected: controller.selectedRole.value == 4,
                  onTap: () => controller.selectRole(4),
                ),
              ),

              SizedBox(height: 40.h),

              // --- Continue Button ---
              Obx(
                () => CommonButton(
                  onTap: () async {
                    LocalStorage.getValue("role") ?? "Player";

                    if (controller.selectedRole.value == 1) {
                      LocalStorage.setString(LocalStorageKeys.role,"Player");
                      Get.toNamed(AppRoutes.player_registration_screen);
                    } else if (controller.selectedRole.value == 3) {
                      Get.toNamed(AppRoutes.trial_registration_screen);
                    } else if (controller.selectedRole.value == 2) {
                      LocalStorage.setString(LocalStorageKeys.role,"Manager");
                      Get.toNamed(AppRoutes.manager_subscription_screen);
                    } else if (controller.selectedRole.value == 4) {
                      LocalStorage.setString(LocalStorageKeys.role, "Referee");
                      Get.toNamed(AppRoutes.referee_info_screen); // Adjust if there's a specific referee reg screen
                    } else {
                      Get.snackbar(
                        "Selection Required",
                        "Please select a role to continue",
                      );
                    }
                  },
                  buttonColor: controller.selectedRole.value == 0
                      ? Colors.grey.shade400
                      : AppColors.black,
                  titleText: "Continue",
                  titleColor: AppColors.white,
                ),
              ),

              SizedBox(height: 24.h),

              const Center(
                child: CommonText(
                  text: "You can switch your primary role\nlater in settings.",
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  color: AppColors.color6B6B6B,
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    this.imagePath,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Background
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Image.asset(
                    imagePath ?? AppImages.appLogo,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  CommonText(
                    text: subtitle,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color6B6B6B,
                    maxLines: 4,
                    textAlign: TextAlign.start,
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

class RoleSelectController extends GetxController {
  // 0: none, 1: Player, 2: Manager, 3: Find a team (Trial)
  var selectedRole = 0.obs;

  void selectRole(int index) {
    selectedRole.value = index;
    print("Role selected: $index");
  }
}
