import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/sign_up_controller.dart';

class SignUpAllField extends StatelessWidget {
  const SignUpAllField({super.key, required this.controller});

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        /// User Name here
        CommonTextField(
          title: "User name",
          controller: controller.nameController,
          hintText: 'Enter full name here',
          validator: AppValidation.required,
        ),
        SizedBox(height: 24,),
        /// User Email here
        CommonTextField(
          title: "Email Address",
          controller: controller.emailController,
          hintText: 'Enter credentials',
          validator: AppValidation.email,
        ),

        SizedBox(height: 24.h,),

        CommonTextField(
          title: "Password",
          controller: controller.passwordController,
          isPassword: true,
          hintText: 'Enter Password',
          validator: AppValidation.password,
        ),

        SizedBox(height: 24,),

        CommonTextField(
          title: "Confirm Password",
          controller: controller.confirmPasswordController,
          isPassword: true,
          hintText: 'Enter Confirm Password',
          validator: (value) => AppValidation.confirmPassword(
            value,
            controller.passwordController,
          ),
        ),

        /// User Confirm Password here
        /*const CommonText(text: AppString.confirmPassword, bottom: 8, top: 12),
        CommonTextField(
          controller: controller.confirmPasswordController,
          isPassword: true,
          hintText: AppString.confirmPassword,
          validator: (value) => AppValidation.confirmPassword(
            value,
            controller.passwordController,
          ),
        ),*/
      ],
    );
  }
}
