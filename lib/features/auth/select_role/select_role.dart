import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../sign in/presentation/widgets/signup_appbar.dart';

class SelectRole extends StatelessWidget {
  SelectRole({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Inject or find your controller
    final controller = Get.put(RoleSelectController());

    return Scaffold(
      appBar: SignupAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              const CommonText(
                text: 'Select Your Role',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                bottom: 10,
              ),
              const CommonText(
                text: 'Please Select One Of The Following Which Applies To You...',
                fontSize: 16,
                maxLines: 3,
                color: AppColors.black,
                bottom: 32,
              ),

              // --- Player Selection ---
              Obx(() => GestureDetector(
                onTap: () => controller.selectRole(1),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: controller.selectedRole.value == 1
                          ? AppColors.primaryColor // Selected color
                          : Colors.transparent,    // Unselected color
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.r),
                    child: CommonImage(
                      imageSrc: "assets/images/select_player.png",
                      height: 124.h,
                      width: double.infinity,
                      fill: BoxFit.cover,
                    ),
                  ),
                ),
              )),

              SizedBox(height: 20.h),

              // --- Manager Selection ---
              Obx(() => GestureDetector(
                onTap: () => controller.selectRole(2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: controller.selectedRole.value == 2
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9.r),
                    child: CommonImage(
                      imageSrc: "assets/images/select_manager.png",
                      height: 124.h,
                      width: double.infinity,
                      fill: BoxFit.cover,
                    ),
                  ),
                ),
              )),

              SizedBox(height: 40.h),

              // --- Dynamic Continue Button ---
              Obx(() => CommonButton(
                onTap: () async{
                  if (controller.selectedRole.value == 1) {
                    LocalStorage.role="Player";
                    await LocalStorage.setString(LocalStorageKeys.role, LocalStorage.role);
                    print("Role : ${LocalStorage.role}");
                    Get.toNamed(AppRoutes.player_registration_screen);
                  } else if (controller.selectedRole.value == 2) {
                    LocalStorage.role=="Manager";
                    await LocalStorage.setString(LocalStorageKeys.role, LocalStorage.role);
                    print("Role : ${LocalStorage.role}");
                    Get.toNamed(AppRoutes.manager_subscription_screen);
                  } else {
                    Get.snackbar("Selection Required", "Please select a role to continue");
                  }
                },
                // Optional: Change button opacity if nothing is selected
                buttonColor: controller.selectedRole.value == 0
                    ? Colors.grey
                    : AppColors.primaryColor,
                titleText: "Continue",
                titleColor: controller.selectedRole.value == 0
                    ? Colors.black
                    : AppColors.white,
              )),

              SizedBox(height: 20.h),

              const Center(
                child: CommonText(
                  text: "You can switch your primary role\nlater in settings.",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  color: AppColors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RoleSelectController extends GetxController {
  // 0 for none, 1 for Player, 2 for Manager
  var selectedRole = 0.obs;

  void selectRole(int index) {
    selectedRole.value = index;
  }
}



