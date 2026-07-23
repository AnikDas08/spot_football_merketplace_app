import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/common_appbar/secondary_appbar.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../services/storage/storage_services.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/change_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (LocalStorage.isGuest) {
      return const Scaffold(body: Center(child: Text("Login Required")));
    }
    return Scaffold(
      appBar: SecondaryAppBar(title: AppString.changePassword),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  const CommonText(
                    text: 'Update Credentials',
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                  const CommonText(
                    text: 'Ensure your performance data remains secure with a high-entropy password.',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                  ),

                  SizedBox(height: 40.h),

                  /// current Password section
                  CommonTextField(
                    title: AppString.currentPassword,
                    controller: controller.currentPasswordController,
                    hintText: AppString.currentPassword,
                    validator: AppValidation.password,
                    isPassword: true,
                  ),

                  SizedBox(height: 20.h),

                  CommonTextField(
                    title: AppString.newPassword,
                    controller: controller.newPasswordController,
                    hintText: AppString.newPassword,
                    validator: AppValidation.password,
                    isPassword: true,
                  ),

                  SizedBox(height: 20.h),

                  CommonTextField(
                    title: AppString.confirmPassword,
                    controller: controller.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    validator: (value) => AppValidation.confirmPassword(
                      value,
                      controller.newPasswordController,
                    ),
                    isPassword: true,
                  ),

                  /// forget Password button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: CommonText(
                        text: AppString.forgotPassword,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        top: 16.h,
                        bottom: 20.h,
                      ),
                    ),
                  ),

                  /// submit Button
                  CommonButton(
                    titleText: AppString.confirm,
                    isLoading: controller.isLoading,
                    onTap: () {
                      controller.changePasswordRepo();
                    },
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
