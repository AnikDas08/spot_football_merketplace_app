import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/component/image/common_image.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/services/storage/storage_keys.dart';
import 'package:untitled/services/storage/storage_services.dart';
import 'package:untitled/features/auth/sign%20up/presentation/controller/manager_registation_controller.dart';
import 'package:untitled/features/auth/sign%20up/presentation/controller/verify_player_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';

class ManagerRegistationScreen extends StatelessWidget {
  ManagerRegistationScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: SignupAppbar(),
      body: GetBuilder<ManagerRegistationController>(
        init: ManagerRegistationController(),
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: 'Become an ENG\nManager',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    bottom: 10,
                  ),
                  const CommonText(
                    text: 'Create your account and start managing your team today!',
                    fontSize: 16,
                    maxLines: 5,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    bottom: 32,
                  ),

                  CommonTextField(
                    title: "Player First Name",
                    controller: controller.playerFirstName,
                    hintText: 'Enter your first name here...',
                    validator: AppValidation.required,
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Player Last Name",
                    controller: controller.playerLastName,
                    hintText: 'Enter your last name here...',
                    validator: AppValidation.required,
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Email Address",
                    controller: controller.emailAddress,
                    hintText: 'Enter your email address here...',
                    validator: AppValidation.email,
                  ),
                  SizedBox(height: 24.h),

                  CommonTextField(
                    title: "Phone Number",
                    controller: controller.emailAddress,
                    hintText: 'Enter your phone number here...',
                    validator: AppValidation.email,
                  ),

                  SizedBox(height: 30.h),
                  CommonText(
                    text: "DBS Certificate",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                    bottom: 10,
                  ),


                  /// ── Image Upload Section ──
                  GestureDetector(
                    onTap: () => controller.pickIdImage(),
                    child: Container(
                      width: double.infinity,
                      height: 156.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: controller.pickedImage != null
                            ? Image.file(controller.pickedImage!, fit: BoxFit.cover)
                            : Center(
                          child: CommonImage(
                            imageSrc: "assets/images/upload_file_image.png",
                            width: double.infinity,
                            height: 156.h,
                            fill: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40,),

                  CommonButton(
                    titleText: "Submit Request",
                    //isLoading: controller.isLoading,
                    onTap: () async {
                      // Simulating API call
                      await Future.delayed(const Duration(seconds: 1));
                      
                      // Save role to local storage
                      LocalStorage.role = "Manager";
                      await LocalStorage.setString(LocalStorageKeys.role, LocalStorage.role);

                      Get.toNamed(AppRoutes.successful_create_account);
                    },
                  ),

                  SizedBox(height: 32.h),
                  const Center(
                    child: CommonText(
                      text: 'By submitting, you agree to the\nAthlete Terms of Service',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      color: Color(0xff373737),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}