import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/sign_up_controller.dart';

class SignUpAllField extends StatelessWidget {
  const SignUpAllField({super.key, required this.controller, this.titleColor});

  final SignUpController controller;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// User Name here
        CommonTextField(
          title: "User name",
          titleColor: titleColor,
          controller: controller.nameController,
          hintText: 'Enter full name here',
          validator: AppValidation.required,
        ),
        SizedBox(height: 24.h),
        /// User Email here
        CommonTextField(
          title: "Email Address",
          titleColor: titleColor,
          controller: controller.emailController,
          hintText: 'Enter credentials',
          validator: AppValidation.email,
        ),

        SizedBox(height: 24.h),

        CommonTextField(
          title: "Password",
          titleColor: titleColor,
          controller: controller.passwordController,
          isPassword: true,
          hintText: 'Enter Password',
          validator: AppValidation.password,
        ),

        SizedBox(height: 24.h),

        CommonTextField(
          title: "Confirm Password",
          titleColor: titleColor,
          controller: controller.confirmPasswordController,
          isPassword: true,
          hintText: 'Enter Confirm Password',
          validator: (value) => AppValidation.confirmPassword(
            value,
            controller.passwordController,
          ),
        ),
      ],
    );
  }
}
