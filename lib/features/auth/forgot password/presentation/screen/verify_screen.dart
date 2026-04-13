import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/constants/app_string.dart';

class VerifyScreen extends StatelessWidget {
  VerifyScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: SignupAppbar(),
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SingleChildScrollView(
          padding: .symmetric(vertical: 24.h, horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Instruction text
                SizedBox(height: 20,),
                /// Sign UP Instructions here
                const CommonText(
                  text: "Verify Account",
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.start,
                  color: AppColors.black,
                  bottom: 10,
                ),

                /// ── Subtitle ──
                const CommonText(
                  text: 'We sent a code to your email',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 20,),

                Card(
                  elevation: 2,
                  color: Color(0xffFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 48,bottom: 48),
                    child: Column(
                      children: [
                        /// PIN Code Fields - 4 boxes only
                        Center(
                          child: PinCodeTextField(
                            controller: controller.otpController,
                            autoDisposeControllers: false,
                            cursorColor: AppColors.black,
                            appContext: context,
                            autoFocus: true,
                            pinTheme: PinTheme(
                              //shape: PinCodeFieldShape.roundedBox,
                              borderRadius: BorderRadius.circular(8.r),
                              fieldHeight: 50.h,
                              fieldWidth: 50.w,
                              activeFillColor: const Color(0xFFD4AF37), // Gold filled when selected
                              selectedFillColor: const Color(0xFFD4AF37), // Gold filled when selected
                              inactiveFillColor: AppColors.white, // White when inactive
                              borderWidth: 2.w,
                              selectedColor: const Color(0xFFD4AF37), // Gold border when selected
                              activeColor: const Color(0xFFD4AF37), // Gold border when active
                              inactiveColor: const Color(0xFFD4AF37), // Gold border when inactive
                            ),
                            length: 4, // Only 4 boxes
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUnfocus,
                            enableActiveFill: true,
                            //spacing: 12.w, // Space between fields
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        /// Timer Display
                        CommonText(
                          text: controller.time,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),

                        SizedBox(height: 24.h),

                        /// Resend Text
                        GestureDetector(
                          onTap: controller.time == '00:00'
                              ? () {
                            controller.startTimer();
                            //controller.signUpUser();
                          }
                              : () {},
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Didn't receive a code? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF373737),
                                  ),
                                ),
                                TextSpan(
                                  text: controller.time == '00:00'
                                      ? AppString.resendCode
                                      : AppString.resendCode,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: controller.time == '00:00'
                                        ? AppColors.primaryColor
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 36.h,),
                        CommonButton(
                          titleText: "Verify Button",
                          //isLoading: controller.isLoadingVerify,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Get.toNamed(AppRoutes.createPassword);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
