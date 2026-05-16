import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/config/route/app_routes.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/image/common_image.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_images.dart';
import '../../../../../../../utils/constants/app_string.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F3F3),
      appBar: SignupAppbar(),

      /// Body Section starts here
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: 'Reset Password',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                  color: AppColors.black,
                  bottom: 10,
                ),

                /// ── Subtitle ──
                const CommonText(
                  text: 'Enter your new credentials below. Choose a high-performance password to secure your player profile.',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  color: AppColors.primaryColor,
                  bottom: 32,
                ),
                SizedBox(height: 20.h,),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      CommonTextField(
                        title: "Password",
                        controller: controller.passwordController,
                        isPassword: true,
                        hintText: 'Password',
                        validator: AppValidation.password,
                      ),

                      SizedBox(height: 20,),

                      CommonTextField(
                        title: "Confirm Password",
                        controller: controller.confirmPasswordController,
                        isPassword: true,
                        hintText: 'Confirm Password',
                        validator: AppValidation.password,
                      ),

                      64.height,
                      CommonButton(
                        titleText: "Update Password",
                        isLoading: controller.isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            controller.resetPassword();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
