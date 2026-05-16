import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/features/auth/sign%20in/presentation/widgets/signup_appbar.dart';
import '../../../../../../../utils/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../component/text_field/common_text_field.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/helpers/validation.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_string.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        appBar: SignupAppbar(),

        /// body section
        body: SingleChildScrollView(
          padding: .symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 12.h,),

              const CommonText(
                text: 'Forget\nPassword',
                fontSize: 40,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.start,
                color: AppColors.black,
                bottom: 10,
              ),

              /// ── Subtitle ──
              const CommonText(
                text: 'Enter your credentials to receive a high-velocity security code.',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 4,
                color: AppColors.primaryColor,
                bottom: 32,
              ),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    /// forget password take email for reset Password
                    CommonTextField(
                      title: "Email Address",
                      controller: controller.emailController,
                      hintText: 'Enter your email address here',
                      validator: AppValidation.email,
                    ),
                    SizedBox(height: 40.h,),
                CommonButton(
                  titleText: AppString.continues,
                  isLoading: controller.isLoading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.sendForgetPasswordEmail();
                    }
                  },
                ),
                    SizedBox(height: 50,),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Remember Me? ",
                          style: GoogleFonts.plusJakartaSans(
                            color: Color(0xff373737),
                            fontSize: 16,
                            fontWeight: .w500,
                          ),
                        ),

                        /// Sign Up Button here
                        TextSpan(
                          text: "Go Back",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.signUp);
                            },
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,      // underline
                            decorationColor: AppColors.primaryColor,   // underline color
                            decorationThickness: 2,                    // optional thickness
                          ),
                        ),
                      ],
                    ),
                    textAlign: .center,
                  ),
                )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
