import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../../config/route/app_routes.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';
import '../../../../../../../utils/extensions/extension.dart';
import '../../../../../../../utils/helpers/validation.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../controller/sign_in_controller.dart';
import '../../../sign in/presentation/widgets/do_not_account.dart';
import '../widgets/signup_appbar.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignupAppbar(),
      body: GetBuilder<SignInController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ── Title ──
                  const CommonText(
                    text: 'Login',
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.start,
                    color: AppColors.black,
                    bottom: 10,
                  ),

                  /// ── Subtitle ──
                  const CommonText(
                    text: 'Welcome back to the ENG. Access your stats and roster.',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    color: AppColors.black,
                    bottom: 32,
                  ),


                  /// ── Email Field ──
                  CommonTextField(
                    title: "Email Address",
                    controller: controller.emailController,
                    hintText: 'Enter credentials',
                    validator: AppValidation.email,
                  ),
                  /// ── Password Field ──
                  CommonTextField(
                    title: "Password",
                    controller: controller.passwordController,
                    isPassword: true,
                    hintText: 'Password',
                    validator: AppValidation.password,
                  ),
                  SizedBox(height: 12.h,),

                  /// ── Forgot Password ──
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.red,                 // Text color
                        decoration: TextDecoration.underline, // Underline
                        decorationColor: AppColors.red,       // Underline color
                        decorationThickness: 2,               // (optional) underline thickness
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                    ),
                  ),
                  SizedBox(height: 20.h,),

                  /// ── Login Button ──
                  CommonButton(
                    titleText: 'Login',
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (!_formKey.currentState!.validate()) return;
                      controller.signInUser();
                    },
                  ),

                  40.height,

                  /// ── Divider with "or" ──
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.black.withOpacity(0.15),
                          thickness: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CommonText(
                          text: 'or',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.black.withOpacity(0.15),
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  40.height,

                  /// ── Google Button ──
                  _SocialButton(
                    icon: 'assets/images/google.png',
                    label: 'Log In With Google',
                    onTap: () {},
                  ),

                  12.height,

                  /// ── Apple Button ──
                  _SocialButton(
                    icon: 'assets/images/apple.png',
                    label: 'Log In With Apple',
                    onTap: () {},
                  ),

                  32.height,

                  /// ── Don't have an account ──
                  const DoNotHaveAccount(),

                  20.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ── Social Login Button ──────────────────────────────────────────────────────
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
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.black.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 22.h,
              width: 22.w,
            ),
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