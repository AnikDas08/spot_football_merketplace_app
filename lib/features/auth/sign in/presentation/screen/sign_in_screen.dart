import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';
import '../../../sign in/presentation/widgets/do_not_account.dart';
import '../widgets/signup_appbar.dart';

import '../../../../../../../utils/constants/app_images.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: SignupAppbar(),
      body: Stack(
        fit: .expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/auth_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<SignInController>(
            builder: (controller) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100.h),
                      const CommonText(
                        text: 'Login',
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        color: Colors.white,
                        bottom: 10,
                      ),

                      const CommonText(
                        text:
                            'Welcome back to the ENG. Access your stats and roster.',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        color: Colors.white70,
                        bottom: 32,
                      ),

                      CommonTextField(
                        title: "Email Address",
                        titleColor: Colors.white,
                        controller: controller.emailController,
                        hintText: 'Enter credentials',
                        validator: AppValidation.email,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        textColor: Colors.white,
                      ),

                      SizedBox(height: 24.h),
                      CommonTextField(
                        title: "Password",
                        titleColor: Colors.white,
                        controller: controller.passwordController,
                        isPassword: true,
                        hintText: 'Password',
                        validator: AppValidation.password,
                        fillColor: Colors.white.withValues(alpha: 0.1),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 12.h),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                          child: const Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white70,
                              decorationThickness: 2,
                              fontFamily: 'SFProDisplay',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      CommonButton(
                        titleText: 'Login',
                        isLoading: controller.isLoading,
                        onTap: () => controller.isLoading
                            ? null
                            : _formKey.currentState!.validate()
                            ? controller.signInUser()
                            : null,
                      ),

                      40.height,

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.3),
                              thickness: 1,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: CommonText(
                              text: 'or',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white.withValues(alpha: 0.3),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      40.height,

                      const DoNotHaveAccount(),

                      20.height,
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.colorEABB00,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 22.h, width: 22.w),
            12.width,
            CommonText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
