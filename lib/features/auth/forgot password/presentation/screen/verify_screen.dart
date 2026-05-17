import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../component/text_field/common_pin_code_field.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../sign in/presentation/widgets/signup_appbar.dart';
import '../../../sign up/presentation/controller/sign_up_controller.dart';
import '../controller/forget_password_controller.dart';
import '../../../../../../../utils/constants/app_colors.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  late bool isSignUp;

  @override
  void initState() {
    isSignUp = Get.arguments?['isSignUp'] ?? false;
    if (isSignUp) {
      if (Get.isRegistered<SignUpController>()) {
        SignUpController.instance.startTimer();
      }
    } else {
      if (Get.isRegistered<ForgetPasswordController>()) {
        ForgetPasswordController.instance.startTimer();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const SignupAppbar(),
      body: isSignUp
          ? GetBuilder<SignUpController>(builder: (controller) => _buildBody(controller))
          : GetBuilder<ForgetPasswordController>(builder: (controller) => _buildBody(controller)),
    );
  }

  Widget _buildBody(dynamic controller) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            const CommonText(
              text: "Verify Account",
              fontSize: 40,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.start,
              color: AppColors.black,
              bottom: 10,
            ),
            const CommonText(
              text: 'We sent a code to your email',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
              maxLines: 3,
              color: AppColors.black,
              bottom: 32,
            ),
            SizedBox(height: 20.h),
            Card(
              elevation: 2,
              color: const Color(0xffFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 48.h, bottom: 48.h),
                child: Column(
                  children: [
                    Center(
                      child: CommonPinCodeField(
                        length: 6,
                        controller: controller.otpController,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.filledColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time_filled_rounded,
                            color: AppColors.green,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          CommonText(
                            text: controller.time,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: controller.time == '00:00'
                          ? () {
                              controller.resendOtp();
                            }
                          : () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Didn't receive a code? ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: "Resend Code",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 36.h),
                    CommonButton(
                      titleText: "Verify",
                      isLoading: controller.isLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          controller.verifyOtp();
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
    );
  }
}
